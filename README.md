# ICD360S e.V. - Mitgliederportal

Die offizielle Mitglieder-App des **ICD360S e.V.** - eine sichere, mehrsprachige Plattform zur Verwaltung aller Vereinsaktivitaeten.

![Platform](https://img.shields.io/badge/Android-available-brightgreen)
![Platform](https://img.shields.io/badge/iOS-Beta-yellow)
![Platform](https://img.shields.io/badge/macOS-Beta-yellow)
![Platform](https://img.shields.io/badge/Windows-available-brightgreen)
![Platform](https://img.shields.io/badge/Linux-available-brightgreen)
![Flutter](https://img.shields.io/badge/Flutter-3.41.6-blue)
![License](https://img.shields.io/badge/License-GPL--3.0-blue)

## Funktionen

- **Mitgliederverwaltung** - Registrierung, Login, Profilverwaltung, 8-Stufen Verifizierung
- **Terminverwaltung** - Wochenkalender mit KW-Navigation, Urlaubs- und Feiertagsplanung
- **Live Chat** - Echtzeit-Kommunikation mit dem Vorstand via WebSocket
- **Sprachanrufe** - Peer-to-Peer Voice Calls via WebRTC mit TURN/STUN
- **Ticket-System** - Anfragen erstellen, verfolgen und verwalten mit Dateianhang
- **Push-Benachrichtigungen** - Sofortige Benachrichtigungen ohne Google-Dienste (ntfy)
- **Interner Datei-Viewer** - PDF und Bilder direkt in der App oeffnen
- **28 Sprachen** - Vollstaendig lokalisiert mit automatischer Spracherkennung
- **Auto-Update** - Automatische Aktualisierungen ueber F-Droid oder internen Update-Service

## Plattformen & Verfuegbarkeit

| Plattform | Format | Status | Distribution |
|-----------|--------|--------|--------------|
| **Android** | APK | Verfuegbar | [F-Droid Repository](https://icd360sev.icd360s.de/fdroid/repo) |
| **Android** | APK (Universal) | Verfuegbar | [Direktdownload](https://icd360sev.icd360s.de/downloads/mitglieder/android/universal/icd360sev.apk) |
| **Android** | APK/AAB | In Vorbereitung | Google Play, Huawei AppGallery, Amazon Appstore, Samsung Galaxy Store |
| **Windows** | EXE Installer | Verfuegbar | [Direktdownload](https://icd360sev.icd360s.de/downloads/mitglieder/windows/icd360sev_setup.exe) |
| **Linux** | DEB | Verfuegbar | [Direktdownload](https://icd360sev.icd360s.de/downloads/mitglieder/linux/icd360sev-mitglied.deb) |
| **Linux** | RPM | Verfuegbar | [Direktdownload](https://icd360sev.icd360s.de/downloads/mitglieder/linux/icd360sev-mitglied.rpm) |
| **Linux** | AppImage | Verfuegbar | [Direktdownload](https://icd360sev.icd360s.de/downloads/mitglieder/linux/icd360sev-mitglied.AppImage) |
| **macOS** | DMG | Beta-Phase | [Direktdownload](https://icd360sev.icd360s.de/downloads/mitglieder/macos/icd360sev-mitglied.dmg) (sucht Beta-Tester) |
| **iOS** | IPA | Beta-Phase | TestFlight (sucht Beta-Tester) |

Die Store-Veroeffentlichungen (Google Play, Huawei, Amazon, Samsung, App Store) befinden sich in Vorbereitung und werden verfuegbar, sobald ausreichend Beta-Tester die App validiert haben.

## Installation

### Android

**Option 1: F-Droid (empfohlen)**

1. [F-Droid](https://f-droid.org) installieren
2. Repository hinzufuegen: `https://icd360sev.icd360s.de/fdroid/repo`
3. Nach **ICD360S e.V. Mitglieder** suchen und installieren

Updates werden automatisch ueber F-Droid bereitgestellt (alle 12-24 Stunden).

**Option 2: Universal APK (Direktdownload)**

[APK herunterladen](https://icd360sev.icd360s.de/downloads/mitglieder/android/universal/icd360sev.apk) und manuell installieren. Die App prueft automatisch auf Updates.

### Windows / Linux / macOS

Downloads sind in der Tabelle oben verlinkt. Die App prueft automatisch auf Updates nach der Installation.

## Technologie

| Komponente | Technologie |
|------------|-------------|
| **Framework** | Flutter 3.41.6 (Dart 3.11.4) |
| **Backend** | PHP 8.4, MariaDB 10.11, Nginx |
| **Echtzeit** | WebSocket (Ratchet PHP), WebRTC |
| **Sicherheit** | Certificate Pinning (ISRG Root X1), Code-Obfuscation |
| **CI/CD** | GitHub Actions (automatischer Build, Release, Deploy) |
| **Benachrichtigungen** | ntfy (FOSS, ohne Google/FCM) |
| **Lokalisierung** | 28 Sprachen, 558 Uebersetzungsschluessel |

## Sicherheit & Datenschutz

- Keine Google-Dienste erforderlich (100% FOSS-kompatibel)
- Keine Werbung, kein Tracking, keine Analytics
- Alle Daten auf eigenem Server in Deutschland gehostet
- SSL Certificate Pinning auf allen Verbindungen
- DSGVO-konform
- Dart-Code Obfuscation in allen Release-Builds

## Beta-Tester gesucht

Wir suchen aktiv Beta-Tester fuer folgende Plattformen:

- **iOS** - TestFlight Beta
- **macOS** - DMG Direktdownload
- **Google Play** - Closed Beta Track

Interessierte Mitglieder koennen sich per E-Mail melden: **kontakt@icd360s.de**

## Lizenz

Dieses Projekt ist lizenziert unter der [GNU General Public License v3.0](LICENSE).

Jeder darf den Quellcode einsehen, verwenden, modifizieren und weiterverbreiten - unter der Bedingung, dass abgeleitete Werke ebenfalls unter GPL-3.0 veroeffentlicht werden.

## Impressum

**ICD360S e.V.**
Neu-Ulm, Deutschland

E-Mail: kontakt@icd360s.de
Web: [icd360s.de](https://icd360s.de)
Impressum: [icd360s.de/impressum](https://icd360s.de/impressum)
Datenschutz: [icd360s.de/datenschutz](https://icd360s.de/datenschutz)
