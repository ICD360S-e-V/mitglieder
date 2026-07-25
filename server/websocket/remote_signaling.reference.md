# Fernwartung signaling — changes to merge into `websocket/src/ChatServer.php`

> **Staged reference — NOT auto-deployed.** The live WebSocket daemon is only on
> the production server (`10.10.10.5`), not in the repo. Merge the handlers below
> into the real `ChatServer.php`, then restart the daemon (see bottom).
>
> This adds the `remote_*` signaling frames for the RustDesk-style remote-support
> feature. It is completely separate from the `call_*` (voice) frames and from the
> RDP/Guacamole office remote desktop. The media itself never touches the daemon —
> it is WebRTC (DTLS/SRTP over coturn). The daemon only routes SDP/ICE + lifecycle.

## Frame routing table

Incoming frames are already routed by `conversation_id` room (same mechanism as
`call_offer`). Add these cases alongside the existing `call_*` cases. Rebroadcast
names mirror the call convention (`call_reject`→`call_rejected`).

| Incoming (from client) | Fan-out to room as | Server adds (from the socket's authed identity) |
|---|---|---|
| `remote_offer`  | `remote_offer`    | `controller_id`, `controller_name` |
| `remote_answer` | `remote_answer`   | `answerer_id` |
| `remote_reject` | `remote_rejected` | `rejected_by` |
| `remote_end`    | `remote_ended`    | `ended_by` |
| `remote_ice`    | `remote_ice`      | (nothing — pass through) |

Exclude the sender from the fan-out, exactly like `call_offer` does.

## Role gate (important)

Only a `vorsitzer` may INITIATE. In the `remote_offer` case, before fan-out,
verify the sender's role. The daemon already knows the socket's authenticated
`mitgliedernummer` from the `auth` frame; look up its role:

```php
// role gate for remote_offer — reuse whatever DB handle the daemon already has
$stmt = $this->pdo->prepare('SELECT role FROM users WHERE mitgliedernummer = ?');
$stmt->execute([$conn->mitgliedernummer]);   // <-- adapt to how the socket stores its identity
$row = $stmt->fetch();
if (!$row || $row['role'] !== 'vorsitzer') {
    // silently drop — a non-vorsitzer must never be able to open a session
    return;
}
```

## Handler skeleton (adapt names to the real daemon)

Model this on the existing `call_offer` / `ice_candidate` handling. `$data` is the
decoded frame; `$conn` is the sending connection; `broadcastToRoom()` /
`$this->conversations[$cid]` are placeholders for whatever the daemon already uses.

```php
case 'remote_offer': {
    $cid = (int)($data['conversation_id'] ?? 0);

    // --- role gate (see above) ---
    $stmt = $this->pdo->prepare('SELECT id, role, name FROM users WHERE mitgliedernummer = ?');
    $stmt->execute([$conn->mitgliedernummer]);
    $u = $stmt->fetch();
    if (!$u || $u['role'] !== 'vorsitzer') { break; }

    $out = [
        'type'            => 'remote_offer',
        'conversation_id' => $cid,
        'sdp'             => $data['sdp'] ?? '',
        'sdp_type'        => $data['sdp_type'] ?? 'offer',
        'controller_id'   => (string)$u['id'],
        'controller_name' => $data['controller_name'] ?? $u['name'] ?? '',
        'target_user_id'  => $data['target_user_id'] ?? null,
    ];
    $this->broadcastToRoom($cid, $out, $conn);   // exclude sender
    break;
}

case 'remote_answer': {
    $cid = (int)($data['conversation_id'] ?? 0);
    $this->broadcastToRoom($cid, [
        'type'            => 'remote_answer',
        'conversation_id' => $cid,
        'sdp'             => $data['sdp'] ?? '',
        'sdp_type'        => $data['sdp_type'] ?? 'answer',
        'answerer_id'     => (string)$this->userIdOf($conn),   // adapt
    ], $conn);
    break;
}

case 'remote_reject': {
    $cid = (int)($data['conversation_id'] ?? 0);
    $this->broadcastToRoom($cid, [
        'type'            => 'remote_rejected',   // note: rebroadcast name
        'conversation_id' => $cid,
        'reason'          => $data['reason'] ?? 'rejected',
        'rejected_by'     => (string)$this->userIdOf($conn),
    ], $conn);
    break;
}

case 'remote_end': {
    $cid = (int)($data['conversation_id'] ?? 0);
    $this->broadcastToRoom($cid, [
        'type'            => 'remote_ended',      // note: rebroadcast name
        'conversation_id' => $cid,
        'ended_by'        => (string)$this->userIdOf($conn),
    ], $conn);
    break;
}

case 'remote_ice': {
    $cid = (int)($data['conversation_id'] ?? 0);
    $this->broadcastToRoom($cid, [
        'type'             => 'remote_ice',
        'conversation_id'  => $cid,
        'candidate'        => $data['candidate'] ?? '',
        'sdp_mid'          => $data['sdp_mid'] ?? '',
        'sdp_mline_index'  => $data['sdp_mline_index'] ?? 0,
    ], $conn);
    break;
}
```

## Which room?

Both peers must be joined to the same `conversation_id` before signaling, exactly
like a voice call. The Vorsitzer↔member conversation already exists (chat). The
apps `join` it before starting the session. If you prefer direct addressing, the
frames already carry `target_user_id`; route to that user's socket instead of the
room. Room-based is the least-change option (reuses the call path verbatim).

## Deploy steps (run on the production host, when on the internal VLAN)

```bash
# 1. copy the edited daemon up
scp -i <key> -P 22 ChatServer.php root@10.10.10.5:/path/to/websocket/src/ChatServer.php

# 2. apply the DB migration (idempotent)
scp -i <key> -P 22 2026_07_24_remote_sessions.sql root@10.10.10.5:/tmp/
ssh -i <key> -p 22 root@10.10.10.5 "mysql icd360sev_db < /tmp/2026_07_24_remote_sessions.sql"

# 3. deploy the REST audit endpoint
ssh -i <key> -p 22 root@10.10.10.5 "mkdir -p /path/to/api/remote"
scp -i <key> -P 22 session.php root@10.10.10.5:/path/to/api/remote/session.php

# 4. restart the WS daemon + reload php-fpm
ssh -i <key> -p 22 root@10.10.10.5 "systemctl restart <ws-daemon-unit>; systemctl reload php85-php-fpm"
```

Confirm the daemon unit name with `systemctl list-units | grep -i -E 'chat|ws|websocket'`.
