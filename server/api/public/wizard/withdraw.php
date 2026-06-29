<?php
/**
 * /api/public/wizard/withdraw.php  (v3 — 3-year retention model)
 *
 * Records a voluntary withdrawal from the wizard's final screen. The
 * visitor's data stays intact for 3 years (Art. 6 Abs. 1 lit. f DSGVO
 * i.V.m. § 195 BGB — Verjährungsfrist), then gets anonymised by a
 * scheduled job. The hash stays beyond that as the long-term Sperrliste
 * entry against repeat abuse.
 *
 * Legal basis for the 3-year retention:
 *   • § 195 BGB — Regelverjährungsfrist (3 years) on civil claims;
 *     the Verein has a defensive interest in keeping the application
 *     materials usable for that window.
 *   • Art. 6(1)(f) DSGVO — berechtigtes Interesse: fraud prevention
 *     plus claim defence outweighs the data subject's erasure interest
 *     for the 3-year window. After the window, anonymisation is the
 *     minimisation step (Art. 5(1)(c) DSGVO).
 *
 * What gets written by THIS endpoint:
 *   • status            = 'gekuendigt_selbst'
 *   • deactivated_at    = NOW()
 *   • deactivation_reason — the withdrawal label
 *   • abuse_hash        = SHA256(lowercased vorname|lowercased nachname
 *                                 |geburtsdatum)
 *   • anonymize_at      = DATE_ADD(NOW(), INTERVAL 3 YEAR)
 *   • retention_basis   = 'Art_6_1_f_DSGVO_iVm_§195_BGB_3y'
 *
 * What stays untouched: every personal field (vorname, nachname,
 * adresa, geburtsdatum, telefon, parent_hint_*). The wizard_drafts
 * row also stays until the scheduled anonymisation runs.
 *
 * What this endpoint DELETES immediately (Datenminimierung Art. 5(1)(c)
 * DSGVO — the documents were collected to verify Beitragsfreiheit at
 * finalize; once the visitor withdraws, that purpose is gone):
 *   • wizard_draft_files rows for this user's draft
 *   • The physical Bescheid files in
 *     /uploads/wizard_leistungsbescheid/<category>/
 *   • users.leistungsbescheid_file pointer (cleared to NULL)
 *
 * Idempotent: a second call on an already-withdrawn user is a no-op
 * and returns 200.
 *
 * Safety guarantees implemented below:
 *   1. Single transaction with ROLLBACK on any anomaly.
 *   2. The single UPDATE targets `WHERE id = ? LIMIT 1`.
 *   3. After UPDATE we assert rowCount() == 1; mismatched count trips
 *      the rollback.
 */

declare(strict_types=1);

define('API_ACCESS', true);
require_once __DIR__ . '/../../config.php';

validateApiKey();
blockBrowserAccess();

header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-store');

const WITHDRAW_REASON   = 'Cerere retrasă din wizard de utilizator înainte de aprobare';
const RETENTION_BASIS   = 'Art_6_1_f_DSGVO_iVm_§195_BGB_3y';
const RETENTION_YEARS   = 3;

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
if (strlen($anonymous_id) < 16 || strlen($anonymous_id) > 64
    || !preg_match('/^[A-Za-z0-9_-]+$/', $anonymous_id)) {
    http_response_code(400);
    jsonResponse(false, [], 'Invalid anonymous_id');
}

try {
    $pdo = getDBConnection();
    $pdo->beginTransaction();

    $stmt = $pdo->prepare(
        'SELECT wd.user_id,
                u.status,
                u.vorname,
                u.nachname,
                u.geburtsdatum
           FROM wizard_drafts wd
           LEFT JOIN users u ON u.id = wd.user_id
          WHERE wd.anonymous_id = ?
          FOR UPDATE'
    );
    $stmt->execute([$anonymous_id]);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$row) {
        $pdo->rollBack();
        http_response_code(404);
        jsonResponse(false, [], 'Wizard draft not found');
    }
    if ($row['user_id'] === null) {
        $pdo->rollBack();
        http_response_code(404);
        jsonResponse(false, [], 'No user linked to this draft');
    }

    $userId = (int)$row['user_id'];
    $now    = date('Y-m-d H:i:s');
    $anonymizeAt = date('Y-m-d H:i:s', strtotime('+' . RETENTION_YEARS . ' years'));

    if ($row['status'] === 'gekuendigt_selbst') {
        $pdo->commit();
        jsonResponse(true, [
            'user_id'         => $userId,
            'status'          => 'gekuendigt_selbst',
            'deactivated_at'  => null,
            'already'         => true,
        ], 'Already withdrawn');
    }

    // Stable, irreversible identifier for abuse throttling. Computed
    // before the UPDATE so we capture the original data — relevant if
    // a future anonymisation job runs concurrently.
    $abuseHash = compute_abuse_hash(
        $row['vorname']      ?? '',
        $row['nachname']     ?? '',
        $row['geburtsdatum'] ?? ''
    );

    // Datenminimierung: collect Bescheid file paths now (before DELETE)
    // so we can unlink the physical files after the transaction commits.
    // Files are stored relative to the wizard uploads root; defensive
    // absolute-path handling below.
    $bescheidStmt = $pdo->prepare(
        'SELECT wdf.id, wdf.file_path
           FROM wizard_draft_files wdf
           JOIN wizard_drafts wd ON wd.id = wdf.wizard_draft_id
          WHERE wd.user_id = ?'
    );
    $bescheidStmt->execute([$userId]);
    $bescheideToUnlink = $bescheidStmt->fetchAll(PDO::FETCH_ASSOC);

    // DB row deletion stays inside the transaction. Worst case is
    // orphan files on disk that the anonymise cron cleans up later.
    $pdo->prepare(
        'DELETE wdf FROM wizard_draft_files wdf
           JOIN wizard_drafts wd ON wd.id = wdf.wizard_draft_id
          WHERE wd.user_id = ?'
    )->execute([$userId]);

    $up = $pdo->prepare(
        'UPDATE users SET
            status                          = ?,
            deactivated_at                  = ?,
            deactivation_reason             = ?,
            anonymize_at                    = ?,
            retention_basis                 = ?,
            abuse_hash                      = ?,
            leistungsbescheid_file          = NULL,
            leistungsbescheid_uploaded_at   = NULL
         WHERE id = ?
         LIMIT 1'
    );
    $up->execute([
        'gekuendigt_selbst',
        $now,
        WITHDRAW_REASON,
        $anonymizeAt,
        RETENTION_BASIS,
        $abuseHash,
        $userId,
    ]);

    if ($up->rowCount() !== 1) {
        $pdo->rollBack();
        error_log('[wizard/withdraw] users UPDATE rowCount=' . $up->rowCount()
                  . ' for user_id=' . $userId);
        http_response_code(500);
        jsonResponse(false, [], 'Unexpected row count');
    }

    $pdo->commit();

    // Best-effort physical file deletion AFTER the DB transaction has
    // committed. The rows are already gone — we're just freeing disk.
    // Path validation: only unlink files inside the wizard uploads root
    // so a malformed file_path can't be coerced into deleting random
    // server files.
    $uploadsRoot = realpath(__DIR__ . '/../../../uploads/wizard_leistungsbescheid');
    foreach ($bescheideToUnlink as $b) {
        $rel = (string)($b['file_path'] ?? '');
        if ($rel === '') continue;
        $candidate = (str_starts_with($rel, '/'))
            ? $rel
            : __DIR__ . '/../../../uploads/wizard_leistungsbescheid/' . $rel;
        $real = @realpath($candidate);
        if ($real === false || $uploadsRoot === false) continue;
        if (!str_starts_with($real, $uploadsRoot)) {
            error_log('[wizard/withdraw] refused to unlink outside uploads: '
                      . $real);
            continue;
        }
        @unlink($real);
    }

    jsonResponse(true, [
        'user_id'        => $userId,
        'status'         => 'gekuendigt_selbst',
        'deactivated_at' => $now,
        'anonymize_at'   => $anonymizeAt,
        'already'        => false,
    ], 'Withdrawal recorded; data kept for 3 years (§195 BGB), then anonymised');
} catch (PDOException $e) {
    if (isset($pdo) && $pdo->inTransaction()) {
        $pdo->rollBack();
    }
    error_log('[wizard/withdraw] ' . $e->getMessage());
    http_response_code(500);
    jsonResponse(false, [], 'Database error');
}

function compute_abuse_hash(string $vorname, string $nachname, string $geburtsdatum): ?string {
    $v = trim(mb_strtolower($vorname, 'UTF-8'));
    $n = trim(mb_strtolower($nachname, 'UTF-8'));
    $g = trim($geburtsdatum);
    if ($v === '' || $n === '' || $g === '') {
        return null;
    }
    return hash('sha256', $v . '|' . $n . '|' . $g);
}
