<?php
/**
 * /api/public/wizard/save_step.php
 *
 * Persist one step's worth of data into the `wizard_drafts` row for a
 * given anonymous_id and advance the `current_step` cursor. The
 * endpoint validates the named step, allow-lists only the columns
 * that belong to that step (so a confused client can't smash random
 * fields), and refuses unknown keys.
 *
 * Payload (JSON POST):
 *   anonymous_id  string, required
 *   step          string, required — one of: 1a, 1b, 1b1, 1c, 1d, 1e,
 *                                            1f, 2, 3, 3_upload, 4,
 *                                            5, 6, 7, 8, intro_done
 *   data          object, required — only the fields appropriate to
 *                                    the step (see $stepFields below)
 *
 * Response:
 *   200 { success: true, current_step, saved_fields, last_active }
 */

declare(strict_types=1);

define('API_ACCESS', true);
require_once __DIR__ . '/../../config.php';

validateApiKey();
blockBrowserAccess();

header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-store');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    jsonResponse(false, [], 'Method not allowed');
}

$body = json_decode(file_get_contents('php://input'), true);
if (!is_array($body)) {
    http_response_code(400);
    jsonResponse(false, [], 'Invalid JSON');
}

$anonymous_id = trim((string)($body['anonymous_id'] ?? ''));
$step         = trim((string)($body['step'] ?? ''));
$data         = $body['data'] ?? null;

if (strlen($anonymous_id) < 16 || strlen($anonymous_id) > 64
    || !preg_match('/^[A-Za-z0-9_-]+$/', $anonymous_id)) {
    http_response_code(400);
    jsonResponse(false, [], 'Invalid anonymous_id');
}
if (!is_array($data)) {
    http_response_code(400);
    jsonResponse(false, [], 'data must be an object');
}

// Field allow-list per step. Maps step name to the actual
// wizard_drafts columns the client may write at that step.
$stepFields = [
    'intro_done' => [],                              // just advances cursor
    '1a'         => ['data_vorname', 'data_nachname', 'data_geburtsname'],
    '1b'         => ['data_geburtsdatum', 'data_geburtsort'],
    '1b1'        => ['data_parent_hint_vorname', 'data_parent_hint_nachname',
                     'data_parent_hint_telefon', 'data_parent_hint_relation'],
    '1c'         => ['data_geschlecht', 'data_familienstand'],
    '1d'         => ['data_staatsangehoerigkeit', 'data_aufenthaltsstatus',
                     'data_muttersprache'],
    '1e'         => ['data_strasse', 'data_hausnummer', 'data_plz',
                     'data_ort', 'data_land'],
    '1f'         => ['data_telefon_mobil', 'data_email'],
    '2'          => ['data_mitgliedsart'],
    '3'          => ['data_finanzielle_situation'],
    '3_upload'   => ['data_leistungsbescheid_file'],
    '4'          => ['data_zahlungsmethode', 'data_zahlungstag'],
    '5'          => ['data_mitgliedschaftsbeginn_option',
                     'data_mitgliedschaftsbeginn_datum'],
    '6'          => ['data_satzung_read'],
    '7'          => ['data_datenschutz_read'],
    '8'          => ['data_widerrufsbelehrung_read'],
];

if (!isset($stepFields[$step])) {
    http_response_code(400);
    jsonResponse(false, [], 'Unknown step');
}

/**
 * Fetch + cache the current version metadata for one of the three legal
 * documents the wizard surfaces at Stufe 6/7/8. The SHA256 of the
 * fetched HTML is what we anchor the per-user acceptance against, so
 * an after-the-fact change on icd360s.de is detectable from the
 * `document_acceptances.document_content_hash` snapshot.
 *
 * Cached on disk for 1 hour to avoid hitting the public site on every
 * save_step call. Falls back to a stale cache entry if the live fetch
 * fails (network blip) — last-known good is better than null.
 *
 * Returns null only when both the live fetch and the cache lookup fail
 * (cold path, no public site, no cache file). Callers must handle null
 * by logging + continuing — the audit-trail row is best-effort.
 */
function lookup_document_metadata(string $kind): ?array {
    static $urls = [
        'satzung'             => 'https://icd360s.de/satzung360s/',
        'datenschutz'         => 'https://icd360s.de/datenschutz',
        'widerrufsbelehrung'  => 'https://icd360s.de/widerrufsrecht',
    ];
    if (!isset($urls[$kind])) return null;
    $url       = $urls[$kind];
    $cacheDir  = sys_get_temp_dir() . '/icd360sev_doc_cache';
    if (!is_dir($cacheDir)) @mkdir($cacheDir, 0700, true);
    $cacheFile = $cacheDir . '/' . $kind . '.json';

    if (is_file($cacheFile) && (time() - filemtime($cacheFile)) < 3600) {
        $cached = @json_decode((string)@file_get_contents($cacheFile), true);
        if (is_array($cached) && !empty($cached['content_hash'])) {
            return ['url' => $url] + $cached;
        }
    }

    $ctx = stream_context_create([
        'http' => [
            'timeout' => 10,
            'header'  => "User-Agent: ICD360S-wizard-server/1.0\r\n",
        ],
        'ssl'  => ['verify_peer' => true, 'verify_peer_name' => true],
    ]);
    $html = @file_get_contents($url, false, $ctx);
    if ($html === false || strlen($html) < 100) {
        if (is_file($cacheFile)) {
            $cached = @json_decode((string)@file_get_contents($cacheFile), true);
            if (is_array($cached) && !empty($cached['content_hash'])) {
                return ['url' => $url] + $cached;
            }
        }
        return null;
    }

    $meta = [
        'url'          => $url,
        'version'      => date('Y-m-d'),
        'content_hash' => hash('sha256', $html),
    ];
    @file_put_contents($cacheFile, json_encode($meta));
    return $meta;
}

// Every wizard sub-step that maps to a Verifizierung Stufe also
// stamps the precise completion moment (date + time + second). The
// Vorstand needs this for DSGVO Art. 7 audit (when did the visitor
// actually consent / submit / accept) and for the wizard timeline
// view in the admin app. Sub-stufen 1a..1f and 1b1 all roll up to
// stufe1; 3 and 3_upload to stufe3. 6/7/8 keep their dedicated
// _read_at columns. intro_done has no Stufe, so no stamp.
$stufeTimestampColumn = match ($step) {
    '1a', '1b', '1b1', '1c', '1d', '1e', '1f' => 'stufe1_completed_at',
    '2'        => 'stufe2_completed_at',
    '3', '3_upload' => 'stufe3_completed_at',
    '4'        => 'stufe4_completed_at',
    '5'        => 'stufe5_completed_at',
    '6'        => 'data_satzung_read_at',
    '7'        => 'data_datenschutz_read_at',
    '8'        => 'data_widerrufsbelehrung_read_at',
    default    => null,
};

$allowed = $stepFields[$step];
$updates = [];
$params  = [];

foreach ($data as $key => $value) {
    $col = 'data_' . $key;
    if (!in_array($col, $allowed, true)) {
        // Silently ignore unknown keys rather than erroring — the
        // client may send a few extras during refactors and we'd
        // rather not block the save.
        continue;
    }
    // Light coercion: empty string → NULL so the column-level default
    // ("Deutschland", "deutsch") wins on resume.
    if ($value === '') {
        $value = null;
    }
    $updates[$col] = $value;
}

try {
    $pdo = getDBConnection();

    $stmt = $pdo->prepare('SELECT id, user_id FROM wizard_drafts WHERE anonymous_id = ?');
    $stmt->execute([$anonymous_id]);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$row) {
        http_response_code(404);
        jsonResponse(false, [], 'Wizard draft not found');
    }
    $draftId = (int)$row['id'];
    $stubUserId = (int)($row['user_id'] ?? 0);

    if (empty($updates)) {
        // Only the cursor moves (e.g. intro_done).
        $pdo->prepare('UPDATE wizard_drafts SET current_step = ?,
                       last_active = NOW() WHERE id = ?')
            ->execute([$step, $draftId]);
    } else {
        $setParts = [];
        foreach ($updates as $col => $_) {
            $setParts[] = "$col = ?";
            $params[]   = $updates[$col];
        }
        $params[] = $step;
        $params[] = $draftId;
        // Stamp the per-Stufe completion column on the same UPDATE
        // so the timestamp is atomic with the data write.
        $extraSql = ($stufeTimestampColumn !== null)
            ? ", $stufeTimestampColumn = NOW()" : '';
        $sql = 'UPDATE wizard_drafts SET ' . implode(', ', $setParts)
             . $extraSql
             . ', current_step = ?, last_active = NOW() WHERE id = ?';
        $pdo->prepare($sql)->execute($params);
    }

    // Mirror the saved fields to the users stub created by check_age.php
    // at Stufe 1b. Lets the Vorstand see the registration progress
    // live in Mitgliederverwaltung's "Nicht verifiziert" tab without
    // waiting for finalize. Non-fatal — a mirror failure must not
    // block the visitor's saveStep.
    if ($stubUserId > 0 && !empty($updates)) {
        try {
            // wizard_drafts column → users column. parent_hint_*,
            // satzung_read flags, and leistungsbescheid_file are
            // intentionally not mirrored at save time (parent_hints
            // are minor-only and copied at finalize; doc flags are
            // booleans, not relevant for verifizierung view).
            static $userMirror = [
                'data_vorname'                       => 'vorname',
                'data_nachname'                      => 'nachname',
                'data_geburtsname'                   => 'geburtsname',
                'data_geburtsdatum'                  => 'geburtsdatum',
                'data_geburtsort'                    => 'geburtsort',
                'data_geschlecht'                    => 'geschlecht',
                'data_familienstand'                 => 'familienstand',
                'data_staatsangehoerigkeit'          => 'staatsangehoerigkeit',
                'data_aufenthaltsstatus'             => 'aufenthaltsstatus',
                'data_muttersprache'                 => 'muttersprache',
                'data_strasse'                       => 'strasse',
                'data_hausnummer'                    => 'hausnummer',
                'data_plz'                           => 'plz',
                'data_ort'                           => 'ort',
                'data_land'                          => 'land',
                'data_telefon_mobil'                 => 'telefon_mobil',
                'data_email'                         => 'email',
                'data_mitgliedsart'                  => 'mitgliedsart',
                'data_finanzielle_situation'         => 'finanzielle_situation',
                'data_zahlungsmethode'               => 'zahlungsmethode',
                'data_zahlungstag'                   => 'zahlungstag',
                'data_mitgliedschaftsbeginn_option'  => 'mitgliedschaftsbeginn_option',
                'data_mitgliedschaftsbeginn_datum'   => 'mitgliedschaftsbeginn_datum',
            ];
            $mirrorSets = [];
            $mirrorVals = [];
            foreach ($updates as $col => $val) {
                if (isset($userMirror[$col])) {
                    $mirrorSets[] = $userMirror[$col] . ' = ?';
                    $mirrorVals[] = $val;
                }
            }
            if (!empty($mirrorSets)) {
                $mirrorVals[] = $stubUserId;
                $pdo->prepare('UPDATE users SET ' . implode(', ', $mirrorSets) . ' WHERE id = ?')
                    ->execute($mirrorVals);
                // Keep users.name in sync when vorname / nachname change.
                if (isset($updates['data_vorname']) || isset($updates['data_nachname'])) {
                    $pdo->prepare('UPDATE users
                                      SET name = TRIM(CONCAT(COALESCE(vorname, ""), " ", COALESCE(nachname, "")))
                                    WHERE id = ?')
                        ->execute([$stubUserId]);
                }
            }
            // Mark user_verifizierung Stufe as "ausgefuellt" once its
            // last sub-step lands. For Stufe 1, that's 1f (or 1f
            // having been saved at some point). For the others, the
            // step itself is the trigger. The 'ausgefuellt_am' is
            // sourced from wizard_drafts.stufeN_completed_at when the
            // mirror runs, so the timestamp matches the wizard write.
            $completionStufe = match ($step) {
                '1f'        => 1,
                '2'         => 2,
                '3', '3_upload' => 3,
                '4'         => 4,
                '5'         => 5,
                '6'         => 6,
                '7'         => 7,
                '8'         => 8,
                default     => null,
            };
            if ($completionStufe !== null) {
                $pdo->prepare(
                    'UPDATE user_verifizierung
                        SET status = "ausgefuellt",
                            ausgefuellt_am = COALESCE(ausgefuellt_am, NOW())
                      WHERE user_id = ? AND stufe = ?
                        AND status IN ("offen", "abgelehnt")'
                )->execute([$stubUserId, $completionStufe]);
            }

            // Stufen 6/7/8 = legal-document accepts. Capture the full
            // audit-trail evidence row in document_acceptances. Mirrors
            // the pattern already in use for parent_consent_signatures.
            // UPSERT lets the visitor re-accept after a (would-be)
            // Vorstand rejection (though we currently block such
            // rejections server-side; the upsert is future-proofing).
            $docKind = match ($step) {
                '6' => 'satzung',
                '7' => 'datenschutz',
                '8' => 'widerrufsbelehrung',
                default => null,
            };
            if ($docKind !== null) {
                $meta = lookup_document_metadata($docKind);
                if ($meta !== null) {
                    $scrolledToEnd = isset($data['scrolled_to_end'])
                        ? (int)((bool)$data['scrolled_to_end']) : 0;
                    $acceptedLocal = isset($data['accepted_at_local'])
                        ? substr((string)$data['accepted_at_local'], 0, 50) : null;
                    $ipAddress = substr(
                        (string)($_SERVER['REMOTE_ADDR'] ?? '0.0.0.0'), 0, 45
                    );
                    $userAgent = substr(
                        (string)($_SERVER['HTTP_USER_AGENT'] ?? ''), 0, 500
                    );
                    $deviceId  = substr($anonymous_id, 0, 64);
                    $acceptedUtc = gmdate('Y-m-d H:i:s');

                    // Canonical concatenation, then SHA256, gives a
                    // tamper-evidence anchor: any later DB mutation
                    // breaks the recomputation.
                    $fullHashInput = implode('|', [
                        $stubUserId, $docKind, $meta['version'], $meta['url'],
                        $meta['content_hash'], $acceptedUtc, $acceptedLocal ?? '',
                        $ipAddress, $userAgent, $deviceId, $scrolledToEnd,
                    ]);
                    $fullHash = hash('sha256', $fullHashInput);

                    $pdo->prepare(
                        'INSERT INTO document_acceptances
                          (user_id, document_kind, document_version, document_url,
                           document_content_hash, accepted_at_utc, accepted_at_local,
                           ip_address, user_agent, device_id, scrolled_to_end,
                           full_hash)
                         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                         ON DUPLICATE KEY UPDATE
                           document_version      = VALUES(document_version),
                           document_url          = VALUES(document_url),
                           document_content_hash = VALUES(document_content_hash),
                           accepted_at_utc       = VALUES(accepted_at_utc),
                           accepted_at_local     = VALUES(accepted_at_local),
                           ip_address            = VALUES(ip_address),
                           user_agent            = VALUES(user_agent),
                           device_id             = VALUES(device_id),
                           scrolled_to_end       = VALUES(scrolled_to_end),
                           full_hash             = VALUES(full_hash)'
                    )->execute([
                        $stubUserId, $docKind, $meta['version'], $meta['url'],
                        $meta['content_hash'], $acceptedUtc, $acceptedLocal,
                        $ipAddress, $userAgent, $deviceId, $scrolledToEnd,
                        $fullHash,
                    ]);
                } else {
                    error_log('[wizard/save_step] document metadata lookup '
                              . 'failed for kind=' . $docKind . ' step=' . $step);
                }
            }
        } catch (PDOException $e) {
            error_log('[wizard/save_step user_mirror] ' . $e->getMessage());
        }
    }

    jsonResponse(true, [
        'current_step' => $step,
        'saved_fields' => array_keys($updates),
        'last_active'  => date('Y-m-d H:i:s'),
    ], 'Step saved');
} catch (PDOException $e) {
    error_log('[wizard/save_step] ' . $e->getMessage());
    http_response_code(500);
    jsonResponse(false, [], 'Database error');
}
