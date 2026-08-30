# Production Cutover — Battery Usage Telemetry

This runbook moves the battery telemetry pipeline from staging
(`icd360sev_test_db` + `battery_usage_test.php`) to production.

Mirrors `server/api/security/PROD_CUTOVER.md`. The two pipelines share the
`*_test.php` auto-routing convention, so the steps are deliberately the same
shape — if you have done the TLS cutover, this holds no surprises.

**Prereq:** staging has been validated end-to-end. The client points at
`battery_usage_test.php` and rows are landing in
`icd360sev_test_db.battery_usage_segments`.

**Note on timing:** a client only produces a row after a *closed* measurement
window — the device has to be unplugged for a while and then either hit the
charger, roll over at six hours, or stop the app. Do not expect rows within
minutes of installing a build, the way TLS reports appear. Budget a day.

**Note on coverage:** unlike TLS telemetry, this pipeline is **consent-gated**.
It only measures on devices where the member answered yes to Claudiu's
diagnostic question (`diagnostic_enabled` in SharedPreferences); everyone else
collects nothing at all — not "collects but withholds". So the table covers a
self-selected subset, not the fleet, and a low row count is an expected
outcome rather than a fault. Two consequences worth keeping in mind when
reading the numbers:

- Absolute device counts say nothing about how many members are affected by a
  battery problem. Only the *rates* are meaningful, and only within the
  consenting subset.
- Members who consent skew helpful and engaged. The devices with the worst
  drain — old phones, aggressive OEM power management, people who never open
  dialogs — are the ones least likely to be represented. Treat the measured
  improvement as a lower bound on the real one, never as the fleet average.

---

## Order of operations

1. **Server: prod DB migration**
2. **Server: prod endpoint deploy**
3. **Server: cron entry**
4. **Client: flip endpoint URL + release**
5. **Verify + decommission staging**

Each step has a rollback at the bottom of the runbook.

---

## 1. Prod DB migration

```bash
# Backup prod DB before any DDL.
ssh -p 36000 root@icd360sev.icd360s.de \
  "mysqldump --single-transaction icd360sev_db > /var/backups/icd360sev_pre_battery_usage_$(date +%Y%m%d_%H%M%S).sql && \
   ls -la /var/backups/icd360sev_pre_battery_usage_*.sql"

# Apply migration.
scp -P 36000 migrations/2026_08_30_battery_usage.sql \
  root@icd360sev.icd360s.de:/tmp/battery_usage_migration.sql

ssh -p 36000 root@icd360sev.icd360s.de \
  "mysql icd360sev_db < /tmp/battery_usage_migration.sql && \
   mysql -e 'DESCRIBE icd360sev_db.battery_usage_segments;'"
```

Confirm the table exists in prod and that the four generated columns
(`drain_percent`, `drain_per_hour`, `avg_ma`, `requests_per_hour`) are present
and marked `STORED GENERATED`. If MariaDB rejects the generated columns, see
"Schema regression" below — the table is still usable without them, the
queries just have to compute the rates inline.

## 2. Prod endpoint deploy

```bash
scp -P 36000 server/api/telemetry/battery_usage.php \
  root@icd360sev.icd360s.de:/var/www/icd360sev.icd360s.de/api/telemetry/battery_usage.php

ssh -p 36000 root@icd360sev.icd360s.de \
  "mkdir -p /var/www/icd360sev.icd360s.de/api/telemetry && \
   chown nginx:nginx /var/www/icd360sev.icd360s.de/api/telemetry/battery_usage.php && \
   chmod 644 /var/www/icd360sev.icd360s.de/api/telemetry/battery_usage.php && \
   ls -la /var/www/icd360sev.icd360s.de/api/telemetry/"
```

The PHP file auto-routes to the prod DB when its filename does not end in
`_test`. No code change is needed between staging and prod copies.

Smoke test:

```bash
ssh -p 36000 root@icd360sev.icd360s.de '
  DK=$(mysql -N -e "SELECT device_key FROM icd360sev_db.device_keys WHERE is_active=1 LIMIT 1;")
  curl -sS -X POST https://icd360sev.icd360s.de/api/telemetry/battery_usage.php \
    -H "User-Agent: ICD360S-Mitglied/1.0" \
    -H "Content-Type: application/json" \
    -H "X-Device-Key: $DK" \
    -d "{\"device_id\":\"smoketest\",\"platform\":\"android\",\"segments\":[{\"started_at\":\"2026-08-30 08:00:00\",\"ended_at\":\"2026-08-30 11:00:00\",\"start_level\":88,\"end_level\":61,\"duration_ms\":10800000,\"network_requests\":690,\"ws_reconnects\":4,\"is_reliable\":true,\"closed_reason\":\"charging\"}]}"
'
```

Expect: `{"success":true,"inserted":1,"duplicates":0,"rejected":0,"env":"prod"}`.

Run the exact same command a second time. Expect
`"inserted":0,"duplicates":1` — that proves the `UNIQUE(device_id, started_at)`
idempotency guard works, which is what stops a client re-sending a queued batch
after a lost response from skewing every average built on this table.

Then confirm the generated columns computed:

```bash
ssh -p 36000 root@icd360sev.icd360s.de \
  "mysql -e 'SELECT drain_percent, drain_per_hour, requests_per_hour FROM icd360sev_db.battery_usage_segments WHERE device_id=\"smoketest\";'"
```

Expect `27`, `9.000`, `230.000`. Clean up the smoke-test row:

```bash
ssh -p 36000 root@icd360sev.icd360s.de \
  "mysql -e 'DELETE FROM icd360sev_db.battery_usage_segments WHERE device_id=\"smoketest\";'"
```

## 3. Cron entry

Deploy the cleanup script and schedule it daily at 03:35 — five minutes after
the TLS retention job, so the two never contend for the same table locks:

```bash
scp -P 36000 server/api/cron/cleanup_battery_usage.php \
  root@icd360sev.icd360s.de:/var/www/icd360sev.icd360s.de/api/cron/cleanup_battery_usage.php

ssh -p 36000 root@icd360sev.icd360s.de '
  chown nginx:nginx /var/www/icd360sev.icd360s.de/api/cron/cleanup_battery_usage.php
  chmod 644 /var/www/icd360sev.icd360s.de/api/cron/cleanup_battery_usage.php
  (crontab -l 2>/dev/null; echo "35 3 * * * /usr/local/bin/php /var/www/icd360sev.icd360s.de/api/cron/cleanup_battery_usage.php >> /var/www/icd360sev.icd360s.de/logs/cron_battery_retention.log 2>&1") | crontab -
  crontab -l | grep battery
'
```

## 4. Client: flip endpoint URL + release

In `lib/services/battery_usage_service.dart`, change the single endpoint
constant:

```diff
-  static const String _endpoint =
-      'https://icd360sev.icd360s.de/api/telemetry/battery_usage_test.php';
+  static const String _endpoint =
+      'https://icd360sev.icd360s.de/api/telemetry/battery_usage.php';
```

Then build and release a new app version through the normal channels
(F-Droid repo, direct APK, etc.). Existing app installs keep posting to
`_test.php` until they update — that's fine; staging will absorb them.

## 5. Verify + decommission staging

After the new client version reaches significant adoption (24-48h):

```bash
# Confirm prod is receiving windows.
ssh -p 36000 root@icd360sev.icd360s.de \
  "mysql -e 'SELECT COUNT(*) AS n, MIN(started_at) AS first, MAX(started_at) AS last FROM icd360sev_db.battery_usage_segments;'"

# Compare to staging (should plateau).
ssh -p 36000 root@icd360sev.icd360s.de \
  "mysql -e 'SELECT COUNT(*) AS n, MAX(started_at) AS last FROM icd360sev_test_db.battery_usage_segments;'"
```

Once staging traffic is negligible, decommission:

```bash
ssh -p 36000 root@icd360sev.icd360s.de '
  rm /var/www/icd360sev.icd360s.de/api/telemetry/battery_usage_test.php
  rm /var/www/icd360sev.icd360s.de/api/cron/cleanup_battery_usage_test.php
'
```

---

## Rollback

### Endpoint regression

```bash
ssh -p 36000 root@icd360sev.icd360s.de \
  "rm /var/www/icd360sev.icd360s.de/api/telemetry/battery_usage.php"
```

Clients get HTTP 404 and keep the windows in their local queue (capped at 200,
oldest dropped first). No data loss for anything recent. Roll forward by
re-deploying the fixed PHP.

### Schema regression

MariaDB before 10.2 cannot index `STORED GENERATED` columns, and some builds
reject the `NULLIF` division in them outright. If the migration fails there,
drop the four generated columns and the `idx_reliable_rate` index; every query
in "Reading the data" below then computes the rate inline instead. Nothing in
the client or the endpoint depends on them.

```bash
ssh -p 36000 root@icd360sev.icd360s.de \
  "mysql icd360sev_db -e 'DROP TABLE battery_usage_segments;' && \
   mysql icd360sev_db < /var/backups/icd360sev_pre_battery_usage_*.sql"
```

### Crontab entry

```bash
ssh -p 36000 root@icd360sev.icd360s.de \
  "crontab -l | grep -v cleanup_battery_usage | crontab -"
```

### Client rollback

Push a hotfix version that points back at `battery_usage_test.php`. Queued
windows on old installs continue to flow to staging in the meantime.

---

## Reading the data

The point of the table is a before/after comparison, not an absolute number.
Always filter on `is_reliable = 1` — the rest are windows too short or too
flat to carry a rate.

**Did an optimisation work?** Compare drain against app version, holding the
platform fixed:

```sql
SELECT app_version,
       COUNT(*)                  AS windows,
       COUNT(DISTINCT device_id) AS devices,
       ROUND(AVG(drain_per_hour), 2)    AS pct_per_hour,
       ROUND(AVG(requests_per_hour), 1) AS reqs_per_hour,
       ROUND(AVG(avg_ma), 1)            AS avg_ma
FROM battery_usage_segments
WHERE is_reliable = 1
  AND platform = 'android'
  AND started_at > NOW() - INTERVAL 30 DAY
GROUP BY app_version
ORDER BY app_version;
```

`avg_ma` is the column to trust on Android — it comes from the charge counter
and is not quantised to whole percent. `pct_per_hour` is the fallback for
every other platform.

**Is the drain actually caused by our network wakeups?** Bucket by request
rate; if the two columns rise together, the causal story holds:

```sql
SELECT FLOOR(requests_per_hour / 30) * 30 AS reqs_per_hour_bucket,
       COUNT(*)                    AS windows,
       ROUND(AVG(drain_per_hour), 2) AS pct_per_hour
FROM battery_usage_segments
WHERE is_reliable = 1 AND platform = 'android'
GROUP BY reqs_per_hour_bucket
ORDER BY reqs_per_hour_bucket;
```

**Has Android started throttling us?** `standby_bucket` at 40 (`rare`) or 45
(`restricted`) means the system has already classed the app as misbehaving and
is limiting its jobs, alarms and network — the same assessment that ultimately
feeds a Play Store battery warning:

```sql
SELECT standby_bucket, doze_exempt, COUNT(*) AS windows,
       ROUND(AVG(drain_per_hour), 2) AS pct_per_hour
FROM battery_usage_segments
WHERE is_reliable = 1 AND started_at > NOW() - INTERVAL 7 DAY
GROUP BY standby_bucket, doze_exempt
ORDER BY standby_bucket;
```

**Watch for measurement rot.** A rising share of `gap` means devices are being
suspended or killed mid-window and the numbers are getting less trustworthy:

```sql
SELECT closed_reason, COUNT(*) AS n,
       ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS pct
FROM battery_usage_segments
WHERE started_at > NOW() - INTERVAL 7 DAY
GROUP BY closed_reason ORDER BY n DESC;
```

---

## On-call signals to watch

| Signal | Where | What it means |
|---|---|---|
| `rejected` climbing in endpoint responses | `grep '\[battery_usage\]' /var/log/php-fpm/error.log` | Client is sending malformed windows — a client bug, or a clock skew problem in the field |
| `duplicates` >> `inserted` | Same | Clients cannot clear their queue: the response is being lost (proxy timeout, nginx buffer) even though the insert succeeded |
| Share of `closed_reason = 'gap'` above ~20% | Query above | Measurements are unreliable; suspect aggressive OEM task-killing before trusting any rate |
| `avg_ma` NULL for all Android rows | `SELECT COUNT(*) FROM battery_usage_segments WHERE platform='android' AND avg_ma IS NULL;` | `CHARGE_COUNTER` is not implemented on the devices in the field — fall back to `drain_per_hour` and widen the comparison window |
| Row count near zero after a release | Query in step 5 | Three possible causes, in order of likelihood: nobody has consented yet (expected on a fresh install base — the pipeline is consent-gated, see above); the endpoint flip did not ship; or `flush()` is never reached, so check that the 5-minute device-data timer still runs after backgrounding. Rule the first out before investigating the other two |
| Rows only from a handful of devices | `SELECT COUNT(DISTINCT device_id) FROM battery_usage_segments WHERE started_at > NOW() - INTERVAL 7 DAY;` | Normal for a consent-gated channel. Becomes a problem only when the count is too small to average over — below roughly 10 devices, treat any version-to-version difference as noise |
