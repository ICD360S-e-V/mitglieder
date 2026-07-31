# Log ingest endpoints

Two endpoints receive client logs. Both accept the same two payload shapes:

- `{v:1, iv, data}` — AES-256-GCM startup transcript from `StartupDiagnostics`
- `{mitgliedernummer, logs[...]}` — plain stream from `LoggerService`

The GCM key comes from the `MITGLIEDER_STARTUP_DIAG_KEY` environment variable
(64 hex chars), injected at build time on the client as a `--dart-define` and
read from the PHP-FPM environment on the server. It is never in this repo.

| file | writes to |
|---|---|
| `mitglieder_windows.php` | `logs/mitglieder_windows/` |
| `mitglieder_android.php` | `logs/mitglieder_android/` |

## Why these live here

They did not, until a path traversal was found in both:

```php
$mitgliedernummer = $data['mitgliedernummer'];        // straight from JSON
$filename = "$logsDir/{$mitgliedernummer}_$date.log"; // straight into a path
```

The endpoint is public and unauthenticated, so a caller supplying `../..`
wrote files anywhere nginx could write. Confirmed against production before the
fix: `../../../../tmp/pwned` and `a/b` both returned 200. After the fix both
return 400 and a legitimate upload still returns 200.

The fix was applied directly to the server because these files existed **only**
there — nothing in the repo, so nothing to review, and a redeploy from any
other copy would have silently reinstated the hole. Committing them is what
stops that from happening again.

The guard whitelists rather than strips. A client sending anything else is
broken or hostile, and both deserve a visible 400 rather than being quietly
rewritten into some other member's log file.

## Deploy

Same shape as `server/api/security/PROD_CUTOVER.md`.

```bash
scp -P 36000 server/api/logs/mitglieder_windows.php \
  root@icd360sev.icd360s.de:/var/www/icd360sev.icd360s.de/api/logs/mitglieder_windows.php

ssh -p 36000 root@icd360sev.icd360s.de \
  "chown nginx:nginx /var/www/icd360sev.icd360s.de/api/logs/mitglieder_windows.php && \
   chmod 644 /var/www/icd360sev.icd360s.de/api/logs/mitglieder_windows.php && \
   /usr/local/bin/php -l /var/www/icd360sev.icd360s.de/api/logs/mitglieder_windows.php"
```

`php` is not on sudo's `secure_path` on this host — use the absolute path, or a
syntax check silently reports "command not found" and reads as a broken file.

Smoke test after deploy; the traversal case is the one that matters:

```bash
U=https://icd360sev.icd360s.de/api/logs/mitglieder_windows.php
L='[{"timestamp":"2026-01-01T00:00:00","message":"smoke","level":"info","tag":"TEST"}]'

curl -s -o /dev/null -w 'legit:     %{http_code}\n' -X POST "$U" \
  -H 'Content-Type: application/json' \
  -d "{\"mitgliedernummer\":\"SMOKETEST\",\"logs\":$L}"          # expect 200

curl -s -o /dev/null -w 'traversal: %{http_code}\n' -X POST "$U" \
  -H 'Content-Type: application/json' \
  -d "{\"mitgliedernummer\":\"../../../../tmp/x\",\"logs\":$L}"  # expect 400
```

Then remove the probe file it creates:
`logs/mitglieder_windows/SMOKETEST_<date>.log`.

## Still open

The plain-logger path is unauthenticated: anyone who guesses a member number
can append to that member's log file. That is an authorisation gap, not a
traversal, and fixing it means requiring the device key the rest of the API
already uses — a design change rather than a patch, so it was left alone.

The other 16 endpoints in `api/logs/` on the server build their filenames from
`date()` alone and are unaffected.
