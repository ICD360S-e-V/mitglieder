# Log ingest endpoints

Two endpoints receive client logs. Both accept the same two payload shapes:

- `{v:1, iv, data}` — AES-256-GCM startup transcript from `StartupDiagnostics`
- `{mitgliedernummer, logs[...]}` — plain stream from `LoggerService`

| file | writes to |
|---|---|
| `mitglieder_windows.php` | `<webroot>/logs/mitglieder_windows/` (plain), `api/data/logs/mitglieder_windows/` (encrypted) |
| `mitglieder_android.php` | `<webroot>/logs/mitglieder_android/` (plain), `api/data/logs/mitglieder_android/` (encrypted) |

Both are now thin: they define `API_ACCESS`, pull in `config.php` and
`log_ingest_lib.php`, and call `log_ingest_handle('<platform>')`. Everything
else lives in the library.

⚠️ The two payload shapes land in **different directories**, and that stayed
that way on purpose. It is grown, not designed — but moving it moves where the
existing logs are, which is its own decision rather than a side effect of a
security fix.

## Why the shared library

Until 13.09.2026 the two endpoint files were identical character for character,
platform name aside. Two copies means the next hardening gets forgotten in one
of them **without anything failing**. That is exactly how the path traversal
below came to sit in both.

## History: the path traversal

```php
$mitgliedernummer = $data['mitgliedernummer'];        // straight from JSON
$filename = "$logsDir/{$mitgliedernummer}_$date.log"; // straight into a path
```

The endpoint is public, so a caller supplying `../..` wrote files anywhere nginx
could write. Confirmed against production before the fix: `../../../../tmp/pwned`
and `a/b` both returned 200. After the fix both return 400 and a legitimate
upload still returns 200.

The fix was applied directly to the server because these files existed **only**
there — nothing in the repo, so nothing to review, and a redeploy from any other
copy would have silently reinstated the hole. Committing them is what stops that
from happening again.

The guard whitelists rather than strips. A client sending anything else is
broken or hostile, and both deserve a visible 400 rather than being quietly
rewritten into some other member's log file.

## What the hardening of 13.09.2026 added

| | |
|---|---|
| `blockBrowserAccess()` | these were the only two endpoints in the API without it |
| no `Access-Control-Allow-Origin: *` | no browser calls this; the star invited every website to drive it from its visitors' browsers. Removing it makes the preflight fail, so the request never leaves the browser. Native clients are unaffected — CORS is a browser rule |
| 512 KiB body cap, read **before** `json_decode` | otherwise the sender decides how much memory the server spends |
| 500 entries per request | `_maxWarteschlange` in `lib/services/logger_service.dart`; more than that is not a client of this app |
| rate limit, 30 per 10 min | counted per device key, per IP only as a fallback — many members share one mobile-carrier NAT address, and an IP-only limit would lock them out of each other's quota. Expected traffic is 2 per window (`_uploadInterval` = 5 min) |
| 50 MiB per daily file | a sustained flood can no longer fill the disk |
| control characters stripped | the plain path writes one line per entry; a `\n` inside a message forged a second line that reads like a real entry, with a freely chosen timestamp, level and origin. Anyone reading logs as evidence was reading fiction |
| `metadata.json` under `flock` across read-modify-write | it is rewritten whole. Two concurrent uploads used to read the same state and both write theirs back; the loser could land mid-file, leaving invalid JSON |
| `X-Device-Key` accepted and recorded | the same key `telemetry/battery_usage.php` and `security/tls_failure.php` already require |

## The authorisation gap, and the two-stage plan

`LOG_INGEST_REQUIRE_DEVICE_KEY` in `log_ingest_lib.php` is still `false`.

**Stage 1 (now):** uploads without a valid device key are accepted **and**
recorded in the PHP-FPM error log:

```bash
grep 'log_ingest.*schluessellos' /var/log/php-fpm/error.log
```

**Stage 2:** once that line has stopped appearing for several days, the whole
fleet is on a build that sends the header — then set the constant to `true` and
redeploy the library. Not before: flipping it immediately silences exactly the
devices whose logs you want, because a client that is not updating is usually
the broken one.

⚠️ The device key is **not** a strong proof of identity. `device/register.php`
hands one out without a login, so anyone determined can get one. What it buys is
real but limited: it turns "anyone with curl" into "anyone who registered
first", it gives every sender a revocable handle, and it is the handle the rate
limit counts against.

⚠️ Attestation (Play Integrity, App Attest) is the textbook answer for an
unauthenticated endpoint of a mobile app, and it was rejected here on purpose:
Play Integrity is Android-only and requires Google Services, App Attest is
Apple-only, and this app also ships on Windows, Linux and macOS, where no
equivalent exists. It would cover one of five platforms.

## Still open: the AES key is public

The `{v:1, …}` envelope is encrypted with `MITGLIEDER_STARTUP_DIAG_KEY`, which
the client carries as a `--dart-define` constant — and therefore inside the
published APK, from a public repository. It does not authenticate the sender,
and it does not hide the transcript from anyone who has the APK.

The fix is an asymmetric envelope: a **public** key in the client, the private
key only on the server (libsodium sealed box — `crypto_box_seal` on the client,
`sodium_crypto_box_seal_open()` on the server, which is in PHP 8.5 core). That
is a new wire format on both ends plus a coordinated rollout, so it is not
bundled here. See the docstring on `_diagKeyHex` in
`lib/services/startup_diagnostics.dart`.

Until then, what protects the endpoint is the size cap, the rate limit and the
device key — not the envelope.

## Test

`server/tests/log_ingest_test.php` covers the decisions the library makes on its
own: sanitising foreign text, the rate-limit window, the lock around
`metadata.json`, the size cap. It needs **no** database and **no** php-fpm pool,
so it runs anywhere:

```bash
php server/tests/log_ingest_test.php
# or, with no PHP installed:
docker run --rm -v "$PWD:/w:ro" -w /w php:8.3-cli php server/tests/log_ingest_test.php
```

It cannot cover `blockBrowserAccess()` or `validateDeviceKey()` — those live in
`config.php` on the server. The smoke test below is what covers them.

## Deploy

Same shape as `server/api/security/PROD_CUTOVER.md`. **Three** files now, and
the library has to go first — an endpoint without it is a 500.

```bash
for f in log_ingest_lib.php mitglieder_windows.php mitglieder_android.php; do
  scp -P 36000 "server/api/logs/$f" \
    root@icd360sev.icd360s.de:/var/www/icd360sev.icd360s.de/api/logs/$f
done

ssh -p 36000 root@icd360sev.icd360s.de \
  "cd /var/www/icd360sev.icd360s.de/api/logs && \
   chown nginx:nginx log_ingest_lib.php mitglieder_windows.php mitglieder_android.php && \
   chmod 644 log_ingest_lib.php mitglieder_windows.php mitglieder_android.php && \
   for f in log_ingest_lib.php mitglieder_windows.php mitglieder_android.php; do \
     /usr/local/bin/php -l \$f; done"
```

`php` is not on sudo's `secure_path` on this host — use the absolute path, or a
syntax check silently reports "command not found" and reads as a broken file.

## Smoke test after deploy

```bash
U=https://icd360sev.icd360s.de/api/logs/mitglieder_windows.php
L='[{"timestamp":"2026-01-01T00:00:00","message":"smoke","level":"info","tag":"TEST"}]'

# 1. legitimate upload still works           → 200
curl -s -o /dev/null -w 'legit:      %{http_code}\n' -X POST "$U" \
  -H 'Content-Type: application/json' \
  -d "{\"mitgliedernummer\":\"SMOKETEST\",\"logs\":$L}"

# 2. the traversal case, the one that matters → 400
curl -s -o /dev/null -w 'traversal:  %{http_code}\n' -X POST "$U" \
  -H 'Content-Type: application/json' \
  -d "{\"mitgliedernummer\":\"../../../../tmp/x\",\"logs\":$L}"

# 3. oversized body                           → 413
python3 -c "import json;print(json.dumps({'mitgliedernummer':'SMOKETEST','logs':[{'message':'x'*600000}]}))" \
  | curl -s -o /dev/null -w 'oversize:   %{http_code}\n' -X POST "$U" \
      -H 'Content-Type: application/json' --data-binary @-

# 4. browser-shaped request → whatever blockBrowserAccess() does
#    ⚠️ The expected code is NOT written down here on purpose: that function
#    lives in config.php on the server, not in this repository, so nobody here
#    can say from the source which headers it keys on. Run it, note what you
#    get, and compare it against another endpoint that already calls it
#    (telemetry/battery_usage.php) — the two must answer the same way.
curl -s -o /dev/null -w 'browser:    %{http_code}\n' -X POST "$U" \
  -H 'Content-Type: application/json' \
  -H 'Sec-Fetch-Mode: cors' -H 'Origin: https://example.invalid' \
  -d "{\"mitgliedernummer\":\"SMOKETEST\",\"logs\":$L}"

# 5. rate limit: 30 get through, the 31st does not → 429
#    ⚠️ Clear the counter first, or the four calls above are already part of
#    this window — they share one identity, since none of them sends a
#    device key and the fallback is the IP.
ssh -p 36000 root@icd360sev.icd360s.de 'rm -rf /tmp/icd360sev_log_drossel'
for i in $(seq 1 31); do
  curl -s -o /dev/null -w "%{http_code} " -X POST "$U" \
    -H 'Content-Type: application/json' \
    -d "{\"mitgliedernummer\":\"SMOKETEST\",\"logs\":$L}"
done; echo
```

⚠️ The rate-limit counter lives in `sys_get_temp_dir()`. On a host where
php-fpm runs with `PrivateTmp=yes` that is **not** `/tmp` but a per-service
directory, and the `rm -rf` above will not find it. Check before trusting the
result: `systemctl show php85-php-fpm -p PrivateTmp`.

Then check that the forged-line case really is one line:

```bash
ssh -p 36000 root@icd360sev.icd360s.de \
  "grep -c '' /var/www/icd360sev.icd360s.de/logs/mitglieder_windows/SMOKETEST_$(date +%F).log"
```

Finally remove the probe file:
`logs/mitglieder_windows/SMOKETEST_<date>.log`, and clear the rate-limit
counter if you want the next run to start clean:
`rm -rf /tmp/icd360sev_log_drossel`.

## Unaffected

The other 16 endpoints in `api/logs/` on the server build their filenames from
`date()` alone. They are not touched by any of this — and they are also still
without `blockBrowserAccess()`, which is worth its own pass.
