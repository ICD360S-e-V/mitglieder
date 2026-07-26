# Fernwartung — iOS whole-screen capture (ReplayKit Broadcast Upload Extension)

On iOS, a normal app can only capture its **own** view. To share the **whole
screen**, iOS needs a **Broadcast Upload Extension** that streams frames to the
main app through a shared app-group socket. flutter_webrtc provides the main-app
side; this repo provides the extension.

**This is fully wired for CI — no manual Xcode needed.** The extension target is
committed in `Runner.xcodeproj`, so the GitHub macOS runner's `flutter build ios`
builds + embeds it automatically. iOS is **view-only** (no remote control).

## What's in the repo
- `ios/BroadcastExtension/` — the extension: `SampleHandler.swift` + the socket
  helpers (`SocketConnection`, `SampleUploader`, `DarwinNotificationCenter`,
  `Atomic`) + `Info.plist` + `BroadcastExtension.entitlements`.
- `ios/Runner/Runner.entitlements` + `ios/Runner/Info.plist` keys
  (`RTCAppGroupIdentifier`, `RTCScreenSharingExtension`).
- `lib/services/remote_agent_service.dart` — iOS uses `getDisplayMedia({'video':{'deviceId':'broadcast'}})`.
- `ios/tools/add_broadcast_extension.rb` — idempotent script (xcodeproj gem) that
  added the extension target to `Runner.xcodeproj` (already applied + committed).
  Re-run only if the target is ever lost: `gem install xcodeproj && ruby ios/tools/add_broadcast_extension.rb`.

Identifiers (keep consistent): app group `group.de.icd360s.icd360sevMitglied`,
main `de.icd360s.icd360sevMitglied`, extension `de.icd360s.icd360sevMitglied.Broadcast`.

## One-time Apple Developer portal step (signing only)
The build itself runs `--no-codesign`, but for a **signed** TestFlight/App Store
build you must, once:
1. Enable the **App Group** `group.de.icd360s.icd360sevMitglied` on BOTH App IDs
   (`de.icd360s.icd360sevMitglied` and `…​.Broadcast`).
2. Create/attach a provisioning profile for the extension App ID.
(No code changes — just portal + signing config in the release job.)

## Test (real device only — not the Simulator)
1. Member accepts Fernwartung → iOS shows the **system broadcast picker**.
2. Member picks **Fernwartung ▸ Start Broadcast** → the Vorsitzer sees the whole screen.

## If the Vorsitzer sees black
- App group id must match in `Runner.entitlements`, `BroadcastExtension.entitlements`
  and the `RTCAppGroupIdentifier` Info.plist key (exactly `group.de.icd360s.icd360sevMitglied`).
- The extension has a ~50 MB memory limit; `SampleUploader` already JPEG-compresses.
