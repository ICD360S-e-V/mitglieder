<p align="center">
  <h1 align="center">ICD360S e.V. - Mitgliederportal</h1>
  <p align="center">
    <strong>Die offizielle Mitglieder-App des ICD360S e.V.</strong><br>
    Sicher. Mehrsprachig. Open Source.
  </p>
</p>

<p align="center">
  <a href="https://icd360s.de"><img src="https://img.shields.io/badge/Website-icd360s.de-blue?style=for-the-badge&logo=google-chrome&logoColor=white" alt="Website"></a>
  <a href="https://icd360sev.icd360s.de/fdroid/repo"><img src="https://img.shields.io/badge/F--Droid-Repository-green?style=for-the-badge&logo=fdroid&logoColor=white" alt="F-Droid"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/Lizenz-GPL--3.0-orange?style=for-the-badge&logo=gnu&logoColor=white" alt="License"></a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Android-verfuegbar-brightgreen?style=flat-square&logo=android&logoColor=white" alt="Android">
  <img src="https://img.shields.io/badge/Windows-verfuegbar-brightgreen?style=flat-square&logo=windows&logoColor=white" alt="Windows">
  <img src="https://img.shields.io/badge/Linux-verfuegbar-brightgreen?style=flat-square&logo=linux&logoColor=white" alt="Linux">
  <img src="https://img.shields.io/badge/macOS-Beta-yellow?style=flat-square&logo=apple&logoColor=white" alt="macOS">
  <img src="https://img.shields.io/badge/iOS-Beta-yellow?style=flat-square&logo=apple&logoColor=white" alt="iOS">
  <img src="https://img.shields.io/badge/Flutter-3.41.6-02569B?style=flat-square&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Sprachen-28-blueviolet?style=flat-square&logo=translate&logoColor=white" alt="Languages">
</p>

---

## Funktionen

| | Funktion | Beschreibung |
|---|---|---|
| :busts_in_silhouette: | **Mitgliederverwaltung** | Registrierung, Login, Profil, 8-Stufen Verifizierung |
| :calendar: | **Terminverwaltung** | Wochenkalender mit KW-Navigation, Urlaub, Feiertage |
| :speech_balloon: | **Live Chat** | Echtzeit-Kommunikation mit dem Vorstand (WebSocket) |
| :telephone_receiver: | **Sprachanrufe** | Peer-to-Peer Voice Calls (WebRTC + TURN/STUN) |
| :ticket: | **Ticket-System** | Anfragen erstellen, verfolgen, Dateianhang |
| :bell: | **Push-Benachrichtigungen** | Sofort, ohne Google-Dienste (ntfy) |
| :page_facing_up: | **Datei-Viewer** | PDF und Bilder direkt in der App oeffnen |
| :globe_with_meridians: | **28 Sprachen** | Automatische Spracherkennung |
| :arrows_counterclockwise: | **Auto-Update** | Automatisch ueber F-Droid oder intern |

---

## Downloads

### Android

<table>
<tr>
<td align="center" width="50%">

**F-Droid Repository (empfohlen)**

![F-Droid QR](https://api.qrserver.com/v1/create-qr-code/?size=180x180&data=https://icd360sev.icd360s.de/fdroid/repo&color=1a73e8)

:link: [`https://icd360sev.icd360s.de/fdroid/repo`](https://icd360sev.icd360s.de/fdroid/repo)

Automatische Updates alle 12-24 Stunden

</td>
<td align="center" width="50%">

**Universal APK (Direktdownload)**

![APK QR](https://api.qrserver.com/v1/create-qr-code/?size=180x180&data=https://icd360sev.icd360s.de/downloads/mitglieder/android/universal/icd360sev.apk&color=34a853)

:link: [`https://icd360sev.icd360s.de/downloads/mitglieder/android/universal/icd360sev.apk`](https://icd360sev.icd360s.de/downloads/mitglieder/android/universal/icd360sev.apk)

Manuell installieren, Auto-Update integriert

</td>
</tr>
</table>

> :soon: **Google Play**, **Huawei AppGallery**, **Amazon Appstore** und **Samsung Galaxy Store** befinden sich in Vorbereitung (Beta-Tester gesucht).

### Desktop & iOS

| Plattform | Format | Status | Download |
|-----------|--------|--------|----------|
| :desktop_computer: **Windows** | EXE Installer | :green_circle: Verfuegbar | [`icd360sev_setup.exe`](https://icd360sev.icd360s.de/downloads/mitglieder/windows/icd360sev_setup.exe) |
| :penguin: **Linux** | DEB | :green_circle: Verfuegbar | [`icd360sev-mitglied.deb`](https://icd360sev.icd360s.de/downloads/mitglieder/linux/icd360sev-mitglied.deb) |
| :penguin: **Linux** | RPM | :green_circle: Verfuegbar | [`icd360sev-mitglied.rpm`](https://icd360sev.icd360s.de/downloads/mitglieder/linux/icd360sev-mitglied.rpm) |
| :penguin: **Linux** | AppImage | :green_circle: Verfuegbar | [`icd360sev-mitglied.AppImage`](https://icd360sev.icd360s.de/downloads/mitglieder/linux/icd360sev-mitglied.AppImage) |
| :apple: **macOS** | DMG | :yellow_circle: Beta | [`icd360sev-mitglied.dmg`](https://icd360sev.icd360s.de/downloads/mitglieder/macos/icd360sev-mitglied.dmg) |
| :iphone: **iOS** | IPA | :yellow_circle: Beta | TestFlight (kontakt@icd360s.de) |

---

## Technologie

<table>
<tr><td><strong>Framework</strong></td><td>Flutter 3.41.6 (Dart 3.11.4)</td></tr>
<tr><td><strong>Backend</strong></td><td>PHP 8.4, MariaDB 10.11, Nginx</td></tr>
<tr><td><strong>Echtzeit</strong></td><td>WebSocket (Ratchet PHP), WebRTC</td></tr>
<tr><td><strong>Sicherheit</strong></td><td>Certificate Pinning (ISRG Root X1), Code-Obfuscation, DSGVO-konform</td></tr>
<tr><td><strong>CI/CD</strong></td><td>GitHub Actions (automatischer Build, Release, Deploy)</td></tr>
<tr><td><strong>Notifications</strong></td><td>ntfy (FOSS, ohne Google/FCM)</td></tr>
<tr><td><strong>Lokalisierung</strong></td><td>28 Sprachen, 558 Uebersetzungsschluessel</td></tr>
</table>

---

## Sicherheit & Datenschutz

:shield: Keine Google-Dienste erforderlich (100% FOSS-kompatibel)
:no_entry_sign: Keine Werbung, kein Tracking, keine Analytics
:flag_de: Alle Daten auf eigenem Server in Deutschland
:lock: SSL Certificate Pinning auf allen Verbindungen
:white_check_mark: DSGVO-konform
:closed_lock_with_key: Dart-Code Obfuscation in allen Release-Builds

---

## Beta-Tester gesucht

Wir suchen aktiv Beta-Tester fuer folgende Plattformen:

- :apple: **iOS** - TestFlight Beta
- :desktop_computer: **macOS** - DMG Direktdownload
- :iphone: **Google Play** - Closed Beta Track

:email: Interessierte Mitglieder: **kontakt@icd360s.de**

---

## Quellcode & Transparenz

| | Link |
|---|---|
| :octocat: **Repository** | [`github.com/ICD360S-e-V/mitglieder`](https://github.com/ICD360S-e-V/mitglieder) |
| :globe_with_meridians: **Website** | [`icd360s.de`](https://icd360s.de) |
| :page_with_curl: **Impressum** | [`icd360s.de/impressum`](https://icd360s.de/impressum) |
| :lock: **Datenschutz** | [`icd360s.de/datenschutz`](https://icd360s.de/datenschutz) |
| :package: **F-Droid Repo** | [`icd360sev.icd360s.de/fdroid/repo`](https://icd360sev.icd360s.de/fdroid/repo) |
| :incoming_envelope: **Kontakt** | [`kontakt@icd360s.de`](mailto:kontakt@icd360s.de) |

---

## Lizenz

Dieses Projekt ist lizenziert unter der [**GNU General Public License v3.0**](LICENSE).

Jeder darf den Quellcode einsehen, verwenden, modifizieren und weiterverbreiten - unter der Bedingung, dass abgeleitete Werke ebenfalls unter GPL-3.0 veroeffentlicht werden.

---

<p align="center">
  <strong>ICD360S e.V.</strong> | Neu-Ulm, Deutschland<br>
  <a href="https://icd360s.de">icd360s.de</a> | <a href="mailto:kontakt@icd360s.de">kontakt@icd360s.de</a>
</p>
