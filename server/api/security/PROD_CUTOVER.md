# Production Cutover — TLS Failure Telemetry

This runbook moves the security telemetry pipeline from staging
(`icd360sev_test_db` + `tls_failure_test.php`) to production.

**Prereq:** staging has been validated end-to-end. The client points at
`tls_failure_test.php` and rows are landing in `icd360sev_test_db.tls_failures`.

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
  "mysqldump --single-transaction icd360sev_db > /var/backups/icd360sev_pre_tls_failures_$(date +%Y%m%d_%H%M%S).sql && \
   ls -la /var/backups/icd360sev_pre_tls_failures_*.sql"

# Apply migration.
scp -P 36000 migrations/2026_05_15_add_tls_failures.sql \
  root@icd360sev.icd360s.de:/tmp/tls_failures_migration.sql

ssh -p 36000 root@icd360sev.icd360s.de \
  "mysql icd360sev_db < /tmp/tls_failures_migration.sql && \
   mysql -e 'DESCRIBE icd360sev_db.tls_failures;'"
```

Confirm the table exists in prod and has the expected schema before
proceeding.

## 2. Prod endpoint deploy

```bash
scp -P 36000 server/api/security/tls_failure.php \
  root@icd360sev.icd360s.de:/var/www/icd360sev.icd360s.de/api/security/tls_failure.php

ssh -p 36000 root@icd360sev.icd360s.de \
  "chown nginx:nginx /var/www/icd360sev.icd360s.de/api/security/tls_failure.php && \
   chmod 644 /var/www/icd360sev.icd360s.de/api/security/tls_failure.php && \
   ls -la /var/www/icd360sev.icd360s.de/api/security/"
```

The PHP file auto-routes to the prod DB when its filename does not end in
`_test`. No code change is needed between staging and prod copies.

Smoke test:

```bash
ssh -p 36000 root@icd360sev.icd360s.de '
  DK=$(mysql -N -e "SELECT device_key FROM icd360sev_db.device_keys WHERE is_active=1 LIMIT 1;")
  curl -sS -X POST https://icd360sev.icd360s.de/api/security/tls_failure.php \
    -H "User-Agent: ICD360S-Mitglied/1.0" \
    -H "Content-Type: application/json" \
    -H "X-Device-Key: $DK" \
    -d "{\"device_id\":\"smoketest\",\"events\":[{\"failed_at\":\"2026-05-15 23:00:00\",\"host\":\"icd360sev.icd360s.de\"}]}"
'
```

Expect: `{"success":true,"inserted":1,"failed":0,"env":"prod"}`.

## 3. Cron entry

Deploy the cleanup script and schedule it daily at 03:30 (low-traffic window,
between the existing 03:00 jobs and morning use):

```bash
scp -P 36000 server/api/cron/cleanup_tls_failures.php \
  root@icd360sev.icd360s.de:/var/www/icd360sev.icd360s.de/api/cron/cleanup_tls_failures.php

ssh -p 36000 root@icd360sev.icd360s.de '
  chown nginx:nginx /var/www/icd360sev.icd360s.de/api/cron/cleanup_tls_failures.php
  chmod 644 /var/www/icd360sev.icd360s.de/api/cron/cleanup_tls_failures.php
  (crontab -l 2>/dev/null; echo "30 3 * * * /usr/local/bin/php /var/www/icd360sev.icd360s.de/api/cron/cleanup_tls_failures.php >> /var/www/icd360sev.icd360s.de/logs/cron_tls_retention.log 2>&1") | crontab -
  crontab -l | grep tls
'
```

## 4. Client: flip endpoint URL + release

In `lib/services/security_event_reporter.dart`, change the single endpoint
constant:

```diff
-  static const String _endpoint =
-      'https://icd360sev.icd360s.de/api/security/tls_failure_test.php';
+  static const String _endpoint =
+      'https://icd360sev.icd360s.de/api/security/tls_failure.php';
```

Then build and release a new app version through the normal channels
(F-Droid repo, direct APK, etc.). Existing app installs keep posting to
`_test.php` until they update — that's fine; staging will absorb them.

## 5. Verify + decommission staging

After the new client version reaches significant adoption (24-48h):

```bash
# Confirm prod is receiving events.
ssh -p 36000 root@icd360sev.icd360s.de \
  "mysql -e 'SELECT COUNT(*) AS n, MIN(reported_at) AS first, MAX(reported_at) AS last FROM icd360sev_db.tls_failures;'"

# Compare to staging (should plateau).
ssh -p 36000 root@icd360sev.icd360s.de \
  "mysql -e 'SELECT COUNT(*) AS n, MAX(reported_at) AS last FROM icd360sev_test_db.tls_failures;'"
```

Once staging traffic is negligible, decommission:

```bash
ssh -p 36000 root@icd360sev.icd360s.de '
  rm /var/www/icd360sev.icd360s.de/api/security/tls_failure_test.php
  rm /var/www/icd360sev.icd360s.de/api/cron/cleanup_tls_failures_test.php
  # Keep icd360sev_test_db around for emergency rollback target until next quarter.
'
```

---

## Rollback

### Endpoint regression

```bash
ssh -p 36000 root@icd360sev.icd360s.de \
  "rm /var/www/icd360sev.icd360s.de/api/security/tls_failure.php"
```

Clients will get HTTP 404 and keep events in the local queue. No data loss.
Roll forward by re-deploying the fixed PHP.

### Schema regression (rare)

```bash
ssh -p 36000 root@icd360sev.icd360s.de \
  "mysql icd360sev_db -e 'DROP TABLE tls_failures;' && \
   mysql icd360sev_db < /var/backups/icd360sev_pre_tls_failures_*.sql"
```

### Crontab entry

```bash
ssh -p 36000 root@icd360sev.icd360s.de \
  "crontab -l | grep -v cleanup_tls_failures | crontab -"
```

### Client rollback

Push a hotfix version that points back at `tls_failure_test.php`. Queued
events on old installs continue to flow to staging in the meantime.

---

## On-call signals to watch

| Signal | Where | What it means |
|---|---|---|
| `tls_failures` row count climbs >10× baseline | `SELECT COUNT(*) FROM icd360sev_db.tls_failures WHERE reported_at > NOW() - INTERVAL 1 HOUR;` | Possible coordinated attack, OR popular AV product update broke pinning detection |
| Many rows with same `presented_issuer` | `SELECT presented_issuer, COUNT(*) FROM icd360sev_db.tls_failures WHERE reported_at > NOW() - INTERVAL 24 HOUR GROUP BY presented_issuer ORDER BY 2 DESC LIMIT 10;` | An AV / corporate proxy is intercepting many users — likely benign but identifies the product |
| Same `network_ssid` repeated across multiple users | `SELECT network_ssid, COUNT(DISTINCT device_id) FROM icd360sev_db.tls_failures WHERE reported_at > NOW() - INTERVAL 24 HOUR AND network_ssid IS NOT NULL GROUP BY network_ssid HAVING COUNT(DISTINCT device_id) > 3;` | A hostile network in the wild — investigate |
| Endpoint 5xx in nginx logs | `/var/log/nginx/icd360sev.icd360s.de_error.log` | DB connection issue or PHP crash; check `error_log` for `[tls_failure]` lines |
