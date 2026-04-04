import 'dart:async';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../screens/webview_screen.dart';
import '../services/update_service.dart';
import '../services/logger_service.dart';
import 'update_dialog.dart';

const String appVersion = '1.1.11';

class LegalFooter extends StatefulWidget {
  final bool darkMode;

  const LegalFooter({
    super.key,
    this.darkMode = false,
  });

  @override
  State<LegalFooter> createState() => _LegalFooterState();
}

class _LegalFooterState extends State<LegalFooter> with SingleTickerProviderStateMixin {
  final _log = LoggerService();
  bool _isChecking = false;
  Timer? _autoCheckTimer;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Start auto-check timer (every 24 hours)
    // F-Droid will handle updates, this is just a fallback
    _autoCheckTimer = Timer.periodic(const Duration(hours: 24), (_) {
      _checkForUpdates(silent: true);
    });
  }

  @override
  void dispose() {
    _autoCheckTimer?.cancel();
    _rotationController.dispose();
    super.dispose();
  }

  Future<void> _checkForUpdates({bool silent = false}) async {
    if (_isChecking) return;

    setState(() => _isChecking = true);
    _rotationController.repeat();

    if (!silent && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Text(AppLocalizations.of(context)?.searchingForUpdates ?? 'Suche nach Updates...'),
            ],
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.blue.shade700,
        ),
      );
    }

    _log.info('Checking for updates...', tag: 'UPDATE');

    try {
      final updateService = UpdateService();
      final updateInfo = await updateService.checkForUpdate();

      if (!mounted) return;

      _rotationController.stop();
      _rotationController.reset();
      setState(() => _isChecking = false);

      if (updateInfo != null) {
        _log.info('Update available: ${updateInfo.version}', tag: 'UPDATE');
        // Show update dialog
        showDialog(
          context: context,
          barrierDismissible: !updateInfo.forceUpdate,
          builder: (context) => UpdateDialog(updateInfo: updateInfo),
        );
      } else if (!silent && mounted) {
        _log.info('No updates available', tag: 'UPDATE');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Text(AppLocalizations.of(context)?.appUpToDate ?? 'Die App ist auf dem neuesten Stand'),
              ],
            ),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.green.shade600,
          ),
        );
      }
    } catch (e) {
      _log.error('Update check failed: $e', tag: 'UPDATE');
      if (!mounted) return;

      _rotationController.stop();
      _rotationController.reset();
      setState(() => _isChecking = false);

      if (!silent) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Text(AppLocalizations.of(context)?.updateCheckError ?? 'Fehler bei der Update-Prüfung'),
              ],
            ),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red.shade600,
          ),
        );
      }
    }
  }

  void _showChangelog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.history, color: Colors.blue.shade700),
            const SizedBox(width: 12),
            Text(AppLocalizations.of(context)?.changelog ?? 'Änderungsprotokoll'),
          ],
        ),
        content: SizedBox(
          width: 450,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildVersionEntry(
                  'v1.1.11',
                  '04.04.2026',
                  [
                    'FIX: App sendet jetzt die korrekte Client-Version an den Server',
                    'FIX: War vorher hardcodiert auf alte Version',
                  ],
                  isLatest: true,
                ),
                _buildVersionEntry(
                  'v1.1.10',
                  '04.04.2026',
                  [
                    'NEU: PDF-Dateien direkt in der App öffnen (interner Viewer mit Zoom)',
                    'NEU: Bilder (JPG, PNG, GIF, WebP) intern anzeigen mit Zoom und Pan',
                    'NEU: "Extern öffnen" Button als Fallback im Viewer',
                    'IMPROVED: Flutter 3.41.4 → 3.41.6, Kotlin 2.1.0 → 2.2.0',
                    'IMPROVED: battery_plus 7, connectivity_plus 7, pdfrx 2.2',
                    'IMPROVED: system_tray (abandoniert) → tray_manager (aktiv gepflegt)',
                    'IMPROVED: local_notifier entfernt → ein Paket für alle Plattformen',
                    'IMPROVED: 30 veraltete Pakete → 6 (16 Updates)',
                  ],
                ),
                _buildVersionEntry(
                  'v1.1.9',
                  '03.04.2026',
                  [
                    'FIX: Batterie-Daten korrekt pro Mitglied gespeichert',
                    'FIX: Mitgliedernummer an Diagnostik-Service übergeben',
                  ],
                ),
                _buildVersionEntry(
                  'v1.1.8',
                  '03.04.2026',
                  [
                    'NEU: Batterie-Monitoring an Server (Level + Ladestatus)',
                    'NEU: Pro-Mitglied Batterie-Verlauf in Datenbank',
                    'NEU: Automatische Datenrotation nach 30 Tagen',
                  ],
                ),
                _buildVersionEntry(
                  'v1.1.7',
                  '03.04.2026',
                  [
                    'IMPROVED: Batterieverbrauch von ~15% auf ~2-3% pro Tag reduziert',
                    'IMPROVED: UI-Timer pausieren automatisch im Hintergrund',
                    'IMPROVED: WebSocket-Ping optimiert (45s statt 30s)',
                    'IMPROVED: Support-Status 30s, Kalender 60s, Heartbeat 60s',
                    'FIX: Unnötigen Health-Check-Timer entfernt',
                  ],
                ),
                _buildVersionEntry(
                  'v1.1.6',
                  '03.04.2026',
                  [
                    'IMPROVED: Oster-Dekorationen hinter Chat-Nachrichten (bessere Lesbarkeit)',
                  ],
                ),
                _buildVersionEntry(
                  'v1.1.5',
                  '03.04.2026',
                  [
                    'NEU: SSL Certificate Pinning (Schutz vor MITM-Angriffen)',
                    'NEU: Oster-/Frühlings-Thema automatisch im April',
                    'NEU: ntfy Push-Benachrichtigungen (ohne Google/FCM)',
                    'NEU: TURN-Zugangsdaten vom Server geladen',
                    'SICHERHEIT: Token nicht mehr in WebSocket-URL',
                    'SICHERHEIT: Dart-Code-Verschleierung aktiviert',
                    'FIX: Benachrichtigungs-IDs eindeutig (keine Überschreibungen)',
                    'FIX: Speicherlecks behoben (Timer, Streams)',
                    'FIX: HTTP-Timeouts auf allen Diensten',
                    'FIX: Hintergrund-Dienst Android 15 kompatibel',
                    'IMPROVED: APK von 98MB auf ~50MB reduziert',
                    'IMPROVED: Cross-Platform-Kompatibilität verbessert',
                  ],
                ),
                _buildVersionEntry(
                  'v1.1.4',
                  '25.03.2026',
                  [
                    'NEU: Netzwerk-Diagnose (WiFi/4G/5G/Offline + Ping + Qualität)',
                    'NEU: Netzwerk-Status im Live-Chat sichtbar',
                    'IMPROVED: Chat-Nachrichten werden sofort übersetzt (kein Neustart nötig)',
                    'FIX: Doppelte Nachrichten im Live-Chat behoben',
                  ],
                ),
                _buildVersionEntry(
                  'v1.1.3',
                  '25.03.2026',
                  [
                    'NEU: Echtzeit Chat-Übersetzung via NLLB-200',
                    'FIX: Doppelte Nachrichten im Chat behoben',
                  ],
                  isLatest: false,
                ),
                _buildVersionEntry(
                  'v1.1.2',
                  '25.03.2026',
                  [
                    'FIX: Device-Sprache wird jetzt korrekt für alle 28 Sprachen erkannt',
                    'FIX: Xiaomi/MIUI Locale-Erkennung repariert',
                    'FIX: Login speichert preferred_language automatisch',
                  ],
                  isLatest: false,
                ),
                _buildVersionEntry(
                  'v1.1.1',
                  '25.03.2026',
                  [
                    'NEU: Arabisch (AR) als 28. Sprache vollständig übersetzt (558 Schlüssel)',
                    'IMPROVED: flutter_webrtc 1.3.1 → 1.4.1',
                    'IMPROVED: noise_meter 5.0.2 → 5.1.0',
                    'FIX: Login-Bug (device_locale Warning) behoben',
                  ],
                  isLatest: false,
                ),
                _buildVersionEntry(
                  'v1.1.0',
                  '25.03.2026',
                  [
                    'NEU: App zu 99% in 27 Sprachen übersetzt (558 Übersetzungsschlüssel)',
                    'NEU: 63 neue Übersetzungsschlüssel für bisher hardcodierte Texte',
                    'IMPROVED: Login, Registrierung, Profil, Chat, Termine, Tickets vollständig lokalisiert',
                    'IMPROVED: Hintergrund-Benachrichtigungen in der Sprache des Benutzers',
                    'FIX: DateFormat verwendet jetzt Geräte-Locale statt hartcodiertem de_DE',
                  ],
                  isLatest: false,
                ),
                _buildVersionEntry(
                  'v1.0.94',
                  '24.03.2026',
                  [
                    'NEU: Termine-Ansicht komplett in 27 Sprachen übersetzt',
                    'NEU: Kategorien lokalisiert (Vorstandssitzung, Schulung, etc.)',
                    'NEU: Status lokalisiert (Bestätigt, Abgelehnt, Ausstehend)',
                    'NEU: 38 neue Übersetzungsschlüssel für Termine-System',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.93',
                  '24.03.2026',
                  [
                    'NEU: Türkisch (TR) als 27. Sprache hinzugefügt',
                    'NEU: Update-Dialog komplett lokalisiert (27 Sprachen)',
                    'NEU: 15 neue Übersetzungsschlüssel für Update-System',
                    'IMPROVED: Download-Fortschritt & Changelog lokalisiert',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.92',
                  '15.03.2026',
                  [
                    'FIX: Server Cron-Jobs repariert (Scheduled Messages)',
                    'FIX: WebSocket read_receipt Support hinzugefügt',
                    'FIX: PHP CLI-Kompatibilität für config.php',
                    'IMPROVED: Dependencies Upgrade (Flutter 3.41.4)',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.91',
                  '13.03.2026',
                  [
                    'FIX: Chat-Attachment Download Fehler behoben (NoSuchMethodError)',
                    'FIX: Datei-Download funktioniert jetzt korrekt',
                    'FIX: Ticket-Kommentare Null-Crash behoben',
                    'FIX: Robustere JSON-Parsierung (Tickets, Kommentare, Anhänge)',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.89',
                  '24.02.2026',
                  [
                    'FIX: Doppelte Chat-Benachrichtigungen behoben',
                    'FIX: Eigene Nachrichten lösen keine Notification aus',
                    'IMPROVED: WebSocket Notification Deduplication (alle Plattformen)',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.88',
                  '22.02.2026',
                  [
                    'FEATURE: Stufe 5 Mitgliedschaftsbeginn (3 Optionen)',
                    'FEATURE: Retroaktive Beitragsberechnung',
                    'FEATURE: Ticket-Nachricht Übersetzung (NLLB-200)',
                    'FIX: Stufe 3 Speichern-Fehler (updated_at)',
                    'FIX: Stufen 6/7/8 Renummerierung',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.87',
                  '10.02.2026',
                  [
                    'SECURITY: SSL Certificate Validation (7 Services)',
                    'SECURITY: JWT Tokens verschlüsselt (SecureStorage)',
                    'SECURITY: Legacy API Key entfernt',
                    'SECURITY: R8 Code Obfuscation aktiviert',
                    'SECURITY: Score 6.5 → 9.3/10 (+43%)',
                    'FEATURE: Full-Screen Urgent Notifications (WarnWarn-Style)',
                    'FEATURE: 26 Sprachen komplett',
                    'FEATURE: Multi-Store Build (5 App Stores)',
                    'IMPROVED: Responsive Design (320-430px)',
                    'IMPROVED: Logout sichtbar auf allen Geräten',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.86',
                  '09.02.2026',
                  [
                    'FIX: Meine Termine - Programari werden jetzt korrekt angezeigt',
                    'FIX: JWT Token für Termin-Service (fehlende Authentifizierung)',
                    'NEU: Auto-Polling alle 15 Sekunden für neue Termine',
                    'NEU: Verifizierung System - 6 Stufen Identitätsprüfung',
                  ],
                  isLatest: false,
                ),
                _buildVersionEntry(
                  'v1.0.85',
                  '08.02.2026',
                  [
                    'NEU: Verifizierung System - 6 Stufen Identitätsprüfung',
                    'NEU: Zahlungstag Erinnerung - Benachrichtigung am Zahltag',
                    'NEU: Server-Endpoints /api/member/ für Verifizierung',
                    'IMPROVED: Stufe 2 (Mitgliedsart) nur vom Vorstand änderbar',
                  ],
                  isLatest: false,
                ),
                _buildVersionEntry(
                  'v1.0.84',
                  '03.02.2026',
                  [
                    'FIX: F-Droid Update Loop behoben',
                    'FIX: Version Consistency über alle Files',
                    'IMPROVED: CLAUDE.md komplett aktualisiert',
                    'IMPROVED: 88 API Endpoints dokumentiert (+27 neu)',
                  ],
                  isLatest: false,
                ),
                _buildVersionEntry(
                  'v1.0.83',
                  '03.02.2026',
                  [
                    'NEU: Log Upload System - Remote Debugging',
                    'FIX: Accept Button funktioniert (aus v1.0.82)',
                    'IMPROVED: Logs alle 30s auf Server',
                    'IMPROVED: Endpoint /api/logs/mitglieder_android.php',
                  ],
                  isLatest: false,
                ),
                _buildVersionEntry(
                  'v1.0.78',
                  '02.02.2026',
                  [
                    'SECURITY: Calendar Privacy - Nur eigene Termine mit Details sichtbar',
                    'SECURITY: Andere Termine als Beratung-Besetzt ohne vertrauliche Daten',
                    'FIX: myResponse-Check für Teilnahme-Erkennung',
                    'IMPROVED: Farbcodierung nur für eigene Termine',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.77',
                  '02.02.2026',
                  [
                    'IMPROVED: Extensive Logging für Voice Call Debugging',
                    'IMPROVED: Detaillierte Track Info Logs (local + remote)',
                    'IMPROVED: ICE Candidate Processing Logs',
                    'IMPROVED: Auto-Close Detection mit Stack Trace',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.76',
                  '02.02.2026',
                  [
                    'FIX: ICE Candidate Queuing - Race Condition behoben',
                    'FIX: Keine verlorenen ICE Candidates mehr bei Voice Calls',
                    'IMPROVED: WebRTC Connection Stability verbessert',
                    'IMPROVED: Queue-Mechanismus für verzögerte ICE Candidates',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.75',
                  '02.02.2026',
                  [
                    'NEU: Member Calendar View - Wochenansicht mit KW-Nummer',
                    'NEU: Ticket Badge System - Benachrichtigungszähler wie bei Chat',
                    'NEU: Click auf Termin zeigt Details-Dialog',
                    'FIX: WebSocket Server Syntax Error behoben',
                    'FIX: system_notification Handler hinzugefügt',
                    'IMPROVED: Farbcodierung nach Kategorie im Kalender',
                    'IMPROVED: Urlaub-Anzeige in rotem Hintergrund',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.74',
                  '28.01.2026',
                  [
                    'FIX: Background Service bleibt verbunden wenn App geschlossen',
                    'FIX: Push-Benachrichtigungen im Hintergrund funktionieren',
                    'NEU: Automatische WebSocket-Authentifizierung beim Server',
                    'NEU: Service-Neustart nach App-Swipe',
                    'IMPROVED: Keine Doppelverbindungen mehr beim Login',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.73',
                  '27.01.2026',
                  [
                    'NEU: Auto-Translation Integration - NLLB-200 3.3B Modell',
                    'NEU: Automatische Spracherkennung vom Gerät',
                    'NEU: Chat-Übersetzung in Echtzeit (Server-side)',
                    'NEU: Sprache wird bei Login/Register automatisch gespeichert',
                    'IMPROVED: 5 Sprachen unterstützt: DE, EN, RO, RU, UK',
                    'IMPROVED: Direkte Übersetzung ohne English-Pivot',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.72',
                  '27.01.2026',
                  [
                    'NEU: COMPLETE Multilingual Support - Dashboard, Tickets, Profile in 26 Sprachen',
                    'NEU: Meine Termine Dialog lokalisiert',
                    'NEU: Problem melden Dialog lokalisiert',
                    'NEU: Profil Dialog (Konto + Meine Geräte) lokalisiert',
                    'IMPROVED: 75+ Translation Keys hinzugefügt (statt nur 25)',
                    'IMPROVED: Alle Begrüßungen, Menüs, Formulare übersetzt',
                    'IMPROVED: Priority, Status, Messages lokalisiert',
                    'IMPROVED: Device Management komplett mehrsprachig',
                  ],
                  isLatest: false,
                ),
                _buildVersionEntry(
                  'v1.0.62',
                  '27.01.2026',
                  [
                    'NEU: Background Service - Persistent WebSocket în background',
                    'NEU: F-Droid Repository - Auto-updates alle 24 Stunden',
                    'NEU: Registration Device ID Limit - 1 account per device per MONTH',
                    'IMPROVED: Platform Detection - Separate Android/Windows versions',
                    'IMPROVED: Update Check - 24 Stunden interval (Battery optimization)',
                    'FIX: Device ID tracking für registration limits',
                    'FIX: Config.php registration functions mit device_id parameter',
                  ],
                  isLatest: false,
                ),
                _buildVersionEntry(
                  'v1.0.60',
                  '23.01.2026',
                  [
                    'NEU: Heartbeat Service - REAL-TIME last_seen actualizare pentru admin',
                    'NEU: API endpoint /api/auth/heartbeat.php - Update last_seen la 15 secunde',
                    'Fix KRITISCH: Support status arăta "Zuletzt aktiv vor 23 Minuten" când era activ',
                    'Implementare: HeartbeatService în MitgliedDashboard (start/stop)',
                    'Implementare: sendHeartbeat() în ApiService',
                    'Sincronizare perfectă: Acum Vorsitzer vede membri online ȘI invers!',
                    'REAL-TIME: Heartbeat la fiecare 15 secunde (consistent cu diagnostic)',
                  ],
                  isLatest: false,
                ),
                _buildVersionEntry(
                  'v1.0.59',
                  '23.01.2026',
                  [
                    'NEU: Support Online Status - REAL-TIME indicator în chat header',
                    'NEU: "Zuletzt aktiv vor X" - Arată când a fost activ support-ul ultima dată',
                    'NEU: API endpoint /api/chat/support_status.php - Verifică admin online',
                    'Fix KRITISCH: Widget lifecycle issue în live_chat_dialog.dart',
                    'Fix KRITISCH: Voice call callbacks mounted check (_endCallCleanup)',
                    'Fix: Stream listeners verifică mounted state înainte de setState',
                    'Fix: _handleCallAnswer, _handleCallRejected, _handleCallEnded mounted',
                    'Fix: _startCall, _acceptCall error handling cu mounted check',
                    'REAL-TIME: Support status polling la fiecare 5 secunde (nu 30!)',
                    'REAL-TIME: Online threshold 30 secunde (nu 5 minute!)',
                    'Improved: Chat header arată nume admin online',
                  ],
                  isLatest: false,
                ),
                _buildVersionEntry(
                  'v1.0.58',
                  '23.01.2026',
                  [
                    'Fix KRITISCH: Role-based authentication - separate endpoints',
                    'Mitglied App verwendet login_mitglied.php (nur rol: mitglied)',
                    'Vorsitzer App verwendet login_vorsitzer.php (nur admin roles)',
                    'Fix: Auto-redirect nach Registrierung mit pre-filled Mitgliedernummer',
                    'Fix: Backend error message handling (akzeptiert "message" und "error")',
                    'Fix: Widget mount issue - LoginScreen managed redirect timing',
                    'Improved: Enhanced logging für Registration/Login flow',
                    'TabController: Verwendet index statt animateTo für instant redirect',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.57',
                  '23.01.2026',
                  [
                    'NEU: Terminverwaltung - Weekly Calendar mit KW Navigation',
                    'NEU: Urlaub Management - Vacation periods mit smart edit',
                    'NEU: Click auf Mitglieder - Edit Dialog mit Device/Session Management',
                    'NEU: Max 3 Devices - Device selection bei Login',
                    'NEU: Member Profile - "Meine Geräte" Tab mit self-service logout',
                    'Refactoring: Code separation (terminverwaltung_screen.dart separat)',
                    'Dashboard cleaned: 5400 → 4391 Zeilen',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.56',
                  '22.01.2026',
                  [
                    'Fix KRITISCH: Duplicate call_offer handling',
                    'Verhindert auto-reject von eigenen Anrufen',
                    'Verbesserte Stabilität bei WebRTC Verbindungen',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.55',
                  '22.01.2026',
                  [
                    'Fix: desktop_audio_capture_plugin.dll im Installer hinzugefügt',
                    'Voice Activity Detection funktioniert jetzt korrekt',
                    'DLL-Dokumentation in CLAUDE.md aktualisiert',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.54',
                  '22.01.2026',
                  [
                    'Voice Activity: REAL Audio Level Detection (desktop_audio_capture)',
                    'Bars zeigen jetzt echte Mikrofon-Lautstärke (-60dB bis 0dB)',
                    'Fallback zu animierten Bars wenn Audio Capture fehlschlägt',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.53',
                  '22.01.2026',
                  [
                    'UI: Persistent Fehlermeldung für kritische Fehler (15 Sekunden)',
                    'NO_MICROPHONE Error zeigt jetzt Mic-Off Icon mit OK Button',
                    'SnackBar floating position für bessere Sichtbarkeit',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.52',
                  '22.01.2026',
                  [
                    'Fix KRITISCH: call_end Notification bei FAILED/DISCONNECTED',
                    'Fix COTURN: Private IPs erlaubt für NAT Traversal (403 Forbidden behoben)',
                    'TURN Server kann jetzt korrekt zwischen NAT Clients relay',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.51',
                  '22.01.2026',
                  [
                    'Voice Activity Indicator: Animierte Balken zeigen Sprachaktivität',
                    'Debug: Detaillierte Audio Device Enumeration Logs',
                    'UI: Visuelles Feedback wenn gesprochen wird (5 animierte Balken)',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.50',
                  '22.01.2026',
                  [
                    'Fix: Incoming Call Dialog Buttons verwenden jetzt GestureDetector',
                    'Fix: Auto-Reject Timeout erhöht von 30s auf 5 Minuten',
                    'UI: Reaktionsschnellere Accept/Reject Buttons',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.49',
                  '22.01.2026',
                  [
                    'UI: Call Overlay verschoben nach unten (über Footer)',
                    'Bessere Sichtbarkeit während des Anrufs',
                    'Bestätigung: TURN Server funktioniert (relay candidates generiert)',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.48',
                  '22.01.2026',
                  [
                    'Voice Call: TURN Server (coturn) für NAT Traversal installiert',
                    'WebRTC funktioniert jetzt durch Firewalls und NAT',
                    'Server: turn://icd360sev.icd360s.de:3478 (UDP + TLS)',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.47',
                  '22.01.2026',
                  [
                    'Fix: Voice Call Overlay bleibt jetzt sichtbar (onTrack workaround)',
                    'Workaround für flutter_webrtc Bug #1668 - onConnectionState callback',
                    'Remote Stream Empfang triggert automatisch inCall State',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.46',
                  '22.01.2026',
                  [
                    'Fix: Auto-Start nach Silent Update verwendet jetzt skipifnotsilent',
                    'Installer: Korrekte Inno Setup Flags für Silent Mode',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.45',
                  '22.01.2026',
                  [
                    'Fix KRITISCH: handleIncomingCall() vor acceptCall() in pendingCall flow',
                    'Voice Calls funktionieren jetzt korrekt - Overlay bleibt sichtbar',
                    'CallState.ringing wird korrekt gesetzt vor Accept',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.44',
                  '22.01.2026',
                  [
                    'Debug: Detaillierte Logs für WebRTC Connection States',
                    'Debug: ICE Gathering, ICE Connection, Signaling State Logs',
                    'Debug: Lost ICE Candidates werden jetzt geloggt',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.43',
                  '22.01.2026',
                  [
                    'Fix: App startet jetzt automatisch nach Silent Update',
                    'Auto-Update: Separate Flags für interaktive und stille Installation',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.42',
                  '22.01.2026',
                  [
                    'Fix: UI aktualisiert sich jetzt korrekt bei Call State Änderungen',
                    'Erweiterte Logs in VoiceCallService für Debugging',
                    'Stream Listeners für reaktive UI Updates',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.41',
                  '22.01.2026',
                  [
                    'Refactoring: Voice Call verwendet jetzt VoiceCallService',
                    'Code-Qualität: 401 Zeilen duplizierter WebRTC-Code entfernt',
                    'Architektur: Separation of Concerns - UI und WebRTC Logic getrennt',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.40',
                  '22.01.2026',
                  [
                    'Fix: Benutzerfreundliche Fehlermeldung wenn kein Mikrofon gefunden',
                    'Voice Call erkennt fehlendes Mikrofon vor dem Anruf',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.39',
                  '22.01.2026',
                  [
                    'Fix: Mitglieder können Anrufe vom Vorsitzer empfangen',
                    'Fix: getUserMedia UTF-8 Encoding Fehler',
                    'Verbesserte Audio-Initialisierung für Voice Calls',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.38',
                  '22.01.2026',
                  [
                    'Voice Call: Logging für Debugging',
                    'Vorsitzer kann Mitglieder anrufen',
                    'Incoming Call Dialog bei geschlossenem Chat',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.37',
                  '22.01.2026',
                  [
                    'Automatische Wiederherstellung bei Startfehlern',
                    'Launcher erkennt Crashes und bietet Rollback an',
                    'Backup der vorherigen Version vor jedem Update',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.36',
                  '22.01.2026',
                  [
                    'Backup-System im Installer',
                    'Start Menu: Vorherige Version wiederherstellen',
                    'Server-seitiger Fallback (stable version)',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.35',
                  '22.01.2026',
                  [
                    'Fehlerbehebung: url_launcher DLL im Installer',
                    'DLL-Dokumentation in CLAUDE.md aktualisiert',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.34',
                  '22.01.2026',
                  [
                    'Chat: Datei-Upload Funktion',
                    'WhatsApp-style Lesebestätigungen',
                    'Blaue Häkchen für gelesene Nachrichten',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.33',
                  '21.01.2026',
                  [
                    'Sicherheit: Dynamische Device Keys',
                    'Kein hardcodierter API Key mehr',
                    'Jede Installation erhält eindeutigen Schlüssel',
                    'Notardaten können bearbeitet werden',
                    'device_info_plus: 11.5.0 → 12.3.0',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.32',
                  '21.01.2026',
                  [
                    'Notar: Rechnungen, Besuche, Dokumente, Zahlungen',
                    'Daten werden in Datenbank gespeichert',
                    'Dialogfenster zum Hinzufügen neuer Einträge',
                    'API-Endpoints für alle Notar-Daten',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.31',
                  '21.01.2026',
                  [
                    'Notar: Daten aus Datenbank',
                    'Partner: Sub-Karten (Post, Hetzner, INWX, Banken)',
                    'Vorstand: Live-Daten aus Mitgliederliste',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.30',
                  '21.01.2026',
                  [
                    'Vereinverwaltung: 5 Karten Layout',
                    'Behörden, Partner, Notar, Finanzen, Vorstand',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.29',
                  '21.01.2026',
                  [
                    'Footer: Responsive Layout für kleine Fenster',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.28',
                  '21.01.2026',
                  [
                    'Registrierung: Nur Buchstaben und Bindestrich im Namen',
                    'Wiederherstellungscode: Nur Ziffern erlaubt',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.27',
                  '21.01.2026',
                  [
                    'Redundante Versionsanzeige im Sidebar entfernt',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.26',
                  '21.01.2026',
                  [
                    'Anmeldeoptionen standardmäßig aktiviert',
                    'Mit Windows starten standardmäßig aktiviert',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.25',
                  '21.01.2026',
                  [
                    'Task Manager zeigt ICD360S e.V.',
                    'Prozessname verbessert',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.24',
                  '21.01.2026',
                  [
                    'Erweiterte Ticket-Status',
                    'Warten auf Mitglied/Mitarbeiter/Behörde',
                    'Erledigt statt Geschlossen',
                    'Website-Link im Footer',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.23',
                  '21.01.2026',
                  [
                    'Admin Ticketverwaltung',
                    'Tickets übernehmen, schließen, wiedereröffnen',
                    'Filterung nach Status',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.22',
                  '21.01.2026',
                  [
                    'Ticket-System implementiert',
                    'Tickets erstellen und verwalten',
                    'Prioritäten: Niedrig, Mittel, Hoch',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.21',
                  '21.01.2026',
                  [
                    'Sidebar Version entfernt (redundant mit Footer)',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.20',
                  '21.01.2026',
                  [
                    'Automatische Updates - Installation im Hintergrund',
                    'App wird nach Update automatisch neu gestartet',
                    'Keine manuelle Installation mehr erforderlich',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.19',
                  '21.01.2026',
                  [
                    'Trial-Periode: 30 Tage für neue Konten',
                    'Warnbanner für unbestätigte Konten',
                    'Automatische Kontosperrung nach 30 Tagen',
                    'WebSocket Datenbankverbindung verbessert',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.18',
                  '21.01.2026',
                  [
                    'Persönliche Daten - Validierung verbessert',
                    'Vorname/Nachname: nur Buchstaben und Bindestrich',
                    'PLZ: nur Ziffern (max. 6)',
                    'Straße und Hausnummer getrennt',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.17',
                  '21.01.2026',
                  [
                    'Admin Dashboard Sidebar - neue Navigation',
                    'Mitgliederverwaltung, Ticketverwaltung, Terminverwaltung, Vereinverwaltung',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.16',
                  '21.01.2026',
                  [
                    'Mit Windows starten - App startet automatisch beim Login',
                    'Kombiniert mit Auto-Login für Echtzeit-Benachrichtigungen',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.15',
                  '21.01.2026',
                  [
                    'Fix: Doppelte Nachrichten im Chat behoben',
                    'Eigene Nachrichten werden nicht mehr dupliziert',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.14',
                  '21.01.2026',
                  [
                    'Fix: Hintergrund-Benachrichtigungen funktionieren jetzt',
                    'Auto-Join Konversationen bei Login',
                    'Chat bleibt verbunden auch wenn Dialog geschlossen',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.13',
                  '21.01.2026',
                  [
                    'Chat Badge - Anzeige ungelesener Nachrichten',
                    'Benachrichtigungen auch wenn Chat geschlossen',
                    'Dashboard Message Listener für Hintergrund-Updates',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.12',
                  '21.01.2026',
                  [
                    'System Tray - App läuft im Hintergrund',
                    'Minimieren zu Tray statt Schließen',
                    'Benachrichtigungen auch ohne offenen Chat',
                    'WebSocket Verbindung nach Login aktiv',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.11',
                  '21.01.2026',
                  [
                    'Update-Prüfung Button im Footer',
                    'Automatische Update-Prüfung alle 5 Minuten',
                    'Push Update nach Login verschoben',
                    'Logger Push nach Login zum Server',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.10',
                  '20.01.2026',
                  [
                    'Fix WebSocket SSL-Zertifikatsfehler',
                    'Let\'s Encrypt Zertifikate werden akzeptiert',
                    'Live Chat WebSocket Verbindung funktioniert',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.9',
                  '20.01.2026',
                  [
                    'Fix AssertionError Race Condition beim Dialog schließen',
                    'Disposal-Flag verhindert setState nach dispose()',
                    'SafeSetState Wrapper für alle State-Updates',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.8',
                  '20.01.2026',
                  [
                    'Fix AssertionError beim Schließen von Live Chat',
                    'Mounted checks in Timer-Callbacks',
                    'Mounted checks in WebRTC-Callbacks',
                    'Mounted checks nach async Operationen',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.7',
                  '20.01.2026',
                  [
                    'Debug Console mit Device ID',
                    'Version im Footer klickbar (Changelog)',
                    'Verbesserte Stabilität bei Chat-Dialogen',
                    'Mehr mounted checks für async Operationen',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.5',
                  '20.01.2026',
                  [
                    'Fix mounted checks in Chat-Dialogen',
                    'Registrierung: M + 5 zufällige Ziffern',
                    'Debug Logger hinzugefügt',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.4',
                  '19.01.2026',
                  [
                    'Live Chat mit WebSocket',
                    'Voice Call Unterstützung (WebRTC)',
                    'Push Benachrichtigungen',
                  ],
                ),
                _buildVersionEntry(
                  'v1.0.0',
                  '18.01.2026',
                  [
                    'Erste Version',
                    'Login & Registrierung',
                    'Mitglieder Dashboard',
                    'Profil Verwaltung',
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.close),
          ),
        ],
      ),
    );
  }

  Widget _buildVersionEntry(String version, String date, List<String> changes, {bool isLatest = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isLatest ? Colors.blue.shade50 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: isLatest ? Border.all(color: Colors.blue.shade200) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                version,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isLatest ? Colors.blue.shade700 : Colors.black87,
                ),
              ),
              if (isLatest) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Aktuell',
                    style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              const Spacer(),
              Text(
                date,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...changes.map((change) => Padding(
            padding: const EdgeInsets.only(left: 8, top: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• ', style: TextStyle(color: Colors.grey.shade600)),
                Expanded(
                  child: Text(
                    change,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textColor = widget.darkMode ? Colors.grey.shade400 : Colors.grey.shade600;
    final dividerColor = widget.darkMode ? Colors.grey.shade600 : Colors.grey.shade400;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: widget.darkMode ? const Color(0xFF1a1a2e) : Colors.grey.shade100,
        border: Border(
          top: BorderSide(
            color: widget.darkMode ? Colors.grey.shade800 : Colors.grey.shade300,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Line 1: Copyright + Version
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '© 2025-${DateTime.now().year} ICD360S e.V',
                style: TextStyle(
                  color: textColor,
                  fontSize: 11,
                ),
              ),
              _buildDivider(dividerColor),
              InkWell(
                onTap: () => _showChangelog(context),
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Text(
                    'v$appVersion',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 11,
                      decoration: TextDecoration.underline,
                      decorationColor: textColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Line 2: Links
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLink(context, 'Impressum', 'https://icd360s.de/impressum', textColor),
                _buildDivider(dividerColor),
                _buildLink(context, 'Datenschutz', 'https://icd360s.de/datenschutz', textColor),
                _buildDivider(dividerColor),
                _buildLink(context, 'Widerrufsrecht', 'https://icd360s.de/widerrufsrecht', textColor),
                _buildDivider(dividerColor),
                _buildLink(context, 'Kündigung', 'https://icd360s.de/kundigung', textColor),
                _buildDivider(dividerColor),
                _buildLink(context, 'Satzung', 'https://icd360s.de/satzung360s/', textColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLink(BuildContext context, String text, String url, Color textColor) {
    return InkWell(
      onTap: () {
        WebViewScreen.openUrl(context, text, url);
      },
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            decoration: TextDecoration.underline,
            decorationColor: textColor,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        '|',
        style: TextStyle(
          color: color,
          fontSize: 12,
        ),
      ),
    );
  }
}
