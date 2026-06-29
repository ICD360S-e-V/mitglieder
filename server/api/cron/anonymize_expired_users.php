<?php
/**
 * /api/cron/anonymize_expired_users.php
 *
 * Daily sweep — anonymises users whose `anonymize_at` has passed.
 * Targets only `status='gekuendigt_selbst'` rows that were marked for
 * anonymisation by withdraw.php (3-year retention model under Art. 6(1)(f)
 * DSGVO i.V.m. § 195 BGB).
 *
 * What this script does for each expired row:
 *   • Strips every personenbezogene Basisdate (vorname, nachname,
 *     geburtsname, geburtsdatum, geburtsort, address, telefon, parent
 *     hint columns, etc.) → either replaced with '[anonymized]' or NULL.
 *   • Replaces email with `deleted-<id>@icd360s.de` to keep the UNIQUE
 *     constraint satisfied while erasing the personal address.
 *   • Wipes any wizard_drafts data_* columns linked to this user, so
 *     the audit trail no longer carries personenbezogen content.
 *   • Best-effort unlinks orphan Bescheid files (withdraw.php should
 *     have already removed them, but defensive).
 *
 * What is PRESERVED beyond the 3-year window:
 *   • id, mitgliedernummer            — audit reference
 *   • status='gekuendigt_selbst'      — denormalised history flag
 *   • role, mitgliedsart              — needed for some reporting
 *   • deactivated_at, anonymize_at    — when it happened
 *   • retention_basis                 — legal basis on record
 *   • abuse_hash                      — pseudonym, irreversible.
 *     Recital 26 DSGVO classifies this as pseudonymised data; the
 *     person is not identifiable from the hash alone. Kept for the
 *     90-day re-registration throttle in finalize.php + check_age.php.
 *   • created_at                      — audit timestamp
 *
 * Designed to be re-runnable (idempotent): once a row is anonymised,
 * the WHERE clause excludes it on subsequent runs because vorname
 * becomes '[anonymized]'.
 *
 * Safety guarantees:
 *   1. Each row is processed in its own transaction with row-level lock.
 *   2. UPDATE targets `WHERE id = ? AND status = 'gekuendigt_selbst'
 *      AND anonymize_at <= NOW() AND vorname != '[anonymized]' LIMIT 1`.
 *   3. After UPDATE, rowCount() == 1 is asserted; mismatch trips rollback.
 *   4. Errors per row are logged + counted; the sweep continues.
 *   5. Max rows per run capped at 1000 to avoid runaway long sweeps.
 *
 * Crontab entry:
 *   0 3 * * * www-data /usr/bin/php /var/www/icd360sev.icd360s.de/api/cron/anonymize_expired_users.php >> /var/log/icd360sev-anonymize.log 2>&1
 */

declare(strict_types=1);

define('API_ACCESS', true);
require_once __DIR__ . '/../config.php';

const ANON_PLACEHOLDER = '[anonymized]';
const MAX_ROWS_PER_RUN = 1000;
const UPLOADS_ROOT     = __DIR__ . '/../../uploads/wizard_leistungsbescheid';

$startedAt = date('Y-m-d H:i:s');
echo "[$startedAt] anonymize_expired_users start\n";

try {
    $pdo = getDBConnection();

    // Pick candidates outside a transaction so we don't hold a long lock.
    // Per-row work happens in its own transaction below.
    $picker = $pdo->prepare(
        'SELECT id
           FROM users
          WHERE status = "gekuendigt_selbst"
            AND anonymize_at IS NOT NULL
            AND anonymize_at <= NOW()
            AND vorname != ?
          ORDER BY anonymize_at ASC
          LIMIT ' . MAX_ROWS_PER_RUN
    );
    $picker->execute([ANON_PLACEHOLDER]);
    $ids = $picker->fetchAll(PDO::FETCH_COLUMN);

    if (empty($ids)) {
        echo "[$startedAt] no rows expired — nothing to do\n";
        exit(0);
    }

    echo "[$startedAt] " . count($ids) . " row(s) to anonymise\n";

    $okCount  = 0;
    $errCount = 0;

    foreach ($ids as $userId) {
        $userId = (int)$userId;
        try {
            $pdo->beginTransaction();

            // Best-effort: collect Bescheid file paths to unlink AFTER commit
            // (withdraw.php normally already removes these, but if an old
            // withdrawal predates that change, we clean up here too).
            $fStmt = $pdo->prepare(
                'SELECT wdf.file_path
                   FROM wizard_draft_files wdf
                   JOIN wizard_drafts wd ON wd.id = wdf.wizard_draft_id
                  WHERE wd.user_id = ?'
            );
            $fStmt->execute([$userId]);
            $orphanFiles = $fStmt->fetchAll(PDO::FETCH_COLUMN);

            // DELETE wizard_draft_files for this user (cascade would not
            // fire because we're not dropping wizard_drafts).
            $pdo->prepare(
                'DELETE wdf FROM wizard_draft_files wdf
                   JOIN wizard_drafts wd ON wd.id = wdf.wizard_draft_id
                  WHERE wd.user_id = ?'
            )->execute([$userId]);

            // Wipe data_* fields in wizard_drafts so the audit trail is
            // also free of personenbezogen content. Keeps the row itself
            // (current_step + timestamps + back-link) for audit.
            $pdo->prepare(
                'UPDATE wizard_drafts SET
                    data_vorname                       = NULL,
                    data_nachname                      = NULL,
                    data_geburtsname                   = NULL,
                    data_geburtsdatum                  = NULL,
                    data_geburtsort                    = NULL,
                    data_geschlecht                    = NULL,
                    data_familienstand                 = NULL,
                    data_staatsangehoerigkeit          = NULL,
                    data_aufenthaltsstatus             = NULL,
                    data_muttersprache                 = NULL,
                    data_strasse                       = NULL,
                    data_hausnummer                    = NULL,
                    data_plz                           = NULL,
                    data_ort                           = NULL,
                    data_land                          = NULL,
                    data_telefon_mobil                 = NULL,
                    data_email                         = NULL,
                    data_parent_hint_vorname           = NULL,
                    data_parent_hint_nachname          = NULL,
                    data_parent_hint_telefon           = NULL,
                    data_parent_hint_relation          = NULL
                  WHERE user_id = ?'
            )->execute([$userId]);

            // Anonymise the users row. UPDATE is guarded so we never
            // overwrite a row that was already anonymised or is no longer
            // 'gekuendigt_selbst'.
            $up = $pdo->prepare(
                'UPDATE users SET
                    vorname                  = ?,
                    vorname2                 = NULL,
                    nachname                 = ?,
                    name                     = ?,
                    geburtsname              = NULL,
                    geburtsdatum             = NULL,
                    geburtsort               = NULL,
                    geschlecht               = NULL,
                    familienstand            = NULL,
                    staatsangehoerigkeit     = NULL,
                    aufenthaltsstatus        = NULL,
                    muttersprache            = NULL,
                    strasse                  = NULL,
                    hausnummer               = NULL,
                    plz                      = NULL,
                    ort                      = NULL,
                    bundesland               = NULL,
                    land                     = NULL,
                    telefon_mobil            = NULL,
                    telefon_fix              = NULL,
                    email                    = CONCAT("deleted-", id, "@icd360s.de"),
                    parent_hint_vorname      = NULL,
                    parent_hint_nachname     = NULL,
                    parent_hint_telefon      = NULL,
                    parent_hint_relation     = NULL,
                    leistungsbescheid_file   = NULL,
                    retention_basis          = CONCAT(IFNULL(retention_basis, ""), ";anonymized_at_", ?)
                  WHERE id = ?
                    AND status = "gekuendigt_selbst"
                    AND anonymize_at <= NOW()
                    AND vorname != ?
                  LIMIT 1'
            );
            $up->execute([
                ANON_PLACEHOLDER,
                ANON_PLACEHOLDER,
                ANON_PLACEHOLDER,
                date('Y-m-d H:i:s'),
                $userId,
                ANON_PLACEHOLDER,
            ]);

            if ($up->rowCount() !== 1) {
                $pdo->rollBack();
                error_log('[anonymize] users UPDATE rowCount='
                          . $up->rowCount() . ' for user_id=' . $userId);
                $errCount++;
                continue;
            }

            $pdo->commit();
            $okCount++;

            // Best-effort physical file deletion AFTER commit.
            $uploadsRoot = realpath(UPLOADS_ROOT);
            foreach ($orphanFiles as $rel) {
                $rel = (string)$rel;
                if ($rel === '') continue;
                $candidate = str_starts_with($rel, '/')
                    ? $rel
                    : UPLOADS_ROOT . '/' . $rel;
                $real = @realpath($candidate);
                if ($real === false || $uploadsRoot === false) continue;
                if (!str_starts_with($real, $uploadsRoot)) {
                    error_log('[anonymize] refused to unlink outside uploads: '
                              . $real);
                    continue;
                }
                @unlink($real);
            }
        } catch (Exception $e) {
            if ($pdo->inTransaction()) {
                $pdo->rollBack();
            }
            error_log('[anonymize] user_id=' . $userId . ': ' . $e->getMessage());
            $errCount++;
        }
    }

    $finishedAt = date('Y-m-d H:i:s');
    echo "[$finishedAt] done — ok=$okCount err=$errCount\n";
    exit($errCount === 0 ? 0 : 1);
} catch (PDOException $e) {
    error_log('[anonymize] fatal: ' . $e->getMessage());
    echo "fatal: " . $e->getMessage() . "\n";
    exit(2);
}
