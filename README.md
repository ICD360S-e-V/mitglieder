<p align="center">
  <h1 align="center">ICD360S e.V. - Mitgliederportal</h1>
  <p align="center">
    <strong>Die offizielle Mitglieder-App des ICD360S e.V.</strong><br>
    Sicher. Mehrsprachig. Open Source.
  </p>
</p>

<p align="center">
  <a href="https://icd360s.de"><img src="https://img.shields.io/badge/Website-icd360s.de-blue?style=for-the-badge&logo=google-chrome&logoColor=white" alt="Website"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/Lizenz-GPL--3.0-orange?style=for-the-badge&logo=gnu&logoColor=white" alt="License"></a>
  <a href="mailto:kontakt@icd360s.de"><img src="https://img.shields.io/badge/Kontakt-kontakt%40icd360s.de-red?style=for-the-badge&logo=gmail&logoColor=white" alt="Kontakt"></a>
</p>

---

## Funktionen

| | Funktion | Beschreibung |
|---|---|---|
| :busts_in_silhouette: | **Mitgliederverwaltung** | Registrierung, Login, Profil, 8-Stufen Verifizierung |
| :calendar: | **Terminverwaltung** | Wochenkalender mit KW-Navigation, Urlaub, Feiertage |
| :speech_balloon: | **Live Chat** | Echtzeit mit dem Vorstand (WebSocket) |
| :telephone_receiver: | **Sprachanrufe** | Peer-to-Peer (WebRTC + TURN/STUN) |
| :ticket: | **Ticket-System** | Anfragen erstellen, verfolgen, Dateianhang |
| :bell: | **Push-Benachrichtigungen** | Sofort, ohne Google (ntfy) |
| :page_facing_up: | **Datei-Viewer** | PDF und Bilder direkt in der App |
| :globe_with_meridians: | **28 Sprachen** | Automatische Spracherkennung |

---

## Downloads

### :iphone: Android

<p align="center">
  <img src="https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=https://icd360sev.icd360s.de/fdroid/repo&color=1a73e8" alt="F-Droid QR">
</p>

**F-Droid (empfohlen)** - automatische Updates

1. F-Droid installieren: [`https://f-droid.org`](https://f-droid.org)
2. Repository hinzufuegen: [`https://icd360sev.icd360s.de/fdroid/repo`](https://icd360sev.icd360s.de/fdroid/repo)
3. Nach **ICD360S e.V. Mitglieder** suchen

**Universal APK** - Direktdownload (unabhaengig von F-Droid)

<p align="center">
  <img src="https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=https://icd360sev.icd360s.de/downloads/mitglieder/android/universal/icd360sev.apk&color=34a853" alt="APK QR">
</p>

> :link: [`https://icd360sev.icd360s.de/downloads/mitglieder/android/universal/icd360sev.apk`](https://icd360sev.icd360s.de/downloads/mitglieder/android/universal/icd360sev.apk)

:soon: Google Play, Huawei, Amazon, Samsung - in Vorbereitung (Beta-Tester gesucht: kontakt@icd360s.de)

---

### :desktop_computer: Windows

> <img src="https://img.shields.io/badge/Windows-Installer-0078D6?style=for-the-badge&logo=windows&logoColor=white" alt="Windows">
>
> :link: [`https://icd360sev.icd360s.de/downloads/mitglieder/windows/icd360sev_setup.exe`](https://icd360sev.icd360s.de/downloads/mitglieder/windows/icd360sev_setup.exe)

---

### :penguin: Linux

> <img src="https://img.shields.io/badge/Linux-Pakete-FCC624?style=for-the-badge&logo=linux&logoColor=black" alt="Linux">
>
> :link: DEB: [`https://icd360sev.icd360s.de/downloads/mitglieder/linux/icd360sev-mitglied.deb`](https://icd360sev.icd360s.de/downloads/mitglieder/linux/icd360sev-mitglied.deb)
>
> :link: RPM: [`https://icd360sev.icd360s.de/downloads/mitglieder/linux/icd360sev-mitglied.rpm`](https://icd360sev.icd360s.de/downloads/mitglieder/linux/icd360sev-mitglied.rpm)
>
> :link: AppImage: [`https://icd360sev.icd360s.de/downloads/mitglieder/linux/icd360sev-mitglied.AppImage`](https://icd360sev.icd360s.de/downloads/mitglieder/linux/icd360sev-mitglied.AppImage)

---

### :apple: macOS / iOS (Beta - sucht Tester)

> <img src="https://img.shields.io/badge/macOS-DMG-000000?style=for-the-badge&logo=apple&logoColor=white" alt="macOS">
>
> :link: macOS: [`https://icd360sev.icd360s.de/downloads/mitglieder/macos/icd360sev-mitglied.dmg`](https://icd360sev.icd360s.de/downloads/mitglieder/macos/icd360sev-mitglied.dmg)
>
> :iphone: iOS: TestFlight Beta - Zugang per E-Mail: kontakt@icd360s.de

---

## Technologie & Sicherheit

| Komponente | Details |
|------------|---------|
| **Framework** | Flutter 3.41.6 (Dart 3.11.4) |
| **Backend** | PHP 8.5, MariaDB 10.11, Nginx 1.29 |
| **Echtzeit** | WebSocket (Ratchet), WebRTC |
| **Sicherheit** | Certificate Pinning, Code-Obfuscation, DSGVO-konform |
| **CI/CD** | GitHub Actions (Build, Release, Deploy) |
| **Notifications** | ntfy (FOSS, ohne Google) |
| **Sprachen** | 28 Sprachen, 777 Schluessel |
| **Datenschutz** | Eigener Server in Deutschland, kein Tracking, keine Werbung |

---

## Transparenz

| | Link |
|---|---|
| :octocat: Repository | [`https://github.com/ICD360S-e-V/mitglieder`](https://github.com/ICD360S-e-V/mitglieder) |
| :globe_with_meridians: Website | [`https://icd360s.de`](https://icd360s.de) |
| :page_with_curl: Impressum | [`https://icd360s.de/impressum`](https://icd360s.de/impressum) |
| :lock: Datenschutz | [`https://icd360s.de/datenschutz`](https://icd360s.de/datenschutz) |
| :package: F-Droid | [`https://icd360sev.icd360s.de/fdroid/repo`](https://icd360sev.icd360s.de/fdroid/repo) |

---

## Lizenz

[**GNU General Public License v3.0**](LICENSE) - Quellcode frei einsehbar, nutzbar und modifizierbar. Abgeleitete Werke muessen ebenfalls unter GPL-3.0 veroeffentlicht werden.

---

<p align="center">
  <strong>ICD360S e.V.</strong> | Neu-Ulm, Deutschland
</p>
