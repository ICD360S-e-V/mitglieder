# ICD360S e.V - Mitgliederportal (Cross-Platform)

## Platforme Suportate (v1.1.0+)

| Platform | Status | Build Command | Output |
|----------|--------|---------------|--------|
| **Android** | ✅ Production | `flutter build apk --release --flavor fdroid --obfuscate --split-debug-info=build/symbols --split-per-abi` | `build/app/outputs/flutter-apk/app-fdroid-arm64-v8a-release.apk` |
| **iOS** | ✅ Ready | `flutter build ios --release` | Xcode Archive |
| **macOS** | ✅ Working | `flutter build macos --release` | `build/macos/Build/Products/Release/icd360sev_mitglied.app` |
| **Windows** | ✅ Ready | `flutter build windows --release` | `build/windows/x64/runner/Release/` |
| **Linux** | ✅ Ready | `flutter build linux --release` | `build/linux/x64/release/bundle/` |

### Platform-Specific Features

| Feature | Android | iOS | Windows | macOS | Linux |
|---------|---------|-----|---------|-------|-------|
| Background WebSocket | Foreground Service | Background Fetch | Main Isolate | Main Isolate | Main Isolate |
| Notifications | flutter_local_notifications | flutter_local_notifications | flutter_local_notifications | flutter_local_notifications | flutter_local_notifications |
| Auto-Update | APK Download | App Store | EXE Installer | DMG Mount | AppImage Run |
| System Tray | N/A | N/A | ✅ | ✅ | ✅ |
| Device ID Prefix | AND_ | IOS_ | WIN_ | MAC_ | LIN_ |

### Development Environment
- **OS:** macOS (Darwin 25.2.0)
- **Flutter:** 3.41.4 (`/Users/ionut-claudiuduinea/development/flutter/`)
- **Ruby:** 4.0.1 (Homebrew)
- **CocoaPods:** 1.16.2 (`/opt/homebrew/lib/ruby/gems/4.0.0/bin/pod`)

## Format Mitgliedernummer

| Rol | Prefix | Format |
|-----|--------|--------|
| Mitglied | M | M00001 |
| Vorsitzer | V | V00001 |
| Schatzmeister | S | S00001 |
| Kassierer | K | K00001 |
| Mitgliedergrunder | MG | MG00001 |

## Funcționalități

### Start Screen (Tabs)

#### Tab 1: Anmelden (Login)
- Login cu Mitgliedernummer și parolă
- **Anmeldedaten speichern** - salvează credențialele criptat (Android Keystore)
- **Automatisch anmelden** - auto-login la pornirea aplicației
- **Passwort vergessen?** - recuperare parolă cu Mitgliedernummer + Wiederherstellungscode
- **Role-based routing** - Admin roles → Admin Dashboard, Mitglied → Mitglied Dashboard

#### Tab 2: Mitglied werden (Registrare)
- Formular: Name, Email, Passwort, Wiederherstellungscode (6 cifre)
- După succes: Mitgliedernummer generată random (10000-99999)
- Limitare: max 1 cont per device per lună

### Admin Dashboard
Accesibil pentru: vorsitzer, schatzmeister, kassierer, mitgliedergrunder
- Sidebar cu: Mitgliederverwaltung, Ticketverwaltung, **Terminverwaltung**, Vereinverwaltung
- Lista toți utilizatorii cu culori per rol
- Statistici: Total Benutzer, Aktiv, Gesperrt
- Activează/Suspendă/Șterge conturi
- **Click pe membru** → Dialog cu:
  - Tab 1: Edit Name, Email, Parolă, Rol
  - Tab 2: Device/Session management cu force logout per device
- **Protecție cont propriu** - nu poți modifica propriul cont
- **Mitglieder Ansicht** - vizualizare dashboard ca membru

### Terminverwaltung (NEW - v1.0.57+)
**Weekly Calendar System:**
- 📅 Grid 7 coloane: Montag → Sonntag
- 🔢 KW number + date range navigation (< >)
- 🕐 Time slots: 11:00, 🍽️ Mittagspause (12:00-14:00), 14:00-17:00
- 🎨 Color coding: Vorstandssitzung (purple), Mitgliederversammlung (blue), Schulung (green), Sonstiges (amber)
- 🏖️ **Urlaub** în roșu - blochează programări
- ✏️ Click pe termin → Edit dialog (change all fields)
- 🗑️ Delete termine
- 👥 Multi-select participanți cu checkboxes
- 🔗 Optional link la ticket

**Urlaub Management:**
- ➕ Buton "Urlaub" roșu → Create vacation period
- 🏖️ Display în calendar (zilele roșii cu beach icon)
- ✏️ Click pe urlaub → Smart edit:
  - Single day → Delete
  - First day → Remove first OR delete all
  - Last day → Remove last OR delete all
  - Middle day → Delete all only

**Time Restrictions:**
- Termine doar: 11:00-12:00 și 14:00-18:00
- Validare automată la create/edit

### Mitglied Dashboard
- Header cu Mitgliedernummer + status badge (Aktiv/Neu)
- Sidebar: Übersicht, Mitglieder Verwaltung, **Meine Termine**, Mein Profil, Über den Verein
- Profil Dialog cu 6 tabs:
  - Tab "Konto": Email/Parolă ändern
  - Tab "Meine Geräte (X/3)": Device list cu self-service logout
  - Tab "Verifizierung": 8-step identity verification
  - Tab "Verwarnungen": Warnings/sanctions list
  - Tab "Dokumente": Documents from board
  - Tab "Mitgliedschaft": Membership details (status, role, payment, dates)

### Device Management (v1.0.56+)
**Max 3 Devices:**
- Login verifică sesiuni active
- >3 devices → Dialog cu lista pentru selecție
- Auto-logout device selectat + retry login
- Prevent duplicate sessions per device

**Member Self-Service:**
- Tab "Meine Geräte" în profil
- Vezi device name, platform, IP
- Self-service logout per device

### Live Chat & Voice Call

**WebSocket Server:** `wss://icd360sev.icd360s.de/wss/`

| Feature | Descriere |
|---------|-----------|
| Live Chat | Mesaje real-time, typing indicator, istoric |
| Voice Call | WebRTC cu STUN servers, mute/unmute, call timer |
| Auto-reject | După 5 minute fără răspuns |
| Support Status | **REAL-TIME** online/offline (polling: 5s, threshold: 30s) (v1.0.59+) |

### Native Android Notifications
- Mesaj nou în chat
- Apel incoming
- Update disponibil
- Status conexiune
- Android notification channels (chat, calls, updates)

### Background Service (v1.0.61+)

**Persistent WebSocket Connection:**
- Foreground service cu notificare persistentă (rulează permanent)
- Auto-reconnect cu exponential backoff (2-30 secunde)
- Heartbeat ping la fiecare 30 secunde
- Notificări în timp real chiar când app-ul este închis
- Repornește automat după reboot device

**Implementare:**
- Package: `flutter_background_service` + `flutter_background_service_android`
- Service Type: `remoteMessaging` (Android 15+ compatible, no 6h timeout)
- File: `lib/services/background_service.dart`
- Auto-start la boot cu `BootReceiver`
- WiFi lock pentru conexiune stabilă în background

**Permisiuni (AndroidManifest.xml):**
- `FOREGROUND_SERVICE` - Permite foreground service
- `FOREGROUND_SERVICE_REMOTE_MESSAGING` - Pentru WebSocket messaging (SDK 34+)
- `RECEIVE_BOOT_COMPLETED` - Restart după reboot
- `REQUEST_IGNORE_BATTERY_OPTIMIZATIONS` - Exclude de la battery optimization

**Flux de funcționare:**
1. Service pornește automat în `main.dart` cu `BackgroundService.initializeService()`
2. Citește token din `SharedPreferences`
3. Conectează WebSocket: `wss://icd360sev.icd360s.de/wss/` (token trimis în auth message, NU în URL)
4. Menține conexiunea cu ping la fiecare 30 secunde
5. Primește mesaje și apeluri în background
6. Afișează notificări Android native
7. Auto-reconnect dacă conexiunea cade
8. Rămâne activ chiar când app-ul este închis complet

**Notificări din Background:**
- Chat messages → Channel: `chat_messages` (High importance)
- Voice calls → Channel: `voice_calls` (Max importance + Full screen intent)
- Service status → Channel: `background_service_channel` (Low importance)

### Device Key Protection System (v1.0.60+)

**Security Features:**
- Version endpoint protejat cu Device Key authentication
- Changelog endpoint protejat cu Device Key authentication
- Legacy API Key fallback pentru compatibilitate
- User-Agent validation (blochează browser-ele)
- Protected JSON data storage în /api/data/

**Protected Endpoints:**
- `/api/version_mitglieder.php` - Version check (requires Device Key sau Legacy API Key + User-Agent: 'ICD360S-Mitglieder/1.0')
- `/api/changelog_mitglieder.php` - Changelog data (requires Device Key sau Legacy API Key + User-Agent: 'ICD360S-Mitglieder/1.0')

**Data Files (Protected):**
- `/api/data/version_mitglieder.json` (chmod 640, root:nginx) - Current version info
- `/api/data/changelog_mitglieder.json` (chmod 640, root:nginx) - Version history

**Diferența dintre version_mitglieder.json și changelog_mitglieder.json:**
| Fișier | Scop | Conținut |
|--------|------|----------|
| `version_mitglieder.json` | Auto-update system | Versiune curentă, download URL, changelog scurt |
| `changelog_mitglieder.json` | Version history | Istoric complet cu toate versiunile și detalii per categorie |

### Multi-language Support (v1.0.78+)

Aplicația suportă **28 limbi** prin Flutter localization (l10n) cu **558 chei de traducere**.

**Implementare:**
- Package: `flutter_localizations` (Flutter SDK built-in)
- Configurație: `l10n.yaml` în root project
- Fișiere ARB: `lib/l10n/app_XX.arb` (28 fișiere sursă)
- Fișiere auto-generate: `lib/l10n/app_localizations_XX.dart` (27 + 1 base class)
- Server-side translation helper: `/api/helpers/TranslationHelper.php`
- **558 chei** traduse complet în toate cele 28 limbi (login, register, dashboard, chat, tickets, termine, profil, notificări, etc.)

**Limbi suportate:**
| Code | Limbă | Fișier |
|------|-------|--------|
| `de` | Deutsch (German) | `app_localizations_de.dart` |
| `en` | English | `app_localizations_en.dart` |
| `ro` | Română (Romanian) | `app_localizations_ro.dart` |
| `fr` | Français (French) | `app_localizations_fr.dart` |
| `es` | Español (Spanish) | `app_localizations_es.dart` |
| `it` | Italiano (Italian) | `app_localizations_it.dart` |
| `pl` | Polski (Polish) | `app_localizations_pl.dart` |
| `ru` | Русский (Russian) | `app_localizations_ru.dart` |
| `nl` | Nederlands (Dutch) | `app_localizations_nl.dart` |
| `pt` | Português (Portuguese) | `app_localizations_pt.dart` |
| `cs` | Čeština (Czech) | `app_localizations_cs.dart` |
| `sk` | Slovenčina (Slovak) | `app_localizations_sk.dart` |
| `hu` | Magyar (Hungarian) | `app_localizations_hu.dart` |
| `bg` | Български (Bulgarian) | `app_localizations_bg.dart` |
| `hr` | Hrvatski (Croatian) | `app_localizations_hr.dart` |
| `sr` | Српски (Serbian) | `app_localizations_sr.dart` |
| `sl` | Slovenščina (Slovenian) | `app_localizations_sl.dart` |
| `uk` | Українська (Ukrainian) | `app_localizations_uk.dart` |
| `el` | Ελληνικά (Greek) | `app_localizations_el.dart` |
| `da` | Dansk (Danish) | `app_localizations_da.dart` |
| `sv` | Svenska (Swedish) | `app_localizations_sv.dart` |
| `nb` | Norsk Bokmål (Norwegian) | `app_localizations_nb.dart` |
| `fi` | Suomi (Finnish) | `app_localizations_fi.dart` |
| `et` | Eesti (Estonian) | `app_localizations_et.dart` |
| `lt` | Lietuvių (Lithuanian) | `app_localizations_lt.dart` |
| `lv` | Latviešu (Latvian) | `app_localizations_lv.dart` |
| `tr` | Türkçe (Turkish) | `app_localizations_tr.dart` |
| `ar` | العربية (Arabic) | `app_localizations_ar.dart` |

**Folosire în cod:**
```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// In widget
final localizations = AppLocalizations.of(context)!;
Text(localizations.welcome_message);
```

**Auto-detection:**
- Aplicația detectează limba device-ului automat
- Fallback la English dacă limba nu e suportată
- Configurație în `lib/main.dart` cu `localizationsDelegates` și `supportedLocales`

---

### Auto-Update System (v1.0.61+)

**Metoda Principală: F-Droid**
- Utilizatorii instalează via F-Droid repository custom
- F-Droid verifică automat actualizări la fiecare 12-24 ore
- Descarcă APK automat în fundal
- Afișează notificare când update-ul e gata
- Utilizatorul confirmă instalarea (1 click)

**Metoda Fallback: Auto-Update Intern**
- **Verificare automată:** La fiecare 24 ore (Timer în LegalFooter)
- Backup pentru utilizatori care nu folosesc F-Droid
- Folosește endpoint protejat: `/api/version_mitglieder.php`

**Flux update Android:**
1. User apasă "Jetzt aktualisieren" în UpdateDialog
2. App descarcă APK cu progress bar
3. Cere permisiune REQUEST_INSTALL_PACKAGES (Android 8+)
4. Lansează installer Android cu OpenFilex package
5. User trebuie să confirme instalarea manual (Android security)

**Fișiere implicate:**
- `lib/services/update_service.dart` - Download APK + launch installer
- `lib/widgets/update_dialog.dart` - UI pentru download + progress
- `lib/widgets/legal_footer.dart` - Timer 24 ore pentru verificare

### Diagnostic Service
- Trimite starea aplicației la fiecare 15 secunde
- Endpoint: `/api/diagnostic/log.php`

## API Endpoints (278 PHP files total)

### Auth (28 endpoints)
| Endpoint | Method | Descriere |
|----------|--------|-----------|
| `/api/auth/login_mitglied.php` | POST | Login (MITGLIED APP - permite doar rol: mitglied) |
| `/api/auth/login_vorsitzer.php` | POST | Login (VORSITZER APP - permite doar admin roles) |
| `/api/auth/login_schatzmeister.php` | POST | Login (SCHATZMEISTER APP) |
| `/api/auth/register.php` | POST | Registrare cu device_id limit |
| `/api/auth/recover.php` | POST | Recuperare parolă cu Wiederherstellungscode |
| `/api/auth/change_password.php` | POST | Schimbă parola utilizator |
| `/api/auth/change_email.php` | POST | Schimbă email utilizator |
| `/api/auth/validate.php` | POST | Validare token JWT |
| `/api/auth/refresh.php` | POST | Refresh token JWT |
| `/api/auth/check_email.php` | POST | Verifică disponibilitate email |
| `/api/auth/get_profile.php` | GET | Get profil utilizator complet |
| `/api/auth/update_profile.php` | POST | Update name, email, password |
| `/api/auth/account_status.php` | GET | Get status cont (active/suspended/trial) |
| `/api/auth/delete_account.php` | POST | Șterge cont propriu (self-service) |
| `/api/auth/heartbeat.php` | POST | Heartbeat pentru WebSocket session |
| `/api/auth/heartbeat_app.php` | POST | Heartbeat pentru app keepalive |
| `/api/auth/logout_device.php` | POST | Logout device înainte de login (max 3 devices) |
| `/api/auth/my_sessions.php` | GET | My active sessions cu device details |
| `/api/auth/revoke_my_session.php` | POST | Self-service logout per device |
| `/api/auth/accept_document.php` | POST | Accept document (terms, privacy) |
| `/api/auth/my_dokumente.php` | GET | My documents list |
| `/api/auth/my_dokumente_download.php` | GET | Download own document |
| `/api/auth/my_verifizierung.php` | GET | My verification status |
| `/api/auth/my_verwarnungen.php` | GET | My warnings list |
| `/api/auth/update_mitgliedsart.php` | POST | Update membership type |
| `/api/auth/update_personal_data.php` | POST | Update personal data |
| `/api/auth/update_zahlungsmethode.php` | POST | Update payment method |
| `/api/auth/turn_credentials.php` | POST | TURN/STUN server credentials for WebRTC (JWT protected) |

### Admin (135 endpoints)
| Endpoint | Method | Descriere |
|----------|--------|-----------|
| `/api/admin/users.php` | GET | Lista utilizatori |
| `/api/admin/user_status.php` | POST | Schimbă status |
| `/api/admin/user_delete.php` | POST | Șterge user |
| `/api/admin/user_details.php` | POST | Get user + sessions + devices |
| `/api/admin/user_update.php` | POST | Update name/email/password/rol |
| `/api/admin/session_revoke.php` | POST | Force logout device |
| `/api/admin/admin_register.php` | POST | Register admin account |
| `/api/admin/vereineinstellungen.php` | GET/POST | Vereinseinstellungen management |
| `/api/admin/status_message.php` | GET/POST | Status message management |
| `/api/admin/termine_*` | POST | Termine CRUD (create, list, details, update, delete) |
| `/api/admin/urlaub_*` | POST | Urlaub CRUD (create, list, update, delete) |
| `/api/admin/feiertage_list.php` | GET | Feiertage (holidays) list |
| `/api/admin/dokumente_*` | POST | Dokumente management (upload, download, list, delete) |
| `/api/admin/verifizierung_*` | POST | Verifizierung management (list, update) |
| `/api/admin/verwarnungen_*` | POST | Verwarnungen management (create, list, delete) |
| `/api/admin/befreiung_*` | POST | Befreiung management (upload, download, list, update, delete) |
| `/api/admin/ermaessigung_*` | POST | Ermäßigung management (list, update, delete, download, poll, remind) |
| `/api/admin/archiv_*` | POST | Archiv management (upload, download, list, delete) |
| `/api/admin/notizen_*` | POST | Notizen management (create, list, delete) |
| `/api/admin/routine_*` | POST | Routine management (create, list, update, delete, executions) |
| `/api/admin/handelsregister.php` | GET/POST | Handelsregister management |
| `/api/admin/handelsregister_document.php` | GET | Handelsregister document download |
| `/api/admin/finanzamt/*` | GET/POST | Finanzamt dokumente & download |
| `/api/admin/finanzverwaltung/*` | GET/POST | Beitragszahlungen, Spenden, Transaktionen |

### Member (6 endpoints)
| Endpoint | Method | Descriere |
|----------|--------|-----------|
| `/api/member/update_personal_data.php` | POST | Update personal data |
| `/api/member/update_finanzielle_situation.php` | POST | Update financial situation |
| `/api/member/update_mitgliedschaftsbeginn.php` | POST | Update membership start date |
| `/api/member/update_zahlungsdaten.php` | POST | Update payment data |
| `/api/member/upload_leistungsbescheid.php` | POST | Upload Leistungsbescheid document |
| `/api/member/verifizierung_list.php` | GET | Verifizierung steps list |

### Termine (3 endpoints)
| Endpoint | Method | Descriere |
|----------|--------|-----------|
| `/api/termine/calendar.php` | GET | Calendar view cu termine + urlaub |
| `/api/termine/my_termine.php` | GET | My termine (member view) |
| `/api/termine/respond.php` | POST | Confirm/Decline/Reschedule termin |

### Chat & Messaging (13 endpoints)
| Endpoint | Method | Descriere |
|----------|--------|-----------|
| `/api/chat/start.php` | POST | Start new conversation (member → support) |
| `/api/chat/admin_start.php` | POST | Start conversation from admin side |
| `/api/chat/conversations.php` | GET | Lista conversații active |
| `/api/chat/messages.php` | GET | Get messages from conversation cu pagination |
| `/api/chat/send.php` | POST | Send message text sau cu attachment |
| `/api/chat/mark_read.php` | POST | Mark messages as read |
| `/api/chat/close.php` | POST | Close conversation |
| `/api/chat/upload.php` | POST | Upload file attachment (images, PDF, docs) |
| `/api/chat/download.php` | GET | Download file attachment |
| `/api/chat/support_status.php` | POST | Get support online status (real-time polling 5s) |
| `/api/chat/mute.php` | POST | Mute/unmute conversation |
| `/api/chat/scheduled_messages.php` | GET/POST | Scheduled messages management |
| `/api/chat/conversation_scheduled.php` | GET | Get scheduled messages for conversation |

### Tickets (29 endpoints)
| Endpoint | Method | Descriere |
|----------|--------|-----------|
| `/api/tickets/create.php` | POST | Create new ticket cu priority și category |
| `/api/tickets/admin_create.php` | POST | Admin create ticket |
| `/api/tickets/list.php` | GET | Lista ticket-uri utilizator (cu filters) |
| `/api/tickets/admin_list.php` | GET | Lista toate ticket-urile (admin cu search) |
| `/api/tickets/update.php` | POST | Update ticket status/priority/assignee |
| `/api/tickets/mark_viewed.php` | POST | Mark ticket as viewed by member |
| `/api/tickets/poll_notifications.php` | GET | Poll ticket updates (admin) |
| `/api/tickets/poll_notifications_member.php` | GET | Poll ticket updates (member) |
| `/api/tickets/attachments/upload.php` | POST | Upload ticket attachment |
| `/api/tickets/attachments/download.php` | GET | Download ticket attachment |
| `/api/tickets/attachments/delete.php` | POST | Delete ticket attachment |
| `/api/tickets/comments/add.php` | POST | Add comment to ticket |
| `/api/tickets/comments/list.php` | GET | Get comments for ticket |
| `/api/tickets/categories/list.php` | GET | Get ticket categories |
| `/api/tickets/history/list.php` | GET | Get ticket history/changelog |
| `/api/tickets/time/add.php` | POST | Add time entry |
| `/api/tickets/time/delete.php` | POST | Delete time entry |
| `/api/tickets/time/list.php` | GET | List time entries |
| `/api/tickets/time/running.php` | GET | Get running timer |
| `/api/tickets/time/start.php` | POST | Start time tracking |
| `/api/tickets/time/stop.php` | POST | Stop time tracking |
| `/api/tickets/time/sync.php` | POST | Sync time entries |
| `/api/tickets/time/user_summary.php` | GET | User time summary |
| `/api/tickets/time/weekly.php` | GET | Weekly time report |

### Platform (15 endpoints)
| Endpoint | Method | Descriere |
|----------|--------|-----------|
| `/api/platform/aufgaben_*` | POST | Aufgaben CRUD (create, list, update, delete) |
| `/api/platform/notizen_*` | POST | Notizen CRUD (create, list, delete) |
| `/api/platform/postcard_*` | POST | Postcard management (create, list, update, delete, account_get, account_save) |
| `/api/platform/get_credentials.php` | GET | Get platform credentials |
| `/api/platform/save_credentials.php` | POST | Save platform credentials |

### Stadtverwaltung (6 endpoints)
| Endpoint | Method | Descriere |
|----------|--------|-----------|
| `/api/stadtverwaltung/behoerden.php` | GET | Behörden list |
| `/api/stadtverwaltung/drogerien.php` | GET | Drogerien list |
| `/api/stadtverwaltung/krankenhaeuser.php` | GET | Krankenhäuser list |
| `/api/stadtverwaltung/krankenkassen.php` | GET | Krankenkassen list |
| `/api/stadtverwaltung/maerkte.php` | GET | Märkte list |
| `/api/stadtverwaltung/praxen.php` | GET | Praxen list |

### Tracking (3 endpoints)
| Endpoint | Method | Descriere |
|----------|--------|-----------|
| `/api/tracking/dhl.php` | GET/POST | DHL tracking |
| `/api/tracking/dhl_settings.php` | GET/POST | DHL settings |
| `/api/tracking/filialfinder.php` | GET | Filialfinder |

### Vereinverwaltung (3 endpoints)
| Endpoint | Method | Descriere |
|----------|--------|-----------|
| `/api/vereinverwaltung/get.php` | GET | Get informații despre asociație |
| `/api/vereinverwaltung/update.php` | POST | Update informații asociație (admin) |

### Notar (5 endpoints)
| Endpoint | Method | Descriere |
|----------|--------|-----------|
| `/api/notar/besuche.php` | GET/POST | Manage vizite notar |
| `/api/notar/dokumente.php` | GET/POST | Manage documente notariale |
| `/api/notar/rechnungen.php` | GET/POST | Manage facturi notar |
| `/api/notar/zahlungen.php` | GET/POST | Manage plăți notar |
| `/api/notar/aufgaben.php` | GET/POST | Manage notar tasks |

### Logging & Diagnostics (7 endpoints)
| Endpoint | Method | Descriere |
|----------|--------|-----------|
| `/api/diagnostic/log.php` | POST | Log diagnostic data (every 15s) |
| `/api/logs/store.php` | POST | Store app logs generic |
| `/api/logs/debug.php` | POST | Debug logging cu stack traces |
| `/api/logs/mitglieder_android.php` | POST | Android member app logs (every 30s) |
| `/api/logs/mitglieder_windows.php` | POST | Windows member app logs |
| `/api/logs/vorsitzer_logs.php` | POST | Vorsitzer app logs |
| `/api/logs/schatzmeister_logs.php` | POST | Schatzmeister app logs |

### Version & Changelog (Protected)
| Endpoint | Method | Descriere |
|----------|--------|-----------|
| `/api/version_mitglieder.php` | GET | Version check (Device Key protected) - Platform detection |
| `/api/changelog_mitglieder.php` | GET | Changelog data (Device Key protected) - Platform detection |
| `/api/version_vorsitzer.php` | GET | Vorsitzer app version check |
| `/api/changelog_vorsitzer.php` | GET | Vorsitzer app changelog |
| `/api/version_schatzmeister.php` | GET | Schatzmeister app version check |
| `/api/changelog_schatzmeister.php` | GET | Schatzmeister app changelog |

### FCM & Push Notifications (2 endpoints)
| Endpoint | Method | Descriere |
|----------|--------|-----------|
| `/api/fcm/register.php` | POST | Register FCM token pentru push notifications |
| `/api/fcm/unregister.php` | POST | Unregister FCM token on logout |

### Device Management (2 endpoints)
| Endpoint | Method | Descriere |
|----------|--------|-----------|
| `/api/device/register.php` | POST | Register new device cu device key |
| `/api/device/validate.php` | POST | Validate device key |

### Helper Services (5 helper files - SERVER-SIDE)
| File | Descriere |
|------|-----------|
| `/api/helpers/FcmService.php` | Firebase Cloud Messaging service helper |
| `/api/helpers/NtfyService.php` | Ntfy push notification service helper |
| `/api/helpers/TranslationHelper.php` | Multi-language translation helper (25+ limbi) |
| `/api/helpers/WebSocketNotifier.php` | WebSocket notification sender helper |
| `/api/helpers/ip_helper.php` | IP address helper functions |
| `/api/helpers.php` | General helper functions (legacy) |

### Cron Jobs (6 endpoints)
| Endpoint | Schedule | Descriere |
|----------|----------|-----------|
| `/api/cron/auto_suspend.php` | Daily 02:00 | Auto-suspend inactive accounts |
| `/api/cron/send_scheduled_messages.php` | Every minute | Send scheduled chat messages |
| `/api/cron/cleanup_old_scheduled_messages.php` | Daily 03:00 | Cleanup old scheduled messages |
| `/api/cron/auto_delete_expired_docs.php` | Daily 03:00 | Auto-delete expired documents |
| `/api/cron/cleanup_chat.php` | Daily 03:00 | Cleanup old chat data |

## Structura Proiect (62 Dart source files + 28 ARB + 29 auto-generated, ~25,884 LOC)

```
lib/
├── main.dart                              # App entry point (106 lines)
├── models/
│   └── user.dart                          # User model (75 lines)
├── services/ (21 files incl. platform/ - 7,322 LOC)
│   ├── api_service.dart                   # HTTP requests + token management (1122 lines)
│   ├── background_service.dart            # Persistent WebSocket background service (599 lines)
│   ├── chat_service.dart                  # WebSocket chat + call signaling (671 lines)
│   ├── device_key_service.dart            # Device registration + validation (270 lines)
│   ├── diagnostic_service.dart            # App diagnostics (159 lines)
│   ├── heartbeat_service.dart             # WebSocket heartbeat/keepalive (94 lines)
│   ├── http_client_factory.dart           # Certificate pinning HttpClient factory - ISRG Root X1 (95 lines)
│   ├── logger_service.dart                # Debug logging + device ID (236 lines)
│   ├── network_info_service.dart          # Network diagnostics - WiFi/4G/5G/offline + latency (93 lines)
│   ├── notification_service.dart          # Native Android notifications (438 lines)
│   ├── ntfy_service.dart                  # Ntfy push notifications via NDJSON stream (132 lines)
│   ├── secure_storage_helper.dart         # Fixed macOS Keychain options (32 lines)
│   ├── termin_service.dart                # Termine + Urlaub management (528 lines)
│   ├── ticket_notification_service.dart   # Ticket polling with WorkManager (290 lines)
│   ├── ticket_service.dart                # Ticket CRUD operations (690 lines)
│   ├── update_service.dart                # Auto-update checker (APK download, check: 24h) (260 lines)
│   ├── voice_call_service.dart            # WebRTC voice calls - TURN from server (680 lines)
│   └── platform/                          # Platform-specific services
│       ├── platform_service.dart          # Platform service interface (114 lines)
│       ├── platform_factory.dart          # Platform factory (62 lines)
│       ├── mobile_platform_service.dart   # Mobile implementation (226 lines)
│       └── desktop_platform_service.dart  # Desktop implementation (522 lines)
├── l10n/ (28 ARB source + 29 auto-generated Dart - 558 translation keys)
│   ├── app_de.arb ... app_uk.arb          # 28 ARB translation source files
│   ├── app_localizations.dart             # Base localization class (auto-generated)
│   └── app_localizations_XX.dart          # 28 language implementations (auto-generated)
├── screens/ (5 total - 2,633 LOC)
│   ├── login.dart                    # Login tab + authentication UI (461 lines)
│   ├── mitglied_dashboard.dart       # Member dashboard (1189 lines)
│   ├── register.dart                 # Registration tab + new user form (229 lines)
│   ├── webview_screen.dart           # Embedded WebView (192 lines)
│   └── welcome.dart                  # Welcome screen with login/register tabs (562 lines)
├── utils/ (2 total - 366 LOC)
│   ├── responsive.dart               # Responsive UI helpers (305 lines)
│   └── role_helpers.dart             # Role-based permissions & utilities (61 lines)
└── widgets/ (33 total - 15,460 LOC)
    ├── changelog_dialog.dart              # Changelog viewer (version history) (376 lines)
    ├── chat_attachment_item.dart          # Chat file attachment display (95 lines)
    ├── chat_header.dart                   # Chat dialog header (193 lines)
    ├── chat_input_area.dart               # Chat message input (101 lines)
    ├── chat_message_bubble.dart           # Chat message bubble (152 lines)
    ├── conversation_list_item.dart        # Conversation item in list (112 lines)
    ├── debug_console.dart                 # Debug console overlay (179 lines)
    ├── diagnostic_consent_dialog.dart     # Diagnostic consent dialog (146 lines)
    ├── dokumente_tab.dart                 # Documents management tab (416 lines)
    ├── eastern.dart                       # Seasonal Easter/Spring theme overlay (748 lines)
    ├── file_viewer.dart                   # Internal PDF + image viewer (113 lines)
    ├── forgot_password_dialog.dart        # Password recovery dialog (333 lines)
    ├── incoming_call_dialog.dart          # Voice call UI (incoming + in-call) (523 lines)
    ├── legal_footer.dart                  # Footer cu versiune + auto-update check (1150 lines)
    ├── live_chat_dialog.dart              # Live chat dialog (member) (1795 lines)
    ├── login_tab.dart                     # Login tab content (312 lines)
    ├── member_calendar_view.dart          # Member calendar for termine viewing (742 lines)
    ├── member_ticket_details_dialog.dart  # Ticket details viewer for members (834 lines)
    ├── mitglied_appbar.dart               # Member dashboard app bar (349 lines)
    ├── mitglied_banners.dart              # Member dashboard banners (104 lines)
    ├── mitglied_cards.dart                # Member dashboard cards (347 lines)
    ├── mitglied_profile_dialog.dart       # Member profile dialog (6 tabs) (1079 lines)
    ├── mitglied_sidebar.dart              # Member dashboard sidebar (166 lines)
    ├── mitgliedschaft_tab.dart            # Membership management tab (344 lines)
    ├── native_call_screen.dart            # Native call screen widget (483 lines)
    ├── new_ticket_dialog.dart             # Ticket creation dialog (302 lines)
    ├── personal_data_dialog.dart          # Personal data management (411 lines)
    ├── profile_dialog.dart                # Admin profile dialog (478 lines)
    ├── register_tab.dart                  # Registration tab content (538 lines)
    ├── ticket_dialogs.dart                # Ticket dialog exports/wrapper (35 lines)
    ├── update_dialog.dart                 # Update download/install dialog (194 lines)
    ├── verifizierung_tab.dart             # Member verification/documents tab (1956 lines)
    └── verwarnungen_tab.dart              # Member warnings/sanctions tab (320 lines)

android/
├── app/
│   ├── build.gradle.kts              # App-level Gradle config
│   └── src/main/
│       ├── AndroidManifest.xml       # App permissions & config
│       └── kotlin/                   # Native Android code (if needed)
├── gradle/
│   └── wrapper/                      # Gradle wrapper
├── settings.gradle.kts               # Project-level Gradle config
└── build.gradle.kts                  # Root build config

**Note:** No assets/ directory exists in project (app icon configured in android/app/src/main/res/)
```

## Pachete Flutter (Android)

```yaml
dependencies:
  # Core Flutter
  flutter:
    sdk: flutter
  flutter_localizations:                    # Multi-language support (25+ limbi) 🆕
    sdk: flutter
  cupertino_icons: ^1.0.8                   # iOS-style icons

  # Network & API
  http: ^1.2.0                              # HTTP requests
  web_socket_channel: ^3.0.1                # WebSocket
  url_launcher: ^6.2.0                      # URL opening

  # State Management & Storage
  shared_preferences: ^2.3.0                # Local storage
  provider: ^6.1.0                          # State management
  flutter_secure_storage: ^10.0.0           # Encrypted credentials (Android Keystore)

  # Media & Communication
  flutter_webrtc: ^1.2.1                    # WebRTC voice calls
  flutter_local_notifications: ^21.0.0      # Android notifications (named params API)
  noise_meter: ^5.0.1                       # Voice activity detection (real microphone)
  image_picker: ^1.0.7                      # Camera & gallery 🆕
  file_picker: ^10.3.10                      # Document picker

  # Device & System
  device_info_plus: ^12.3.0                 # Device identification
  path_provider: ^2.1.0                     # System paths
  uuid: ^3.0.7                              # UUID generation
  permission_handler: ^12.0.1               # Runtime permissions
  open_filex: ^4.5.0                        # APK installer launch
  webview_flutter: ^4.4.0                   # WebView

  # Network & Connectivity
  connectivity_plus: ^6.1.4                 # Network type detection (WiFi/4G/5G/offline) 🆕

  # Background & Utilities
  flutter_background_service: ^5.0.10       # Background service for persistent WebSocket
  flutter_background_service_android: ^6.2.4 # Android implementation
  workmanager: ^0.9.0                       # Background task scheduling (ticket polling)
  intl: ^0.20.2                             # Date formatting & localization

  # Desktop-only (included in pubspec but only active on desktop platforms)
  window_manager: ^0.5.1                    # Window management (desktop)
  screen_retriever: ^0.2.0                  # Screen info (desktop)
  tray_manager: ^0.5.2                      # System tray (desktop) - replaced system_tray (abandoned 2023)
  launch_at_startup: ^0.5.1                 # Auto-start (desktop)

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0                     # Linting rules
```

**New Packages since v1.1.0:**
- ✅ `connectivity_plus` - Network type detection pentru Netzwerk-Diagnose (v1.1.4)
- ✅ `workmanager` - Background task scheduling pentru ticket polling
- ✅ `image_picker` - Camera și gallery access pentru attachments
- ✅ `file_picker` - Document picker pentru attachments (PDF, TXT, etc.)
- ✅ `flutter_localizations` - Multi-language support (implicit în Flutter SDK)

## Build Commands (Android)

### 📱 Multi-Store Build System (v1.0.87+)

Aplicația suportă **5 magazine Android** cu build flavors configurate în `android/app/build.gradle.kts`.

#### **Magazine Suportate:**

| # | Magazin | Users | Format | Flavor | Application ID |
|---|---------|-------|--------|--------|----------------|
| 1 | **F-Droid** (PRIMARY) | FOSS community | APK | `fdroid` | `de.icd360s.mitglieder` |
| 2 | **Google Play** | 2.5 billion+ | AAB/APK | `googleplay` | `de.icd360s.mitglieder.googleplay` |
| 3 | **Huawei AppGallery** | 580 million+ (3rd!) | APK | `huawei` | `de.icd360s.mitglieder.huawei` |
| 4 | **Amazon Appstore** | 500 million+ | APK | `amazon` | `de.icd360s.mitglieder.amazon` |
| 5 | **Samsung Galaxy** | 100 million+ | APK | `samsung` | `de.icd360s.mitglieder.samsung` |

**Total reach potențial:** 3.5+ billion devices! 🌍

---

### 🚀 Build All Stores (ONE COMMAND)

```bash
# Build pentru toate cele 5 magazine automat
cd ~/Documents/icd360sev_mitglieder_android
./build_all_stores.sh

# Output: 6 fișiere în build/releases/
# ✅ icd360sev-fdroid.apk
# ✅ icd360sev-googleplay.aab (Android App Bundle - preferred)
# ✅ icd360sev-googleplay.apk (APK fallback)
# ✅ icd360sev-amazon.apk
# ✅ icd360sev-huawei.apk
# ✅ icd360sev-samsung.apk
```

---

### 📦 Build Individual Stores

#### 1. F-DROID (FOSS Distribution)
```bash
flutter build apk --release --flavor fdroid \
  --obfuscate --split-debug-info=build/symbols --split-per-abi
# Output: build/app/outputs/flutter-apk/app-fdroid-arm64-v8a-release.apk (~50MB)
# Symbols: build/symbols/ (save for crash de-obfuscation!)
```

**Ce este FOSS?**
- **FOSS** = Free and Open Source Software
- **FREE** = Gratuit + Libertate de modificare/redistribuire
- **OPEN SOURCE** = Cod sursă public, licență permisivă (GPL, MIT, Apache)
- **F-Droid cerințe:** Fără Google Services, fără tracking, fără ads

**Upload F-Droid:**
```bash
# Copy to server F-Droid repo
scp -i "vps_icd360sev_icd360s.de" -P 36000 \
  build/app/outputs/flutter-apk/app-fdroid-arm64-v8a-release.apk \
  root@icd360sev.icd360s.de:/var/www/icd360sev.icd360s.de/fdroid/repo/icd360sev.apk

# Regenerate F-Droid index
ssh -i "vps_icd360sev_icd360s.de" -p 36000 root@icd360sev.icd360s.de \
  "cd /var/www/icd360sev.icd360s.de/fdroid && fdroid update"
```

**Salvare symbols pentru debugging:**
```bash
# După fiecare release, salvează symbols-urile!
mkdir -p ~/symbols/v$(grep 'version:' pubspec.yaml | awk '{print $2}' | cut -d'+' -f1)
cp -r build/symbols/* ~/symbols/v$(grep 'version:' pubspec.yaml | awk '{print $2}' | cut -d'+' -f1)/

# De-obfuscate crash report:
flutter symbolize -i crash_log.txt -d ~/symbols/v1.1.5/
```

#### 2. GOOGLE PLAY STORE
```bash
# AAB (Android App Bundle) - PREFERRED (Google handles ABI splitting)
flutter build appbundle --release --flavor googleplay \
  --obfuscate --split-debug-info=build/symbols
# Output: build/app/outputs/bundle/googleplayRelease/app-googleplay-release.aab

# APK (testing/fallback)
flutter build apk --release --flavor googleplay \
  --obfuscate --split-debug-info=build/symbols --split-per-abi
# Output: build/app/outputs/flutter-apk/app-googleplay-arm64-v8a-release.apk
```

**Upload:** https://play.google.com/console → Upload AAB

#### 3. AMAZON APPSTORE
```bash
flutter build apk --release --flavor amazon \
  --obfuscate --split-debug-info=build/symbols --split-per-abi
# Output: build/app/outputs/flutter-apk/app-amazon-arm64-v8a-release.apk
```

**Upload:** https://developer.amazon.com → Upload APK

#### 4. HUAWEI APPGALLERY
```bash
flutter build apk --release --flavor huawei \
  --obfuscate --split-debug-info=build/symbols --split-per-abi
# Output: build/app/outputs/flutter-apk/app-huawei-arm64-v8a-release.apk
```

**Upload:** https://developer.huawei.com → Upload APK

#### 5. SAMSUNG GALAXY STORE
```bash
flutter build apk --release --flavor samsung \
  --obfuscate --split-debug-info=build/symbols --split-per-abi
# Output: build/app/outputs/flutter-apk/app-samsung-arm64-v8a-release.apk
```

**Upload:** https://seller.samsungapps.com → Upload APK

---

### Common Build Commands (All Flavors)
```bash
# Full clean rebuild
cd ~/Documents/icd360sev_mitglieder_android
rm -rf build/
flutter clean
flutter pub get

# Then build specific flavor (see above)
```

---

### 🔒 Obfuscation & Debug Symbols

**TOATE release builds TREBUIE să includă aceste flag-uri:**
```bash
--obfuscate --split-debug-info=build/symbols --split-per-abi
```

| Flag | Ce face | De ce |
|------|---------|-------|
| `--obfuscate` | Face codul Dart ilizibil după decompilare | Securitate: nimeni nu poate citi logica din APK |
| `--split-debug-info=build/symbols` | Salvează symbol maps separat | Permite de-obfuscation crash reports |
| `--split-per-abi` | Generează APK per arhitectură (arm64-v8a) | Reduce dimensiunea: ~98MB → ~50MB |

**⚠️ IMPORTANT: După fiecare release, salvează symbols!**
```bash
# Salvează symbols pentru versiunea curentă
mkdir -p ~/symbols/vX.X.X
cp -r build/symbols/* ~/symbols/vX.X.X/

# De-obfuscate un crash report:
flutter symbolize -i crash_log.txt -d ~/symbols/vX.X.X/
```

Fără symbols, crash reports-urile de la utilizatori vor arăta `Error in a.b at line 42` în loc de `Error in ApiService.login at line 142`.

---

### 🏪 Multi-Store Dependencies Strategy

**STRATEGIA CURENTĂ: Universal APK** ✅

Aplicația folosește **ACELAȘI COD** pentru toate cele 5 flavors.

#### **Ce conține fiecare APK:**

| Component | F-Droid | Google Play | Huawei | Amazon | Samsung |
|-----------|---------|-------------|--------|--------|---------|
| **Backend** | ✅ Propriu | ✅ Propriu | ✅ Propriu | ✅ Propriu | ✅ Propriu |
| **WebSocket** | ✅ WSS | ✅ WSS | ✅ WSS | ✅ WSS | ✅ WSS |
| **Notifications** | ✅ Local | ✅ Local | ✅ Local | ✅ Local | ✅ Local |
| **Auto-update** | ✅ F-Droid | ✅ APK download | ✅ APK download | ✅ APK download | ✅ APK download |
| **Google Services** | ❌ None | ❌ None | ❌ None | ❌ None | ❌ None |
| **HMS** | ❌ None | ❌ None | ❌ None | ❌ None | ❌ None |
| **Maps** | ⚠️ N/A | ⚠️ N/A | ⚠️ N/A | ⚠️ N/A | ⚠️ N/A |

**Diferențe între flavors:**
```
Doar 2 parametri diferă:
1. applicationId (base vs base+suffix)
2. versionName (X.X.X vs X.X.X-gp/amz/huawei/galaxy)

Cod Dart: IDENTIC
Dependencies: IDENTICE
Features: IDENTICE
Size: ~50 MB (arm64-v8a, cu --split-per-abi)
```

**Avantaje strategiei curente:**
- ✅ **Simplitate maximă** - maintenance ușor
- ✅ **F-Droid compatible** - FOSS requirements met
- ✅ **Works on all stores** - no Google dependency
- ✅ **Huawei compatible** - works without GMS
- ✅ **Fire OS compatible** - works without Google
- ✅ **Un singur codebase** - no conditional imports

**Când să schimbi strategia:**
```
Adaugă dependencies condiționate DOAR dacă:
1. Ai nevoie de Google Maps (nu OpenStreetMap)
2. Vrei Firebase push (mai bun decât local notifications)
3. Vrei In-App Purchases (Google Billing, HMS IAP, etc.)
4. Vrei Analytics specific per store

Altfel: KEEP IT SIMPLE! ✅
```

**Note:**
- Google Play NU cere Google Services (sunt opționale!)
- App-ul nostru e 100% functional fără Google Services
- Majoritatea apps pot funcționa independent de GMS
- Pentru documentație detaliată despre dependencies condiționate, vezi: `MULTI_STORE_STRATEGY.md`

---

## Structura Server Downloads & Protected Data

**⚠️ IMPORTANT:** Pe server există directoare separate pentru aplicații Android și Windows:

```
/var/www/icd360sev.icd360s.de/
├── api/
│   ├── version_mitglieder.php           → Protected endpoint (Device Key auth)
│   ├── changelog_mitglieder.php         → Protected endpoint (Device Key auth)
│   ├── version_vorsitzer.php            → Vorsitzer app version endpoint
│   ├── changelog_vorsitzer.php          → Vorsitzer app changelog endpoint
│   ├── version_schatzmeister.php        → Schatzmeister app version endpoint
│   ├── changelog_schatzmeister.php      → Schatzmeister app changelog endpoint
│   ├── config.php                       → Database config
│   ├── helpers.php                      → Helper functions (legacy)
│   ├── debug_messages.php               → Debug message viewer
│   ├── admin/                           → Admin endpoints (135 files)
│   ├── auth/                            → Authentication endpoints (27 files)
│   ├── chat/                            → Chat & messaging (13 files)
│   ├── termine/                         → Termine management (3 files)
│   ├── tickets/                         → Ticket system (29 files in subdirs incl. time/)
│   ├── member/                          → Member-specific endpoints (6 files)
│   ├── platform/                        → Platform management (15 files)
│   ├── stadtverwaltung/                 → City services (6 files)
│   ├── tracking/                        → DHL tracking (3 files)
│   ├── device/                          → Device management (2 files)
│   ├── diagnostic/                      → Diagnostics (1 file)
│   ├── logs/                            → Logging endpoints (6 files)
│   ├── fcm/                             → Firebase Cloud Messaging (2 files)
│   ├── helpers/                         → Helper services (5 files incl. ip_helper)
│   ├── notar/                           → Notar system (5 files incl. aufgaben)
│   ├── vereinverwaltung/                → Association management (3 files)
│   ├── cron/                            → Cron jobs (6 files)
│   └── data/                            → Protected JSON storage
│       ├── version_mitglieder_android.json   (Android version)
│       ├── version_mitglieder.json           (Legacy/Windows fallback)
│       ├── version_vorsitzer.json            (Vorsitzer app version)
│       ├── version_schatzmeister.json        (Schatzmeister app version)
│       ├── changelog_mitglieder_android.json (Android changelog)
│       ├── changelog_mitglieder.json         (Legacy/Windows changelog)
│       ├── changelog_vorsitzer.json          (Vorsitzer changelog)
│       ├── changelog_schatzmeister.json      (Schatzmeister changelog)
│       └── ws_queue/                         (WebSocket message queue)
├── downloads/
│   ├── mitglieder/
│   │   ├── android/                     ← ⚠️ ANDROID APP (ACEST PROIECT)
│   │   │   ├── icd360sev.apk           → Latest release (~90 MB)
│   │   │   └── icd360sev_stable.apk    → Rollback version
│   │   └── windows/                     ← Windows desktop app
│   │       ├── icd360sev_setup.exe      → Windows installer
│   │       └── icd360sev_setup_stable.exe → Rollback installer
│   ├── schatzmeister/windows/           ← Schatzmeister app (placeholder)
│   └── vorsitzer/windows/               ← Vorsitzer Windows app
│       ├── icd360sev_vorsitzer_setup.exe
│       └── icd360sev_vorsitzer_setup_stable.exe
├── fdroid/                              ← F-Droid custom repository
│   ├── config.yml                       (Repository config)
│   ├── keystore.jks                     (Signing keystore)
│   ├── metadata/
│   │   └── de.icd360s.mitglieder.yml   (App metadata)
│   └── repo/
│       ├── icd360sev.apk               (Mitglieder APK)
│       ├── icd360sev_schatzmeister.apk  (Schatzmeister APK)
│       ├── index.jar, index-v1.jar     (Signed indexes)
│       ├── index-v2.json               (v2 format)
│       └── icons/                       (App icons per DPI)
├── websocket/                           ← WebSocket server (PHP/Ratchet)
│   ├── server.php                       (WebSocket server entry)
│   ├── composer.json                    (Dependencies)
│   └── src/                             (Source code)
├── uploads/                             ← User uploads (documents, attachments)
├── icd360s_client/                      ← Client-side assets
├── .git/                                ← Git repository (auto-push every 15min)
└── CLAUDE.md                            ← Server-side CLAUDE.md
```

**Total API Endpoints:** 278 PHP files (including helpers, config)

**Update Service URLs:**
- Version Check: `https://icd360sev.icd360s.de/api/version_mitglieder.php` (Protected cu Device Key)
  - Platform detection: User-Agent conține "Android" → `version_mitglieder_android.json`
  - Altfel (Windows) → `version_mitglieder.json`
- Changelog: `https://icd360sev.icd360s.de/api/changelog_mitglieder.php` (Protected cu Device Key)
  - Platform detection: User-Agent conține "Android" → `changelog_mitglieder_android.json`
  - Altfel (Windows) → `changelog_mitglieder.json`
- Cod: `lib/services/update_service.dart` linia 10

**Download URLs în version_mitglieder_android.json:**
- `download_url`: `https://icd360sev.icd360s.de/downloads/mitglieder/android/icd360sev.apk`
- `fallback_url`: `https://icd360sev.icd360s.de/downloads/mitglieder/android/icd360sev_stable.apk`

**Current Server Version (v1.1.10):**
```json
{
    "version": "1.1.10",
    "build_number": 106,
    "download_url": "https://icd360sev.icd360s.de/downloads/mitglieder/android/icd360sev.apk",
    "fallback_url": "https://icd360sev.icd360s.de/downloads/mitglieder/android/icd360sev_stable.apk",
    "fallback_version": "1.1.9",
    "changelog": "Version 1.1.10\n\n📄 INTERNER DATEI-VIEWER!\n\n✅ PDF-Dateien direkt in der App öffnen\n✅ Bilder intern anzeigen mit Zoom\n✅ Alle Pakete aktualisiert (Flutter 3.41.6)\n✅ system_tray → tray_manager, local_notifier entfernt",
    "min_version": null,
    "force_update": false,
    "release_date": "2026-04-04",
    "file_size": "41 MB"
}
```

## Comenzi Build & Deploy (Android)

### ⚠️ CHECKLIST RELEASE NOU (NU SĂRI PAȘI!)

**⚠️⚠️⚠️ REGULA DE AUR: ORICE MODIFICARE = VERSIUNE NOUĂ! ⚠️⚠️⚠️**

**FIECARE modificare de cod NECESITĂ versiune nouă:**
- ✅ Bug fix mic → Versiune nouă
- ✅ Text change → Versiune nouă
- ✅ UI tweak → Versiune nouă
- ✅ Color change → Versiune nouă
- ✅ Spacing adjustment → Versiune nouă

**NU există "modificare prea mică" - TOTUL necesită release nou!**
**Altfel utilizatorii nu pot descărca update-ul prin F-Droid!**

**⚠️ PAS VERIFICARE OBLIGATORIU (ÎNAINTE DE ORICE MODIFICARE!):**
```bash
# CRITICAL: Verifică ÎNTOTDEAUNA versiunea curentă ÎNAINTE de a face modificări!
# Cronologie: De la CEL MAI NOU la CEL MAI VECHI (1.0.65 → 1.0.64 → 1.0.63)

# 1. Verifică versiunea curentă pe server:
ssh -i "vps_icd360sev_icd360s.de" -p 36000 root@icd360sev.icd360s.de \
  "cat /var/www/icd360sev.icd360s.de/api/data/version_mitglieder.json"

# 2. Verifică changelog-ul complet (cronologic de la nou la vechi):
ssh -i "vps_icd360sev_icd360s.de" -p 36000 root@icd360sev.icd360s.de \
  "cat /var/www/icd360sev.icd360s.de/api/data/changelog_mitglieder.json"

# 3. Identifică:
#    - Versiune curentă (ex: 1.0.60)
#    - Build number curent (ex: 61)
#    - Noua versiune va fi: currentVersion + 1 minor (ex: 1.0.61)
#    - Noul build number va fi: currentBuildNumber + 1 (ex: 62)
#    - Fallback version va fi: versiunea curentă (ex: 1.0.60)

# ⚠️ NU CONTINUA până nu ai verificat și notat valorile de mai sus!
```

**Pas 0: Actualizează fișierele JSON pe server (IMPORTANT!):**

**⚠️⚠️⚠️ EXISTĂ 2 SETURI DE FIȘIERE - ACTUALIZEAZĂ-LE PE AMÂNDOUĂ! ⚠️⚠️⚠️**

| Fișier | Platformă | Path pe server |
|--------|-----------|----------------|
| `version_mitglieder_android.json` | Android | `/api/data/version_mitglieder_android.json` |
| `version_mitglieder.json` | Windows/Legacy | `/api/data/version_mitglieder.json` |
| `changelog_mitglieder_android.json` | Android | `/api/data/changelog_mitglieder_android.json` |
| `changelog_mitglieder.json` | Windows/Legacy | `/api/data/changelog_mitglieder.json` |

**AMBELE version files trebuie actualizate cu aceeași versiune!**
**AMBELE changelog files trebuie actualizate identic!**

```bash
# Editează version_mitglieder_android.json pe server:
ssh -i "vps_icd360sev_icd360s.de" -p 36000 root@icd360sev.icd360s.de
nano /var/www/icd360sev.icd360s.de/api/data/version_mitglieder_android.json
# Actualizează (cu valorile notate la Pas Verificare):
# - version: "X.X.X" (noua versiune)
# - build_number: Y (noul build number)
# - changelog: descrierea modificărilor (scurt, pentru update dialog)
# - fallback_version: "Z.Z.Z" (versiunea anterioară - pentru rollback)
# - release_date: "YYYY-MM-DD" (data curentă)
# - download_url: "https://icd360sev.icd360s.de/downloads/mitglieder/android/icd360sev.apk"
# - fallback_url: "https://icd360sev.icd360s.de/downloads/mitglieder/android/icd360sev_stable.apk"

# ⚠️ COPIAZĂ version la legacy/Windows (OBLIGATORIU!):
cp /var/www/icd360sev.icd360s.de/api/data/version_mitglieder_android.json \
   /var/www/icd360sev.icd360s.de/api/data/version_mitglieder.json
# Apoi editează version_mitglieder.json și schimbă DOAR download_url/fallback_url la Windows paths:
# - download_url: "https://icd360sev.icd360s.de/downloads/mitglieder/windows/icd360sev_setup.exe"
# - fallback_url: "https://icd360sev.icd360s.de/downloads/mitglieder/windows/icd360sev_setup_stable.exe"

# Editează changelog_mitglieder_android.json pe server:
nano /var/www/icd360sev.icd360s.de/api/data/changelog_mitglieder_android.json
# ⚠️ IMPORTANT: Adaugă noua versiune LA ÎNCEPUTUL array-ului "versions" (cronologic: nou → vechi)
# Structură nouă versiune:
# {
#   "version": "X.X.X",
#   "build_number": Y,
#   "release_date": "YYYY-MM-DD",
#   "title": "Titlu descriptiv",
#   "changes": [
#     {
#       "category": "Security" | "Features" | "Improvements" | "Bug Fixes",
#       "items": ["Descriere 1", "Descriere 2"]
#     }
#   ]
# }
# Actualizează "last_updated" cu timestamp curent (format: YYYY-MM-DDTHH:MM:SSZ)

# ⚠️ COPIAZĂ changelog la legacy/Windows (OBLIGATORIU!):
cp /var/www/icd360sev.icd360s.de/api/data/changelog_mitglieder_android.json \
   /var/www/icd360sev.icd360s.de/api/data/changelog_mitglieder.json
```

**Pas 1: Actualizează versiunea în TOATE fișierele locale:**
```
□ pubspec.yaml                            → version: X.X.X+Y
□ lib/services/update_service.dart        → currentVersion = 'X.X.X', currentBuildNumber = Y
□ lib/services/device_key_service.dart    → app_version: 'X.X.X'
□ lib/widgets/legal_footer.dart           → appVersion = 'X.X.X' + changelog entry (isLatest: true)
□ lib/screens/welcome.dart                → 'vX.X.X' (text display)
□ lib/screens/login.dart                  → 'vX.X.X' (text display)
□ lib/screens/register.dart               → 'vX.X.X' (text display)
□ android/app/build.gradle.kts            → versionCode = Y, versionName = "X.X.X"
```

**⚠️ IMPORTANT:** Caută în tot codul cu `grep -r "1\.0\.[0-9]+" lib/ android/` pentru a găsi toate locurile cu versiune hardcodată!

**IMPORTANT:** Caută în tot codul cu `grep -r "1\.0\.[0-9]+" lib/` pentru a găsi toate locurile cu versiune hardcodată!

**Pas 2: Build APK (cu obfuscation + split-per-abi):**
```bash
cd ~/Documents/icd360sev_mitglieder_android
flutter clean
flutter pub get
flutter build apk --release --flavor fdroid \
  --obfuscate --split-debug-info=build/symbols --split-per-abi

# IMPORTANT: Salvează symbols pentru crash de-obfuscation!
mkdir -p ~/symbols/vX.X.X
cp -r build/symbols/* ~/symbols/vX.X.X/
```

**Pas 3: Upload APK pe server:**
```bash
# Creează backup stabil (versiunea curentă devine fallback)
ssh -i "vps_icd360sev_icd360s.de" -p 36000 root@icd360sev.icd360s.de \
  "cp /var/www/icd360sev.icd360s.de/downloads/mitglieder/android/icd360sev.apk \
      /var/www/icd360sev.icd360s.de/downloads/mitglieder/android/icd360sev_stable.apk"

# Încarcă APK (arm64-v8a - ~50MB)
scp -i "vps_icd360sev_icd360s.de" -P 36000 \
  "build/app/outputs/flutter-apk/app-fdroid-arm64-v8a-release.apk" \
  root@icd360sev.icd360s.de:/var/www/icd360sev.icd360s.de/downloads/mitglieder/android/icd360sev.apk
```

**Pas 4: Verifică pe server:**
```bash
ssh -i "vps_icd360sev_icd360s.de" -p 36000 root@icd360sev.icd360s.de \
  "cat /var/www/icd360sev.icd360s.de/api/data/version_mitglieder.json"
```

### Fișiere de actualizat la release nou (REMINDER)

**⚠️ SERVER - 4 fișiere JSON (NU UITA LEGACY/WINDOWS!):**
| Fișier | Locație | Ce trebuie actualizat |
|--------|---------|----------------------|
| `version_mitglieder_android.json` | **SERVER** `/api/data/` | `version`, `build_number`, `changelog`, `fallback_version`, `release_date`, `file_size` |
| `version_mitglieder.json` | **SERVER** `/api/data/` | **⚠️ SYNC CU ANDROID!** Aceeași versiune, doar download_url diferă (windows path) |
| `changelog_mitglieder_android.json` | **SERVER** `/api/data/` | Adaugă nouă versiune la `versions[]` (LA ÎNCEPUT!), actualizează `last_updated` |
| `changelog_mitglieder.json` | **SERVER** `/api/data/` | **⚠️ SYNC CU ANDROID!** `cp changelog_mitglieder_android.json changelog_mitglieder.json` |

**LOCAL - 8 fișiere:**
| Fișier | Locație | Ce trebuie actualizat |
|--------|---------|----------------------|
| `pubspec.yaml` | Local | `version: X.X.X+Y` |
| `lib/services/update_service.dart` | Local | `currentVersion`, `currentBuildNumber` |
| `lib/services/device_key_service.dart` | Local | `app_version: 'X.X.X'` |
| `lib/widgets/legal_footer.dart` | Local | `appVersion` + **changelog entry cu isLatest: true** (NU UITA TOATE MODIFICĂRILE!) |
| `lib/screens/welcome.dart` | Local | `'vX.X.X'` (text display) |
| `lib/screens/login.dart` | Local | `'vX.X.X'` (text display) |
| `lib/screens/register.dart` | Local | `'vX.X.X'` (text display) |
| `lib/screens/mitglied_dashboard.dart` | Local | `_log.startUpload(...)` version string |
| `android/app/build.gradle.kts` | Local | `versionCode`, `versionName` |

**SERVER - F-Droid:**
| Fișier | Locație | Ce trebuie actualizat |
|--------|---------|----------------------|
| `fdroid/metadata/de.icd360s.mitglieder.yml` | **SERVER** `/fdroid/metadata/` | `CurrentVersionCode: Y` |

### Comenzi Flutter (macOS)
```bash
# Navigare la proiect
cd /Users/ionut-claudiuduinea/Documents/icd360sev_mitglieder_android

# Flutter SDK location
FLUTTER=/Users/ionut-claudiuduinea/development/flutter/bin/flutter

# Flutter analyze (verificare erori)
$FLUTTER analyze

# Flutter pub get (instalare dependențe)
$FLUTTER pub get

# Flutter pub upgrade (actualizare pachete)
$FLUTTER pub upgrade --major-versions

# Flutter clean (curăță build cache)
$FLUTTER clean

# ===== CROSS-PLATFORM BUILD COMMANDS =====

# Android APK (release with obfuscation + split-per-abi)
$FLUTTER build apk --release --flavor fdroid --obfuscate --split-debug-info=build/symbols --split-per-abi

# macOS App (debug/release)
PATH="/opt/homebrew/lib/ruby/gems/4.0.0/bin:$PATH" $FLUTTER build macos --debug
PATH="/opt/homebrew/lib/ruby/gems/4.0.0/bin:$PATH" $FLUTTER build macos --release

# iOS App (requires Xcode + Apple Developer account)
PATH="/opt/homebrew/lib/ruby/gems/4.0.0/bin:$PATH" $FLUTTER build ios --release

# Linux App (requires GTK development libraries)
$FLUTTER build linux --release

# Windows App (requires Windows SDK - run on Windows)
$FLUTTER build windows --release

# ===== POD INSTALL (iOS/macOS) =====
POD=/opt/homebrew/lib/ruby/gems/4.0.0/bin/pod
cd ios && $POD install && cd ..
cd macos && $POD install && cd ..

# SSH connection (key in project directory: vps_icd360sev_icd360s.de)
ssh -i "vps_icd360sev_icd360s.de" -p 36000 root@icd360sev.icd360s.de
```

### ⚠️ Backup Stable Version (ÎNAINTE de upload!)
```bash
# IMPORTANT: Rulează înainte de a uploada o nouă versiune!
# Salvează versiunea curentă ca fallback în caz de probleme
cd ~/Documents/icd360sev_mitglieder_android
ssh -i "vps_icd360sev_icd360s.de" -p 36000 root@icd360sev.icd360s.de \
  "cp /var/www/icd360sev.icd360s.de/downloads/mitglieder/android/icd360sev.apk \
      /var/www/icd360sev.icd360s.de/downloads/mitglieder/android/icd360sev_stable.apk"
```

### Rollback rapid (dacă noua versiune are probleme)
```bash
# Restaurează versiunea stabilă
cd ~/Documents/icd360sev_mitglieder_android
ssh -i "vps_icd360sev_icd360s.de" -p 36000 root@icd360sev.icd360s.de \
  "cp /var/www/icd360sev.icd360s.de/downloads/mitglieder/android/icd360sev_stable.apk \
      /var/www/icd360sev.icd360s.de/downloads/mitglieder/android/icd360sev.apk"
```

### Paths
```
Local - Project (macOS):
├── /Users/ionut-claudiuduinea/Documents/icd360sev_mitglieder_android/
├── /Users/ionut-claudiuduinea/Documents/icd360sev_mitglieder_android/vps_icd360sev_icd360s.de  (SSH Key)
├── /Users/ionut-claudiuduinea/Documents/icd360sev_mitglieder_android/build/  (Build outputs)
│   ├── app/outputs/flutter-apk/  (Android APK output)
│   │   ├── app-release.apk  (Release APK)
│   │   └── app-debug.apk    (Debug APK)
│   └── macos/Build/Products/Debug/  (macOS app output)
│       └── icd360sev_mitglied.app  (macOS app bundle)
├── /Users/ionut-claudiuduinea/Documents/icd360sev_mitglieder_android/android/  (Android native config)
├── /Users/ionut-claudiuduinea/Documents/icd360sev_mitglieder_android/ios/      (iOS native config)
├── /Users/ionut-claudiuduinea/Documents/icd360sev_mitglieder_android/macos/    (macOS native config)
├── /Users/ionut-claudiuduinea/Documents/icd360sev_mitglieder_android/linux/    (Linux native config)
├── /Users/ionut-claudiuduinea/Documents/icd360sev_mitglieder_android/windows/  (Windows native config)
└── /Users/ionut-claudiuduinea/Documents/icd360sev_mitglieder_android/lib/  (Flutter source code)

Local - Development Tools (macOS):
├── /Users/ionut-claudiuduinea/development/flutter/  (Flutter SDK)
│   └── bin/flutter  (Flutter executable)
├── /opt/homebrew/opt/ruby/  (Homebrew Ruby 4.0.1)
│   └── bin/gem  (Gem package manager)
├── /opt/homebrew/lib/ruby/gems/4.0.0/bin/  (Ruby gems binaries)
│   └── pod  (CocoaPods - pentru iOS/macOS)
├── /Applications/Android Studio.app/  (Android Studio IDE)
│   └── Contents/jbr/  (JetBrains Runtime JDK)
└── ~/Library/Android/sdk/  (Android SDK)
    ├── emulator/emulator  (Android Emulator)
    ├── platform-tools/adb  (Android Debug Bridge)
    ├── cmdline-tools/  (SDK command-line tools)
    └── system-images/  (System images pentru emulator)

Local - Emulator AVD (macOS):
└── ~/.android/avd/  (AVD configurations)
    └── [device_name].avd/
        ├── config.ini  (Emulator settings)
        └── hardware-qemu.ini  (QEMU hardware config)

⚠️ PATH Setup (adaugă în ~/.zshrc):
export PATH="/Users/ionut-claudiuduinea/development/flutter/bin:$PATH"
export PATH="/opt/homebrew/lib/ruby/gems/4.0.0/bin:$PATH"

Server (AlmaLinux 10.1, IP: 46.224.149.142, SSH port 36000):
├── /var/www/icd360sev.icd360s.de/api/  (API endpoints - 278 PHP files total)
│   ├── admin/ (135), auth/ (28), chat/ (13), tickets/ (29), member/ (6)
│   ├── platform/ (15), stadtverwaltung/ (6), tracking/ (3), notar/ (5)
│   ├── cron/ (6), logs/ (6), fcm/ (2), device/ (2), helpers/ (5), vereinverwaltung/ (3)
│   └── data/  (Protected JSON storage)
│       ├── version_mitglieder_android.json
│       ├── changelog_mitglieder_android.json
│       ├── version_schatzmeister.json / changelog_schatzmeister.json
│       └── ws_queue/
├── /var/www/icd360sev.icd360s.de/downloads/
│   ├── mitglieder/android/  (⚠️ MITGLIEDER ANDROID APP - upload aici!)
│   │   ├── icd360sev.apk        (Latest release ~90MB)
│   │   └── icd360sev_stable.apk (Backup pentru rollback)
│   ├── mitglieder/windows/  (Windows installer)
│   └── vorsitzer/windows/   (Vorsitzer Windows app)
├── /var/www/icd360sev.icd360s.de/fdroid/  (F-Droid repository)
└── /var/www/icd360sev.icd360s.de/websocket/  (WebSocket server PHP/Ratchet)
```

### version_mitglieder_android.json Format (Server)
```json
{
    "version": "1.1.4",
    "build_number": 100,
    "download_url": "https://icd360sev.icd360s.de/downloads/mitglieder/android/icd360sev.apk",
    "fallback_url": "https://icd360sev.icd360s.de/downloads/mitglieder/android/icd360sev_stable.apk",
    "fallback_version": "1.1.9",
    "changelog": "Version 1.1.10\n\n📄 INTERNER DATEI-VIEWER!\n\n✅ PDF-Dateien direkt in der App öffnen\n✅ Bilder intern anzeigen mit Zoom\n✅ Alle Pakete aktualisiert",
    "min_version": null,
    "force_update": false,
    "release_date": "2026-04-04",
    "file_size": "41 MB"
}
```

### changelog_mitglieder_android.json Format (Server)
```json
{
    "versions": [
        {
            "version": "1.1.10",
            "build_number": 106,
            "release_date": "2026-04-04",
            "title": "Interner Datei-Viewer + Package-Upgrades",
            "changes": [
                {
                    "category": "Features",
                    "items": [
                        "PDF-Dateien direkt in der App öffnen (interner Viewer)",
                        "DiagnosticService erhält Mitgliedernummer nach Login"
                    ]
                }
            ]
        },
        {
            "version": "1.1.8",
            "build_number": 104,
            "release_date": "2026-04-03",
            "title": "Batterie-Monitoring pro Mitglied",
            "changes": [...]
        }
    ],
    "last_updated": "2026-04-03T17:00:00Z"
}
```

**⚠️ CRONOLOGIE OBLIGATORIE:**
- Array-ul "versions" TREBUIE să fie cronologic de la CEL MAI NOU la CEL MAI VECHI
- Exemplu corect: [v1.0.60, v1.0.59, v1.0.58, v1.0.57]
- Exemplu GREȘIT: [v1.0.57, v1.0.58, v1.0.59, v1.0.60]
- Noua versiune se adaugă ÎNTOTDEAUNA la ÎNCEPUTUL array-ului

**Categorii disponibile pentru changelog:**
- **Security** (roșu, 🔒) - Probleme de securitate, vulnerabilități patches
- **Features** (verde, ✨) - Funcționalități noi
- **Improvements** (albastru, 📈) - Îmbunătățiri la funcționalități existente
- **Bug Fixes** (portocaliu, 🐛) - Rezolvări de bug-uri

---

---

## API Features Overview

### Implemented Features
| Feature | Status | Description |
|---------|--------|-------------|
| **Authentication** | ✅ | Login (3 apps), register, password recovery, token validation |
| **Device Management** | ✅ | Max 3 devices, register, validate, session control |
| **User Management** | ✅ | Admin user CRUD, status updates, device/session revoke |
| **Termine** | ✅ | Weekly calendar, create/edit/delete, multi-participants |
| **Urlaub** | ✅ | Vacation periods management |
| **Chat System** | ✅ | Real-time messaging, file attachments, scheduled messages, mute |
| **Voice Calls** | ✅ | WebRTC calls with auto-reject timeout |
| **Tickets** | ✅ | Full CRUD, attachments, comments, time tracking, categories |
| **Vereinverwaltung** | ✅ | Association info management |
| **Notar System** | ✅ | Visits, documents, invoices, payments, tasks |
| **Member Verifizierung** | ✅ | 5-step verification, document upload, Leistungsbescheid |
| **Verwarnungen** | ✅ | Member warnings/sanctions system |
| **Befreiung/Ermäßigung** | ✅ | Fee exemption/reduction management |
| **Finanzverwaltung** | ✅ | Beitragszahlungen, Spenden, Transaktionen |
| **Platform** | ✅ | Aufgaben, Notizen, Postcard, Credentials management |
| **Stadtverwaltung** | ✅ | Behörden, Drogerien, Krankenhäuser, etc. |
| **DHL Tracking** | ✅ | Package tracking, Filialfinder |
| **Diagnostics** | ✅ | App state logging every 15 seconds |
| **Logging** | ✅ | Per-app logs (Mitglieder, Vorsitzer, Schatzmeister) |
| **Auto-Update** | ✅ | F-Droid + APK fallback |
| **Schatzmeister App** | ✅ | Separate app for treasurer role |

## Recent Updates (v1.0.56+)

### v1.1.10 (2026-04-04)
- ✅ **Interner Datei-Viewer** - PDF und Bilder direkt in der App öffnen
  - New widget: `lib/widgets/file_viewer.dart` - PDF viewer (pdfrx) + Image viewer (InteractiveViewer)
  - PDF: Zoom, Scroll, Seitennavigation intern (kein externer Viewer nötig)
  - Bilder (JPG, JPEG, PNG, GIF, WebP): Zoom und Pan intern
  - Andere Dateitypen: Fallback auf externes Programm (OpenFilex)
  - "Extern öffnen" Button im Viewer als Fallback
  - Angewendet auf: Live Chat Attachments, Dokumente Tab
- ✅ **Package-Upgrades** - 30 → 6 veraltete Pakete
  - Flutter 3.41.4 → 3.41.6 (Dart 3.11.1 → 3.11.4)
  - Kotlin 2.1.0 → 2.2.0
  - battery_plus ^6.0.0 → ^7.0.0
  - connectivity_plus ^6.1.4 → ^7.0.0
  - pdfrx ^2.2.0 (NEW - PDF viewer)
  - 16 minor/patch transitive dependency updates
- ✅ **system_tray → tray_manager** - Abandoniertes Paket ersetzt
  - system_tray 2.0.3 (letzte Aktualisierung April 2023, 3 Jahre alt) entfernt
  - tray_manager 0.5.2 (aktiv gepflegt, gleicher Publisher wie window_manager)
  - Desktop System Tray funktioniert identisch
- ✅ **local_notifier entfernt** - Ein Paket für alle Plattformen
  - local_notifier 0.1.6 (abandoniert Nov 2023) entfernt
  - flutter_local_notifications wird jetzt für ALLE Plattformen verwendet (Android, iOS, macOS, Windows, Linux)
  - NotificationService vereinfacht: keine Platform-Branches mehr

### v1.1.9 (2026-04-03)
- ✅ **Fix: DiagnosticService mitgliedernummer** - Battery data salvat corect per membru (era: unknown)
  - `DiagnosticService().setUser()` apelat în dashboard initState după login

### v1.1.8 (2026-04-03)
- ✅ **Batterie-Monitoring pro Mitglied**
  - New dependency: `battery_plus: ^6.0.0` - Battery level + state monitoring
  - Diagnostic service trimite `battery_level` (0-100) + `battery_state` la server
  - Server: tabel `battery_logs` + `diagnostic_logs` în MySQL (per mitgliedernummer)
  - JSON logs per membru: `logs/diagnostic/{mitgliedernummer}/YYYY-MM-DD.json`
  - Rotație automată: MySQL + JSON șterse după 30 zile

### v1.1.7 (2026-04-03)
- ✅ **Batterie-Optimierung** - Von ~15%/Tag auf ~2-3%/Tag reduziert
  - WidgetsBindingObserver: UI-Timer pausieren automatisch im Hintergrund
  - WebSocket-Ping: 30s → 45s
  - Support-Status: 5s → 30s
  - Kalender-Poll: 15s → 60s
  - Heartbeat: 15s → 60s, Diagnostik: 15s → 120s
  - Ticket-Polling: 10s → 60s (ntfy liefert sofortige Benachrichtigungen)
  - Network-Ping: nur noch alle 5 Minuten
  - Health-Check-Timer entfernt (redundant)
  - FOREGROUND_SERVICE_DATA_SYNC Berechtigung entfernt

### v1.1.6 (2026-04-03)
- ✅ **Oster-Thema verbessert** - paintBehind Parameter
  - Chat-Nachrichten: Dekorationen hinter den Nachrichten (bessere Lesbarkeit)

### v1.1.5 (2026-04-03)
- ✅ **Sicherheit + Ostern + ntfy Push** - Großes Security & Feature Update
  - Certificate Pinning, TURN vom Server, Token nicht in WS URL
  - Oster-/Frühlings-Thema, ntfy Push-Benachrichtigungen
  - Benachrichtigungen repariert, Speicherlecks, HTTP-Timeouts, Obfuscation

### v1.1.4 Security & Stability Update (2026-04-03)
- ✅ **Certificate Pinning** - ISRG Root X1 (Let's Encrypt) pinning pe toate conexiunile
  - New service: `lib/services/http_client_factory.dart` - Centralized pinned HttpClient factory
  - SecurityContext cu DOAR ISRG Root X1 trusted (valid până 2035)
  - Aplicat pe 6 HTTP services + 2 WebSocket connections
  - Debug mode: pinning dezactivat pentru dezvoltare
- ✅ **TURN Credentials pe server** - Eliminate din cod sursă, fetch la runtime
  - New endpoint: `/api/auth/turn_credentials.php` (JWT protected)
  - Cache 24h, fallback la STUN-only dacă fetch eșuează
- ✅ **Token eliminat din WebSocket URL** - Trimis în auth message
  - Server ChatServer.php actualizat cu JWT validation
  - Token nu mai apare în nginx access logs
- ✅ **Token logging eliminat** - Fragmente JWT nu mai apar în debug logs
- ✅ **Foreground service: dataSync → remoteMessaging** - Fix Android 15 timeout 6h
- ✅ **Notification fixes** - Channel IDs unificate, ID-uri unice per mesaj/ticket, fișier audio lipsă eliminat
- ✅ **Cross-platform fixes** - WebView→url_launcher pe desktop, image_picker guard, macOS entitlements, iOS background modes, noise_meter guard
- ✅ **Crash prevention** - `as int`→`int.tryParse`, `DateTime.parse`→`tryParse`, force-unwrap→null-safe
- ✅ **Memory leak fixes** - Timers stored+cancelled, StreamSubscriptions cancelled, call timer dedup
- ✅ **HTTP timeouts** - 15s connection+idle timeout pe toate serviciile
- ✅ **Easter/Spring Theme** - Seasonal decorations active automatically in April
  - New widget: `lib/widgets/eastern.dart` - SeasonalBackground + EasterAppBarPainter (748 lines)
  - Applied on: welcome screen, dashboard body, AppBar flexibleSpace, chat messages ListView
  - Decorations: Easter eggs (28), bunnies (5), chicks (3), butterflies (7), flowers (18), grass, clouds
  - Zero maintenance: activates April 1, deactivates May 1, every year
- ✅ **Ntfy Push Notifications** - NDJSON stream de la ntfy server (topic: icd360s_{mitgliedernummer})
  - New service: `lib/services/ntfy_service.dart` - Auto-reconnect 5s, parse events
  - Server: `NtfyService.php` (deja existent, prefix `icd360s_`)
  - Integrat în dashboard: start() la initState, stop() la dispose
- ✅ **Build: obfuscation + split-per-abi** - Dart code ilizibil, APK ~50MB (de la ~98MB)
- ✅ **WorkManager background task** - FlutterLocalNotificationsPlugin initialized before show()
- ✅ **Heartbeat guard** - Previne concurrent requests
- ✅ **Logger data loss fix** - Re-add logs on exception (nu doar pe HTTP error)

### v1.1.4 (2026-03-25)
- ✅ **Netzwerk-Diagnose + Echtzeit Chat-Übersetzung**
  - New service: `lib/services/network_info_service.dart` - Network diagnostics (WiFi/4G/5G/Offline)
  - Network status sent to server every 15s with heartbeat (connection type + latency)
  - New dependency: `connectivity_plus: ^6.1.4` for network type detection
  - Chat messages translated in real-time (no restart needed)
  - Duplicate messages in chat fixed

### v1.1.3 (2026-03-25)
- ✅ **Intermediate release** (fallback version for v1.1.4)

### v1.1.2 (2026-03-25)
- ✅ **Critical Bug Fix** - Device locale detection for all 28 languages
  - Fixed: `_supportedLanguages` in api_service.dart had only 5 languages (de, en, ro, ru, uk)
  - All 28 languages now recognized: ar, tr, fr, es, it, pl, etc. were falling back to German
  - Xiaomi/MIUI locale detection fixed (was always sending 'de' instead of actual device language)
  - Login now saves `preferred_language` from device locale to database
  - Chat translation (NLLB-200) now works correctly for Arabic, Turkish, and all languages
  - Server-side: TranslationHelper.php + login_mitglied.php updated with ar support

### v1.1.1 (2026-03-25)
- ✅ **Arabic (28th language)** - Full Arabic translation + dependency updates
  - Arabic (AR) fully translated: 558/558 keys (100%)
  - NLLB-200 translation API: Arabic (arb_Arab) added as supported language
  - Server-side: TranslationHelper.php Arabic character detection added
  - flutter_webrtc 1.3.1→1.4.1, noise_meter 5.0.2→5.1.0
  - Login PHP bug fixed: device_locale undefined variable warning removed

### v1.1.0 (2026-03-25)
- ✅ **Full i18n (28 languages)** - App 99% translated in 28 languages
  - 558 translation keys across 28 languages
  - 63 new l10n keys for previously hardcoded German strings
  - All UI screens fully localized: login, register, dashboard, chat, tickets, termine, profile, notifications
  - Background notifications translated via SharedPreferences bridge
  - DateFormat uses device locale instead of hardcoded de_DE
  - Dependencies: flutter_webrtc 1.3.1→1.4.1, noise_meter 5.0.2→5.1.0

### v1.0.94 (2026-03-24)
- ✅ **Partial i18n** - Termine localization
  - 558 translation keys across 28 languages (was 484 with hardcoded German)
  - 63 new l10n keys added for previously hardcoded strings
  - Fixed: login_tab, register_tab, mitgliedschaft_tab, mitglied_profile_dialog
  - Fixed: verifizierung_tab, personal_data_dialog, dokumente_tab, diagnostic_consent_dialog
  - Fixed: live_chat_dialog, conversation_list_item, profile_dialog, debug_console
  - Fixed: background_service (SharedPreferences for translated notifications)
  - Fixed: member_calendar_view (DateFormat locale-aware)
  - Turkish (TR) confirmed as 27th language with full coverage
  - Dependencies: flutter_webrtc 1.3.1→1.4.1, noise_meter 5.0.2→5.1.0

### v1.0.91 (2026-03-13)
- ✅ **Bug Fixes** - Chat & Ticket crash fixes
  - Chat attachment download: null safety fix (NoSuchMethodError)
  - Ticket comments: null-to-int cast fix
  - Robustere JSON parsing across all services

### v1.0.90 (2026-03-13)
- ✅ **Dependencies Upgrade** - Flutter 3.41.4
  - Flutter SDK: 3.38.9 → 3.41.4
  - flutter_local_notifications: 17.2.4 → 21.0.0 (migrated to named params API)
  - file_picker: 8.3.7 → 10.3.10
  - permission_handler: 11.4.0 → 12.0.1
  - window_manager: 0.4.3 → 0.5.1
  - noise_meter: 5.0.2 → 5.1.0

### v1.0.86 (2026-02-10)
- ✅ **Termine Notifications** - Complete notification system for termine
  - Calendar badge icon in header shows pending termine count
  - Notification ID 8: New termin detected (when count increases)
  - Notification ID 9: Tomorrow reminder (one day before termin)
  - Notification ID 10: Morning reminder (at 07:00 on day of termin)
  - 15-second polling for termine count updates
  - Smart date tracking to prevent duplicate daily reminders

### v1.0.85 (2026-02-09)
- ✅ **Member Termine View Fix** - Fixed termine not displaying for members
  - Fixed response parsing: `result['termine']` instead of `result['data']['termine']`
  - Fixed JWT token: TerminService now reads token from ApiService
  - Member calendar now correctly shows all assigned termine
  - Fixed filters: pending/accepted/completed states working
  - Polling every 15 seconds with refresh on filter change

### v1.0.84 (2026-02-07)
- ✅ **Member Profile Enhanced** - 3 tabs with document management
  - Tab 1: Konto (Account settings)
  - Tab 2: Meine Geräte (Device management)
  - Tab 3: Verifizierung (Document verification with upload/view/delete)
  - Document types: Personalausweis, Führerschein, Meldebescheinigung
  - Document status tracking: pending/verified/rejected

### v1.0.83 (2026-02-03)
- ✅ **Log Upload System** - Remote debugging cu upload automat
  - Logs se uploadează la server la fiecare 30 secunde
  - Endpoint: `/api/logs/mitglieder_android.php`
  - Păstrează ultimele 500 linii de log
  - Accept Button Fix păstrat din v1.0.81
  - Calendar Privacy Protection (member ID masking)

### v1.0.82 (2026-02-02)
- ✅ **Ticket System Enhanced** - Full attachment support
  - Upload attachments (images, PDF, documents)
  - Download attachments cu progress indicator
  - Ticket comments system
  - Ticket history tracking
  - Ticket categories
  - Mark tickets as viewed
  - WorkManager polling pentru ticket notifications

### v1.0.81 (2026-02-01)
- ✅ **Member Calendar View** - Widget dedicat pentru termine
  - `member_calendar_view.dart` - Calendar view pentru membri
  - `member_ticket_details_dialog.dart` - Ticket viewer pentru membri
  - Privacy protection pentru member IDs în calendar

### v1.0.80 (2026-01-31)
- ✅ **Native Call Screen** - Ecran apel nativ Android
  - `native_call_screen.dart` - Full-screen call UI
  - Audio monitoring real cu noise_meter
  - Mute/unmute, call timer, end call

### v1.0.79 (2026-01-30)
- ✅ **Heartbeat Service** - Separate keepalive mechanism
  - `heartbeat_service.dart` - WebSocket heartbeat
  - Endpoint: `/api/auth/heartbeat_app.php`
  - Auto-reconnect cu exponential backoff

### v1.0.78 (2026-01-29)
- ✅ **Multi-language Support** - 25+ limbi suportate
  - Localization via Flutter l10n
  - 25+ fișiere l10n auto-generate (DE, EN, FR, RO, ES, etc.)
  - `l10n.yaml` configuration

### v1.0.77 (2026-01-28)
- ✅ **FCM Push Notifications** - Firebase Cloud Messaging
  - `/api/fcm/register.php` - Token registration
  - `/api/fcm/unregister.php` - Token cleanup
  - `FcmService.php` helper pentru push

### v1.0.67-v1.0.76 (2026-01-27)
- ✅ **Chat Improvements** - Multiple fixes and optimizations
  - Chat name format fix (initials + surname: "I.C. Duinea")
  - Message bubble spacing optimization pentru ecrane mici
  - Duplicate message fix (is_own detection corectată)
  - Attachment options bottom sheet (camera/gallery/documents)
  - Trial warning banner optimization
  - Footer auto-hide when keyboard open
### v1.0.68 (2026-01-27)- ✅ **Chat Message Bubble Spacing** - Less cramped on small screens  - Responsive margin: 50% pe ecrane < 360px (25px in loc de 50px)  - Responsive padding: 50% pe ecrane < 360px (5px in loc de 10px)  - Mai mult spațiu pentru text în chat bubbles  - Implementat în chat_message_bubble.dart
### v1.0.69 (2026-01-27)- ✅ **Duplicate Message Fix** - Korrekte is_own detection  - Vergleicht sender_name cu userName (statt senderId mit mitgliedernummer)  - Fix: Mesaje von Mitglied erscheinen nicht mehr als Vorsitzer Nachricht  - WebSocket messages haben jetzt korrektes is_own flag  - Keine doppelten Nachrichten mehr im Chat
### v1.0.70 (2026-01-27)- ✅ **Attachment Options Bottom Sheet** - Choose camera/gallery/documents  - Package: image_picker ^1.0.7 adăugat  - Bottom sheet cu 3 opțiuni: Kamera, Galerie, Dokumente  - Cameră: Foto direct vom camera  - Galerie: Multiple images (max 10)  - Dokumente: PDF, TXT, imagini (file_picker)
### v1.0.66 (2026-01-27)
- ✅ **Trial Warning Banner Optimization** - Kompakt auf kleinen Displays
  - Responsive fontSize und spacing în mitglied_banners.dart
  - Text ellipsis pentru texte lungi (maxLines: 2)
  - Banner ocupă 60% mai puțin spațiu pe ecrane < 360px
  - Icon size și padding redus automat

### v1.0.65 (2026-01-27)
- ✅ **Footer Auto-Hide on Keyboard** - Footer verschwindet wenn Tastatur geöffnet ist
  - Detection: `MediaQuery.viewInsets.bottom > 0`
  - Implementat în login.dart și register.dart
  - Mai mult spațiu pentru formulare când tastezi
  - Footer reapare automat când închizi tastatura

### v1.0.62 (2026-01-27)
- ✅ **Registration Device ID Limit** - Per MONTH instead of per day
  - Tabel `registration_limits` cu coloană `device_id`
  - Funcții `checkRegistrationLimit()` și `recordRegistration()` cu device_id
  - 1 cont per device per LUNĂ (nu per zi, mai logic)
  - Device ID mai sigur decât IP (nu se poate schimba cu VPN)
- ✅ **API Service** - Trimite device_id la registrare
  - `api_service.dart` folosește `LoggerService().deviceId`
  - `register.php` validează și salvează device_id
- ✅ **Platform Detection** - Separate JSON files
  - `version_mitglieder_android.json` pentru Android
  - `version_mitglieder_windows.json` pentru Windows (fallback la version_mitglieder.json)
  - `changelog_mitglieder_android.json` cu istoric Android-specific
- ✅ **Responsive Text** - Auto-scaling pentru ecrane mici
  - Funcție `_getResponsiveFontSize()` în welcome.dart, login.dart, register.dart
  - Ecrane < 360px → 85% din fontSize
  - Ecrane 360-400px → 95% din fontSize
  - Ecrane > 400px → 100% (normal)
- ✅ **Responsive Footer** - Auto-hide când tastatura e deschisă
  - Footer se ascunde automat când keyboard-ul e vizibil
  - Spacing redus: 50% pe ecrane < 360px, 75% pe 360-400px
  - Padding redus pentru ecrane mici

### v1.0.61 (2026-01-27)
- ✅ **Background Service** - Persistent WebSocket connection în background
  - New service: `lib/services/background_service.dart`
  - Package: `flutter_background_service` v5.0.10
  - Foreground service type: `dataSync` (Android 14+ SDK 34)
  - Auto-reconnect cu exponential backoff (2-30 secunde)
  - Heartbeat ping la fiecare 30 secunde
  - Notificări în background pentru chat și apeluri
  - Auto-start la boot cu `BootReceiver`
  - Permisiuni noi: `FOREGROUND_SERVICE_DATA_SYNC`, `RECEIVE_BOOT_COMPLETED`
- ✅ **F-Droid Repository** - Custom repository pentru distribuție
  - Repository URL: `https://icd360sev.icd360s.de/fdroid/repo`
  - Auto-update via F-Droid la fiecare 12-24 ore
  - Fingerprint SHA256 pentru verificare securitate
- ✅ **Update Check Optimization** - Reduced frequency
  - Verificare interval: 24 ore (în loc de 5 minute)
  - F-Droid = metodă principală, auto-update intern = fallback
  - Economie baterie și date mobile

### v1.0.60 (2026-01-23)
- ✅ **Device Key Protection** - Version & Changelog endpoints protected
  - Protected endpoints: `/api/version_mitglieder.php` și `/api/changelog_mitglieder.php`
  - Device Key authentication cu Legacy API Key fallback
  - User-Agent validation (blochează browser-ele)
  - Protected JSON storage în `/api/data/` (chmod 640, root:nginx)
- ✅ **Changelog System** - View complete version history
  - New widget: `ChangelogDialog` cu categorii colorate
  - API method: `ApiService.getChangelog()`
  - Version history cu Security, Features, Improvements, Bug Fixes
- ✅ **Enhanced UpdateService** - Uses protected endpoints
  - UpdateService schimbat de la URL direct la endpoint protejat
  - Headers cu Device Key + User-Agent pentru authentication

### v1.0.56 (2026-01-22)
- ✅ Fix: Duplicate call_offer handling
- ✅ Device management (max 3 devices)
- ✅ Admin member edit with device/session view
- ✅ Member self-service device management

### Android Build Fixes (2026-01-24)
- ✅ Ported from Windows desktop to Android mobile successfully
- ✅ Fixed AGP/Gradle compatibility (AGP 8.13.2 + Gradle 8.13)
- ✅ Fixed NDK version mismatch (NDK 28.2.13676358)
- ✅ Fixed Core Library Desugaring for Java 8+ APIs
- ✅ Fixed JVM target mismatch (Java 17 + Kotlin 17)
- ✅ Successful debug & release APK builds
- ✅ Updated CLAUDE.md with Android-specific structure

### macOS Development Migration (2026-02-05)
- ✅ Migrated development environment from Windows to macOS
- ✅ Updated all paths and commands for macOS compatibility
- ✅ Flutter SDK accessible via PATH
- ✅ Android Studio and SDK configured for macOS

### v1.0.59 (2026-01-23)
- ✅ **Support Online Status** - **REAL-TIME** indicator în chat header
  - Shows if any admin is currently online (**last_seen < 30 SECONDS** - not 5 minutes!)
  - Displays "Zuletzt aktiv vor X" when offline
  - **REAL-TIME polling: every 5 seconds** (not 30 seconds!)
  - New endpoint: `/api/chat/support_status.php`
  - Backend threshold: 30 seconds for online detection
- ✅ Fix KRITISCH: Widget lifecycle issue în live_chat_dialog
  - All stream listeners now check mounted state before setState
  - Voice call callbacks (_handleCallAnswer, _handleCallRejected, _handleCallEnded) mounted check
  - _startCall and _acceptCall error handling with mounted protection
  - _endCallCleanup protected from defunct widget state
  - Fixed _AssertionError in Flutter framework

### v1.0.58 (2026-01-23)
- ✅ Fix KRITISCH: Role-based authentication
  - Separate endpoints: `login_mitglied.php` (members only) and `login_vorsitzer.php` (admins only)
  - Auto-redirect after registration with pre-filled Mitgliedernummer
  - Enhanced error message handling (accepts both "message" and "error" fields)
  - Fixed widget mount issues in LoginScreen
  - TabController uses direct index assignment instead of animateTo

### v1.0.57 (2026-01-23)
- ✅ **Terminverwaltung System** - Weekly Calendar
  - Create/Edit/Delete termine
  - Multi-select participants
  - Category-based color coding
  - Time slot restrictions (11:00, 14:00-17:00)
  - Mittagspause display
- ✅ **Urlaub Management** - Vacation periods
  - Create vacation with date range
  - Display in red on calendar
  - Smart edit/delete (first day, last day, full period)
  - Blocks appointment creation
- 🔜 **Notar System** - Integration pending
  - Visits tracking
  - Documents management
  - Invoices & payments

---

## ⚠️ IMPORTANT: Workflow de Verificare pentru Release-uri

**ÎNAINTE de a face orice modificare la versiune, ÎNTOTDEAUNA:**

1. ✅ **Verifică versiunea curentă** pe server (`version_mitglieder.json`)
2. ✅ **Verifică changelog-ul** pe server (`changelog_mitglieder.json`)
3. ✅ **Identifică noua versiune** (current + 1 minor)
4. ✅ **Identifică noul build number** (current + 1)
5. ✅ **Notează fallback version** (versiunea curentă)
6. ✅ **Verifică cronologia** în changelog (de la nou la vechi)

**NU începe niciodată modificări fără aceste verificări!**

---

**Last updated:** 2026-04-04 (**v1.1.10** - Interner Datei-Viewer, Package-Upgrades, tray_manager, local_notifier entfernt)

---

# 📱 ANDROID VERSION (Development on macOS)

## Platformă Android

Aplicația ICD360S e.V - Mitgliederportal este dezvoltată pentru Android pe macOS, păstrând toate funcționalitățile core.

### ✅ **Pachete Flutter pentru Android**

| Categorie | Pachet | Scop |
|-----------|--------|------|
| **WebView** | `webview_flutter: ^4.4.0` | WebView multi-platformă |
| **Notificări** | `flutter_local_notifications: ^21.0.0` | Notificări Android cu channels (named params API) |
| **Audio** | `noise_meter: ^5.0.1` | Detecție audio real de la microfon |
| **Permisiuni** | `permission_handler: ^12.0.1` | Gestionare permisiuni Android |
| **Storage** | `flutter_secure_storage: ^10.0.0` | Encrypted storage (Android Keystore) |
| **Communication** | `flutter_webrtc: ^1.2.1` | WebRTC pentru voice calls |
| **Paths** | `path_provider: ^2.1.0` | Acces la directoare sistem |
| **Device Info** | `device_info_plus: ^12.3.0` | Device identification |
| **Installer** | `open_filex: ^4.5.0` | APK installer launch |
| **Media Picker** | `image_picker: ^1.0.7` | Camera & gallery access 🆕 |
| **File Picker** | `file_picker: ^10.3.10` | Document picker (PDF, TXT) |
| **Network** | `connectivity_plus: ^6.1.4` | Network type detection (WiFi/4G/5G) 🆕 |
| **Background Tasks** | `workmanager: ^0.9.0` | Background polling (tickets) |
| **Localization** | `flutter_localizations` (SDK) | Multi-language support (28 limbi) |

### 📋 **Servicii Adaptate**

| Fișier | Modificare | Detalii |
|--------|-----------|---------|
| `lib/services/background_service.dart` | ✨ NOU | Foreground service pentru WebSocket persistent în background |
| `lib/services/notification_service.dart` | 🔄 Rescris | Folosește `flutter_local_notifications` cu Android channels |
| `lib/services/update_service.dart` | 🔄 Modificat | Download APK în loc de EXE, verificare la 24 ore |
| `lib/screens/webview_screen.dart` | 🔄 Rescris | Folosește `webview_flutter` cu `WebViewController` |
| `lib/main.dart` | 🔄 Modificat | Portrait mode, Android system UI, background service |
| `lib/widgets/incoming_call_dialog.dart` | 🔄 Modificat | Audio monitoring REAL cu `noise_meter` |
| `lib/widgets/legal_footer.dart` | 🔄 Modificat | Update check interval: 24 ore (în loc de 5 minute) |
| `lib/services/tray_service.dart` | ❌ Șters | Nu există pe Android |
| `lib/services/startup_service.dart` | ❌ Șters | Nu e relevant pe Android |
| `lib/services/push_foreground_service.dart` | ❌ Șters | Înlocuit cu `background_service.dart` |

### 🔧 **Configurare Android**

**Package Name:** `de.icd360s.mitglieder`

**Versiune:**
- versionCode: 100
- versionName: "1.1.4"
- minSdk: 23 (Android 6.0+ - Flutter minimum)
- targetSdk: 36 (Android 15)

**Permisiuni (AndroidManifest.xml):**
```xml
<!-- Network -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

<!-- Voice/Video Calls -->
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
<uses-permission android:name="android.permission.WAKE_LOCK" />

<!-- Storage (Android 13+) -->
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
<uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />
<uses-permission android:name="android.permission.READ_MEDIA_AUDIO" />

<!-- Notifications (Android 13+) -->
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />

<!-- APK Installation -->
<uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />

<!-- Legacy Storage (Android < 13) -->
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" android:maxSdkVersion="32" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="32" />

<!-- Full Screen Intent (calls) -->
<uses-permission android:name="android.permission.USE_FULL_SCREEN_INTENT" />

<!-- Background Service (v1.0.61+) -->
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_DATA_SYNC" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_REMOTE_MESSAGING" />
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
<uses-permission android:name="android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS" />

<!-- Scheduling -->
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />
<uses-permission android:name="android.permission.USE_EXACT_ALARM" />
```

### 🎤 **Audio Monitoring REAL (NEW)**

Înlocuit animație fake cu detecție REALĂ de sunet de la microfon:

**Implementare:**
- Folosește `noise_meter` package
- Cere permisiune `RECORD_AUDIO` la runtime
- Convertește decibeli (40-80 dB) în bare vizuale
- Fallback automat la animație simulată dacă permisiunea e refuzată

**Ranguri decibeli:**
- 40 dB = quiet (bare mici)
- 60 dB = normal speech (bare medii)
- 80+ dB = loud (bare mari)

### 📱 **Comenzi Build & Run Android (macOS)**

**Debug Build (testare rapidă):**
```bash
cd ~/Documents/icd360sev_mitglieder_android
flutter build apk --debug
```

**Release Build (producție cu obfuscation + split-per-abi):**
```bash
flutter build apk --release --flavor fdroid \
  --obfuscate --split-debug-info=build/symbols --split-per-abi
# Output: build/app/outputs/flutter-apk/app-fdroid-arm64-v8a-release.apk (~50MB)
# Symbols: build/symbols/ (salvează pentru crash de-obfuscation!)
```

**Run pe Emulator/Device:**
```bash
# Vezi dispozitive disponibile
flutter devices

# Rulează în debug mode
flutter run

# Rulează în release mode (mai rapid)
flutter run --release
```

**APK Output Location:**
- Debug: `build/app/outputs/flutter-apk/app-debug.apk`
- Release (split-per-abi): `build/app/outputs/flutter-apk/app-fdroid-arm64-v8a-release.apk` (~50MB)
- Symbols: `build/symbols/` (salvează pentru crash de-obfuscation!)

### 🔄 **Workflow Modificări (Android)**

| Ai modificat... | Trebuie să faci... |
|-----------------|-------------------|
| ✏️ UI Flutter (Text, Color, Widget) | `r` (Hot Reload în terminal) |
| 🔄 Logică Flutter (funcții, state) | `R` (Hot Restart) |
| 📦 Adăugat pachet în `pubspec.yaml` | `flutter pub get` + `q` + `flutter run` |
| 🔧 Cod Kotlin/Java | `flutter clean` + `flutter run` |
| ⚙️ AndroidManifest / Gradle | `q` + `flutter run` |

### 🎯 **Android Studio Setup (macOS)**

**Pentru emulator Android:**

1. Deschide **folderul `android/`** în Android Studio:
   ```
   Android Studio → File → Open
   → ~/Documents/icd360sev_mitglieder_android/android
   ```

2. Așteaptă Gradle sync să se termine

3. Creează/pornește emulator:
   ```
   Tools → Device Manager → Create Device
   → Pixel 6 + API 34 (Android 14)
   ```

4. Rulează app:
   ```bash
   flutter run
   ```

**Pentru rulare cu Hot Reload:**
- Editează cod Dart în VS Code
- Apasă `r` în terminal pentru reload instant
- Emulatorul rămâne deschis!

---

### 🚀 **Pornire Emulator din Terminal (macOS)**

**Pornește emulator manual:**
```bash
# Vezi lista de AVD-uri disponibile
emulator -list-avds

# Pornește emulator (înlocuiește AVD_NAME cu numele din lista de mai sus)
emulator -avd AVD_NAME

# Pornire fără snapshot (dacă ai probleme)
emulator -avd AVD_NAME -no-snapshot -no-boot-anim
```

**Configurație AVD recomandată:**
- `hw.gpu.mode=auto` - Hardware acceleration (Metal pe macOS)
- `hw.ramSize=4096` - 4GB RAM pentru emulator
- `hw.cpu.ncore=4` - 4 cores

### ✅ **Funcționalități Android**

**Implementări specifice Android:**
- ✅ Android notification channels cu runtime permissions
- ✅ WebView nativ Android (`webview_flutter`)
- ✅ Auto-update cu APK download + installer
- ✅ Audio monitoring REAL cu `noise_meter` (acces microfon)
- ✅ Secure storage cu Android Keystore
- ✅ Portrait mode lockdown
- ✅ Runtime permissions (RECORD_AUDIO, POST_NOTIFICATIONS, etc.)

**Funcționalități core (identice cu backend):**
- ✅ Login/Register cu role-based routing
- ✅ WebSocket chat real-time
- ✅ WebRTC voice calls
- ✅ Device management (max 3 devices)
- ✅ Termine + Urlaub system
- ✅ Tickets, Vereinverwaltung
- ✅ API endpoints (toate 61 endpoint-uri)

### 📊 **Verificare Finală**

```bash
flutter analyze
✅ No issues found!
```

**Aplicația este GATA pentru Android și poate fi buildată pentru producție!**

### ⚙️ **Gradle & Build Configuration (Fix-uri)**

**Probleme întâlnite la Android Studio sync:**

1. **minSdk prea mic** - Flutter cere minimum SDK 23
   - Fix: `minSdk = 21` → `minSdk = 23` în [android/app/build.gradle.kts:20](android/app/build.gradle.kts#L20)

2. **AGP 9.0 + Kotlin plugin conflict** - AGP 9.0 nu mai acceptă `kotlin-android` plugin separat
   - Fix: AGP downgrade la 8.7.3 în [android/settings.gradle.kts:22](android/settings.gradle.kts#L22)
   - Fix: Kotlin downgrade la 2.1.0 în [android/settings.gradle.kts:23](android/settings.gradle.kts#L23)

3. **Gradle incompatibil cu AGP** - Gradle 9.1.0 prea nou pentru AGP 8.7.3
   - Fix: Gradle downgrade la 8.9 în [android/gradle/wrapper/gradle-wrapper.properties:5](android/gradle/wrapper/gradle-wrapper.properties#L5)
   - Eroare rezolvată: `NoSuchMethodError: Project.exec()`

4. **NDK version mismatch** - `audio_streamer` plugin cere NDK 28.2.13676358
   - Fix: Adăugat `ndkVersion = "28.2.13676358"` în [android/app/build.gradle.kts:11](android/app/build.gradle.kts#L11)
   - NDK 28.2.13676358 instalat prin Android Studio SDK Manager

5. **Flutter plugins cer SDK 36** - 9 plugin-uri Flutter cer compileSdk 36
   - Plugins: audio_streamer, device_info_plus, flutter_webrtc, flutter_secure_storage, path_provider_android, etc.
   - Android Studio a upgrade-at automat AGP 8.7.3 → 8.13.2 (suportă SDK 36)
   - Android Studio a upgrade-at automat Gradle 8.9 → 8.13
   - Fix: Păstrat `compileSdk = 36` și `targetSdk = 36`

**Configurare finală funcțională:**
```kotlin
// android/settings.gradle.kts
plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.13.2" apply false  // Auto-upgraded pentru SDK 36
    id("org.jetbrains.kotlin.android") version "2.2.0" apply false
}

// android/app/build.gradle.kts
android {
    compileSdk = 36  // Android 15 (cerut de Flutter plugins)
    ndkVersion = "28.2.13676358"
    minSdk = 23   // Android 6.0+
    targetSdk = 36  // Android 15
}

// android/gradle/wrapper/gradle-wrapper.properties
distributionUrl=https\://services.gradle.org/distributions/gradle-8.13-all.zip
```

**Warning-uri acceptabile (pot fi ignorate):**
- `'ApkVariant' is deprecated` - deprecare în Flutter SDK, nu afectează build-ul
- Mesaje informative despre targetSdk 36 - pur informative, nu sunt erori

### 🔧 **AGP Version Compatibility (2026-01-24)**

**⚠️ IMPORTANT:** AGP 9.0 NU este compatibil cu Flutter în prezent!

**Problema cu AGP 9.0:**
- AGP 9.0 aplică automat Kotlin plugin și înregistrează extensia `kotlin`
- Când aplicăm manual `id("kotlin-android")`, se creează conflict: `Cannot add extension with name 'kotlin'`
- Când NU aplicăm Kotlin plugin, Flutter plugin dă NullPointerException

**Soluție FINALĂ:** **AGP 8.13.2 + Gradle 8.13** (suportă compileSdk 36)

**Configurație STABILĂ:**

```kotlin
// android/app/build.gradle.kts
plugins {
    id("com.android.application")
    id("kotlin-android")  // Funcționează perfect cu AGP 8.13.2
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    compileSdk = 36  // Android 15 (cerut de Flutter plugins)
    ndkVersion = "28.2.13676358"
    minSdk = 23
    targetSdk = 36
}
```

```kotlin
// android/settings.gradle.kts
plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.13.2" apply false  // Suportă SDK 36
    id("org.jetbrains.kotlin.android") version "2.2.0" apply false
}
```

```properties
// android/gradle/wrapper/gradle-wrapper.properties
distributionUrl=https\://services.gradle.org/distributions/gradle-8.13-all.zip
```

**Note:**
- AGP 9.0 va fi suportat când Flutter SDK va migra la noua arhitectură
- AGP 8.13.2 suportă compileSdk 36 (Android 15)
- Android Studio poate auto-upgrade AGP/Gradle când detectează cerințe SDK mai mari

### 🔨 **Final Build Fixes & Complete Configuration (2026-01-24)**

**⚠️ Toate problemele rezolvate până la build SUCCESSFUL:**

#### Fix 6: Core Library Desugaring
**Eroare:**
```
Dependency 'flutter_local_notifications' requires libraries to be desugared.
This enables the use of some Java 8+ APIs through a process called desugaring.
```

**Soluție:**
```kotlin
// android/app/build.gradle.kts
compileOptions {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
    isCoreLibraryDesugaringEnabled = true  // ← ADĂUGAT
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")  // ← ADĂUGAT
}
```

**Ce rezolvă:** Permite folosirea Java 8+ APIs (java.time, streams, etc.) pe Android 6.0+ (API 23+)

#### Fix 7: JVM Target Mismatch
**Eroare:**
```
Inconsistent JVM-target compatibility detected for tasks
'compileDebugJavaWithJavac' (17) and 'compileDebugKotlin' (21)
```

**Cauză:** Java compila cu target 17, Kotlin cu target implicit 21

**Soluție:**
```kotlin
// android/app/build.gradle.kts
kotlinOptions {
    jvmTarget = "17"  // ← ADĂUGAT - sincronizare cu Java target
}
```

### 📋 **android/app/build.gradle.kts - Configurație Finală Completă**

```kotlin
plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "de.icd360s.mitglieder"
    compileSdk = 36  // Android 15 (cerut de 9 Flutter plugins)
    ndkVersion = "28.2.13676358"  // Cerut de audio_streamer plugin

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true  // Java 8+ APIs pe Android 6+
    }

    kotlinOptions {
        jvmTarget = "17"  // Sincronizat cu Java target
    }

    defaultConfig {
        applicationId = "de.icd360s.mitglieder"
        minSdk = flutter.minSdkVersion  // Android 6.0+ (Flutter minimum: 23)
        targetSdk = 36  // Android 15
        versionCode = 106
        versionName = "1.1.10"

        // Build for arm64-v8a + x86_64 (devices + emulator)
        ndk {
            abiFilters.addAll(listOf("arm64-v8a", "x86_64"))
        }
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}

flutter {
    source = "../.."
}
```

### 📋 **android/settings.gradle.kts - Configurație Finală**

```kotlin
pluginManagement {
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.13.2" apply false  // Suportă compileSdk 36
    id("org.jetbrains.kotlin.android") version "2.2.0" apply false
}

include(":app")
```

### 📋 **android/gradle/wrapper/gradle-wrapper.properties**

```properties
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
distributionUrl=https\://services.gradle.org/distributions/gradle-8.13-all.zip
```

### 📋 **android/gradle.properties**

```properties
org.gradle.jvmargs=-Xmx8G -XX:MaxMetaspaceSize=4G -XX:ReservedCodeCacheSize=512m -XX:+HeapDumpOnOutOfMemoryError
android.useAndroidX=true

# Disable AGP upgrade suggestions (Flutter not compatible with AGP 9.0 yet)
android.suppressUnsupportedOptionWarning=android.suppressUnsupportedOptionWarning
```

### 📋 **android/build.gradle.kts - Root Project**

```kotlin
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
```

### ✅ **Rezultat Final**

**Build Status:** ✅ **SUCCESSFUL**

**Componente instalate:**
- ✅ Android Gradle Plugin 8.13.2
- ✅ Gradle 8.13
- ✅ Kotlin 2.2.0 (JVM target 17)
- ✅ NDK 28.2.13676358
- ✅ Android SDK 36 (Android 15)
- ✅ Core Library Desugaring

**Verificare:**
```bash
cd ~/Documents/icd360sev_mitglieder_android
flutter clean
flutter pub get
flutter build apk --debug
# ✅ BUILD SUCCESSFUL
```

**Mesaje informative (nu erori):**
- Android Studio poate afișa un mesaj roșu despre targetSdk 36 upgrade
- Acest mesaj e pur **informativ** - informează despre comportamente noi în SDK 36
- **NU este o eroare** - build-ul este funcțional și gata pentru producție

**Aplicația este GATA pentru testare pe emulator/dispozitiv Android!**

---

**Platform:** Android (API 23-36) - Development on macOS (Flutter 3.41.4)
**Last build:** 2026-04-04 (v1.1.10 build 106)
**Last update:** 2026-04-04 (v1.1.10 Interner Datei-Viewer + Package-Upgrades)
**Project path:** ~/Documents/icd360sev_mitglieder_android
**Status:** ✅ Production Ready - Build SUCCESSFUL
**Localization:** 28 languages, 558 keys, 100% UI coverage (excluding changelog)

---

# 📦 F-DROID CUSTOM REPOSITORY (2026-01-27)

## Overview

Aplicația ICD360S e.V. Mitglieder este disponibilă printr-un repository F-Droid custom pentru actualizări automate.

**Repository URL:** `https://icd360sev.icd360s.de/fdroid/repo`

**Fingerprint (SHA256):**
```
14 A7 1B F9 65 B1 8A 23 B4 53 99 5A 42 6F 21 DE 17 F0 C5 9A 08 BD 5C 46 37 59 0A 37 A9 EC 58 A1
```

## Instalare F-Droid Repository

### Pentru utilizatori:

1. Instalează F-Droid de la https://f-droid.org
2. Deschide F-Droid → Settings → Repositories → Add Repository
3. Introdu URL-ul: `https://icd360sev.icd360s.de/fdroid/repo`
4. Confirmă fingerprint-ul
5. Caută "ICD360S e.V. Mitglieder" și instalează

### QR Code pentru adăugare rapidă:
Disponibil la: `https://icd360sev.icd360s.de/fdroid/repo/index.html`

## Structura Server F-Droid

```
/var/www/icd360sev.icd360s.de/fdroid/
├── config.yml              # Configurație repository (chmod 600)
├── keystore.jks            # Keystore pentru semnare index (chmod 600)
├── metadata/
│   └── de.icd360s.mitglieder.yml  # Metadata aplicație
├── repo/
│   ├── icd360sev.apk       # APK curent
│   ├── index.jar           # Index signed JAR
│   ├── index-v1.jar        # Index v1 format
│   ├── index-v2.json       # Index v2 format
│   ├── index.html          # Web interface
│   ├── entry.jar           # Entry point
│   └── icons/              # App icons per DPI
└── archive/
    └── (older versions)    # Versiuni arhivate
```

## Actualizare F-Droid Repository

### Când trebuie actualizat:
- După fiecare release nou al aplicației
- Când se modifică metadata (descriere, icon, etc.)

### Pași pentru actualizare:

**1. Upload APK nou în repo:**
```bash
# Copiază APK-ul la server
scp -i "vps_icd360sev_icd360s.de" -P 36000 \
  "build/app/outputs/flutter-apk/app-release.apk" \
  root@icd360sev.icd360s.de:/var/www/icd360sev.icd360s.de/fdroid/repo/icd360sev.apk

# SAU actualizează din directorul downloads
ssh -i "vps_icd360sev_icd360s.de" -p 36000 root@icd360sev.icd360s.de \
  "cp /var/www/icd360sev.icd360s.de/downloads/mitglieder/android/icd360sev.apk \
      /var/www/icd360sev.icd360s.de/fdroid/repo/"
```

**2. Regenerează indexul:**
```bash
ssh -i "vps_icd360sev_icd360s.de" -p 36000 root@icd360sev.icd360s.de \
  "export ANDROID_SDK_ROOT=/opt/android-sdk && \
   export JAVA_HOME=/usr/lib/jvm/java-21-openjdk && \
   cd /var/www/icd360sev.icd360s.de/fdroid && \
   fdroid update"
```

**3. Verifică indexul:**
```bash
curl -I https://icd360sev.icd360s.de/fdroid/repo/index-v1.jar
# HTTP/1.1 200 OK înseamnă succes
```

## Componente Server

| Component | Versiune | Path |
|-----------|----------|------|
| fdroidserver | 2.4.3 | `/usr/local/bin/fdroid` |
| Java (OpenJDK) | 21.0.10 | `/usr/lib/jvm/java-21-openjdk` |
| Android SDK | cmdline-tools | `/opt/android-sdk` |
| apksigner | 34.0.0 | `/opt/android-sdk/build-tools/34.0.0/apksigner` |

## Configurație Nginx

```nginx
# F-Droid Repository
location /fdroid/ {
    autoindex on;
    # CORS headers for F-Droid client
    add_header Access-Control-Allow-Origin "*";
    add_header Access-Control-Allow-Methods "GET, HEAD, OPTIONS";
}
```

## Metadata Aplicație

**Path:** `/var/www/icd360sev.icd360s.de/fdroid/metadata/de.icd360s.mitglieder.yml`

```yaml
AuthorName: ICD360S e.V.
Categories:
  - System
CurrentVersionCode: 105
Description: |
  Offizielle Mitglieder-App des ICD360S e.V.

  Funktionen:
  - Mitglieder Login und Registrierung
  - Terminverwaltung
  - Live Chat mit Support
  - Voice Calls
  - Ticket-System
  - Profilmanagement

  Diese App ist nur für Mitglieder des ICD360S e.V. bestimmt.
IssueTracker: ''
License: Unknown
Name: ICD360S e.V. Mitglieder
Summary: Mitglieder-App für ICD360S e.V.
WebSite: https://icd360s.de
```

**Notă despre License:** `Unknown` este folosit pentru aplicații private/interne care nu au o licență publică standard. F-Droid acceptă acest tip pentru repo-uri custom.

## Keystore Info

**⚠️ IMPORTANT:** Keystore-ul NU trebuie șters sau modificat! Este necesar pentru semnarea indexului.

- **Path:** `/var/www/icd360sev.icd360s.de/fdroid/keystore.jks`
- **Alias:** `repo`
- **Algorithm:** RSA 4096-bit
- **Validity:** 10000 zile

## Troubleshooting

### Eroare: "apksigner not found"
```bash
# Verifică apksigner
ls -la /opt/android-sdk/build-tools/34.0.0/apksigner
# Reinstalează dacă lipsește
cd /opt/android-sdk
yes | cmdline-tools/latest/bin/sdkmanager --sdk_root=/opt/android-sdk 'build-tools;34.0.0'
```

### Eroare: "JAR signature failed to verify"
APK-ul are doar semnătură v2/v3. F-Droid acceptă dar afișează warning.
Aplicația va funcționa normal pentru utilizatori.

### Repository nu apare în F-Droid
1. Verifică URL-ul: `https://icd360sev.icd360s.de/fdroid/repo`
2. Verifică fingerprint-ul se potrivește
3. Refresh repositories în F-Droid

---

**F-Droid Repository Status:** ✅ Active
**Last index update:** 2026-04-04 (v1.1.10 build 106)
**Development Platform:** macOS
