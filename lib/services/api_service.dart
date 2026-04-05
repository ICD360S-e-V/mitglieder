import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'background_service.dart';
import 'device_key_service.dart';
import 'http_client_factory.dart';
import 'logger_service.dart';
import 'secure_storage_helper.dart';

/// Supported languages for translation
const List<String> _supportedLanguages = ['de', 'en', 'ro', 'ru', 'uk', 'tr', 'ar', 'fr', 'es', 'it', 'pl', 'nl', 'pt', 'cs', 'sk', 'hu', 'bg', 'hr', 'sr', 'sl', 'el', 'da', 'sv', 'nb', 'fi', 'et', 'lt', 'lv'];

class ApiService {
  static const String baseUrl = 'https://icd360sev.icd360s.de/api';

  // Security: Legacy API Key removed - now uses DeviceKeyService only

  String? _token;
  String? _refreshToken;
  late http.Client _client;
  final DeviceKeyService _deviceKeyService = DeviceKeyService();
  final _secureStorage = createSecureStorage();

  // Singleton pattern
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal() {
    // Certificate pinning: only trusts Let's Encrypt (ISRG Root X1)
    _client = IOClient(HttpClientFactory.createPinnedHttpClient());
  }

  /// Inițializează API service - TREBUIE apelat la pornirea aplicației
  Future<bool> initialize() async {
    // Inițializează device key
    final deviceKeyInitialized = await _deviceKeyService.initialize();
    if (!deviceKeyInitialized) {
      return false;
    }
    // Încarcă token-urile
    await loadTokens();
    return true;
  }

  Future<void> loadTokens() async {
    // Security: Tokens now stored in SecureStorage (encrypted) instead of SharedPreferences
    _token = await _secureStorage.read(key: 'access_token');
    _refreshToken = await _secureStorage.read(key: 'refresh_token');
  }

  Future<void> saveTokens(String token, String refreshToken, {String? mitgliedernummer}) async {
    // Security: Tokens now stored in SecureStorage (encrypted)
    await _secureStorage.write(key: 'access_token', value: token);
    await _secureStorage.write(key: 'refresh_token', value: refreshToken);

    // Save mitgliedernummer to SharedPreferences (needed by BackgroundService for own-message detection)
    if (mitgliedernummer != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('mitgliedernummer', mitgliedernummer);
      // Send credentials to background service for WebSocket connection
      await BackgroundService.setCredentials(token, mitgliedernummer);
    }
    _token = token;
    _refreshToken = refreshToken;
  }

  Future<void> clearTokens() async {
    // Security: Clear tokens from SecureStorage
    await _secureStorage.delete(key: 'access_token');
    await _secureStorage.delete(key: 'refresh_token');

    // Clear mitgliedernummer from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('mitgliedernummer');

    // Clear credentials from background service
    await BackgroundService.clearCredentials();

    _token = null;
    _refreshToken = null;
  }

  bool get isLoggedIn => _token != null;
  String? get token => _token;
  String? get refreshToken => _refreshToken;

  /// Detectează limba dispozitivului și o mapează la limbile suportate
  /// Returnează: de, en, ro, ru, uk (default: de)
  String getDeviceLocale() {
    try {
      // Get device locale from Platform
      final String platformLocale = Platform.localeName; // e.g., "ro_RO", "de_DE", "en_US"

      // Also check Flutter's window locale as fallback
      final ui.Locale windowLocale = ui.PlatformDispatcher.instance.locale;

      // Extract language code (first 2 characters)
      String langCode = platformLocale.split('_').first.toLowerCase();

      // Fallback to window locale if platform locale is empty
      if (langCode.isEmpty) {
        langCode = windowLocale.languageCode.toLowerCase();
      }

      // Map to supported languages
      if (_supportedLanguages.contains(langCode)) {
        return langCode;
      }

      // Default to German if language not supported
      return 'de';
    } catch (e) {
      // Default to German on error
      return 'de';
    }
  }

  /// Headers pentru request-uri - folosește Device Key dinamic
  Map<String, String> get _headers {
    final deviceKey = _deviceKeyService.deviceKey;
    return {
      'Content-Type': 'application/json',
      'User-Agent': 'ICD360S-Mitglied/1.0',
      // Security: Only Device Key (Legacy API Key removed)
      if (deviceKey != null) 'X-Device-Key': deviceKey,
      if (_token != null) 'Authorization': 'Bearer $_token',
    };
  }

  // Login
  Future<Map<String, dynamic>> login(String mitgliedernummer, String password) async {
    final deviceKey = _deviceKeyService.deviceKey;
    final deviceLocale = getDeviceLocale(); // Auto-detect device language

    final response = await _client.post(
      Uri.parse('$baseUrl/auth/login_mitglied.php'),
      headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'ICD360S-Mitglied/1.0',
        if (deviceKey != null) 'X-Device-Key': deviceKey,
      },
      body: jsonEncode({
        'mitgliedernummer': mitgliedernummer,
        'password': password,
        'device_locale': deviceLocale, // Send device language for auto-translation
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['success'] == true) {
      await saveTokens(data['token'], data['refresh_token'], mitgliedernummer: mitgliedernummer);
    }

    return data;
  }

  // Logout a specific device (before login, for max devices scenario)
  Future<Map<String, dynamic>> logoutDevice(String mitgliedernummer, String password, int sessionId) async {
    final deviceKey = _deviceKeyService.deviceKey;
    final response = await _client.post(
      Uri.parse('$baseUrl/auth/logout_device.php'),
      headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'ICD360S-Mitglied/1.0',
        if (deviceKey != null) 'X-Device-Key': deviceKey,
      },
      body: jsonEncode({
        'mitgliedernummer': mitgliedernummer,
        'password': password,
        'session_id': sessionId,
      }),
    );

    return jsonDecode(response.body);
  }

  // Get all users (admin only)
  Future<Map<String, dynamic>> getUsers() async {
    final response = await _client.get(
      Uri.parse('$baseUrl/admin/users.php'),
      headers: _headers,
    );

    return jsonDecode(response.body);
  }

  // Update user status
  Future<Map<String, dynamic>> updateUserStatus(int userId, String status) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/admin/user_status.php'),
      headers: _headers,
      body: jsonEncode({
        'user_id': userId,
        'status': status,
      }),
    );

    return jsonDecode(response.body);
  }

  // Delete user
  Future<Map<String, dynamic>> deleteUser(int userId) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/admin/user_delete.php'),
      headers: _headers,
      body: jsonEncode({
        'user_id': userId,
      }),
    );

    return jsonDecode(response.body);
  }

  // Get user details with sessions and devices (admin only)
  Future<Map<String, dynamic>> getUserDetails(int userId) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/admin/user_details.php'),
      headers: _headers,
      body: jsonEncode({
        'user_id': userId,
      }),
    );

    return jsonDecode(response.body);
  }

  // Update user (admin only)
  Future<Map<String, dynamic>> updateUser({
    required int userId,
    String? email,
    String? password,
    String? name,
    String? role,
  }) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/admin/user_update.php'),
      headers: _headers,
      body: jsonEncode({
        'user_id': userId,
        if (email != null) 'email': email,
        if (password != null) 'password': password,
        if (name != null) 'name': name,
        if (role != null) 'role': role,
      }),
    );

    return jsonDecode(response.body);
  }

  // Revoke session (admin only)
  Future<Map<String, dynamic>> revokeSession(int sessionId) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/admin/session_revoke.php'),
      headers: _headers,
      body: jsonEncode({
        'session_id': sessionId,
      }),
    );

    return jsonDecode(response.body);
  }

  // Get my sessions (member - self-service)
  Future<Map<String, dynamic>> getMySessions() async {
    final response = await _client.get(
      Uri.parse('$baseUrl/auth/my_sessions.php'),
      headers: _headers,
    );

    return jsonDecode(response.body);
  }

  // Get my registered devices (member - self-service)
  Future<Map<String, dynamic>> getMyDevices() async {
    final response = await _client.get(
      Uri.parse('$baseUrl/auth/my_devices.php'),
      headers: _headers,
    );

    return jsonDecode(response.body);
  }

  // Revoke my session (member - self-service)
  Future<Map<String, dynamic>> revokeMySession(int sessionId) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/auth/revoke_my_session.php'),
      headers: _headers,
      body: jsonEncode({
        'session_id': sessionId,
      }),
    );

    return jsonDecode(response.body);
  }

  // Change password
  Future<Map<String, dynamic>> changePassword(String mitgliedernummer, String currentPassword, String newPassword) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/auth/change_password.php'),
      headers: _headers,
      body: jsonEncode({
        'mitgliedernummer': mitgliedernummer,
        'current_password': currentPassword,
        'new_password': newPassword,
      }),
    );

    return jsonDecode(response.body);
  }

  // Change email
  Future<Map<String, dynamic>> changeEmail(String mitgliedernummer, String newEmail, String password) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/auth/change_email.php'),
      headers: _headers,
      body: jsonEncode({
        'mitgliedernummer': mitgliedernummer,
        'password': password,
        'new_email': newEmail,
      }),
    );

    return jsonDecode(response.body);
  }

  // Recover Password
  Future<Map<String, dynamic>> recoverPassword(String mitgliedernummer, String recoveryCode, String newPassword) async {
    final deviceKey = _deviceKeyService.deviceKey;
    final response = await _client.post(
      Uri.parse('$baseUrl/auth/recover.php'),
      headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'ICD360S-Mitglied/1.0',
        if (deviceKey != null) 'X-Device-Key': deviceKey,
      },
      body: jsonEncode({
        'mitgliedernummer': mitgliedernummer,
        'recovery_code': recoveryCode,
        'new_password': newPassword,
      }),
    );

    return jsonDecode(response.body);
  }

  // Register
  Future<Map<String, dynamic>> register(
    String email,
    String password,
    String name,
    String recoveryCode, {
    bool datenschutzAccepted = false,
    bool satzungAccepted = false,
    bool widerrufsbelehrungAccepted = false,
  }) async {
    final deviceKey = _deviceKeyService.deviceKey;
    final deviceId = LoggerService().deviceId;
    final deviceLocale = getDeviceLocale(); // Auto-detect device language

    final response = await _client.post(
      Uri.parse('$baseUrl/auth/register.php'),
      headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'ICD360S-Mitglied/1.0',
        if (deviceKey != null) 'X-Device-Key': deviceKey,
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        'name': name,
        'recovery_code': recoveryCode,
        'device_id': deviceId,
        'device_locale': deviceLocale, // Send device language for auto-translation
        'datenschutz_accepted': datenschutzAccepted,
        'satzung_accepted': satzungAccepted,
        'widerrufsbelehrung_accepted': widerrufsbelehrungAccepted,
      }),
    );

    return jsonDecode(response.body);
  }

  // Get Profile (personal data + beitrag status)
  Future<Map<String, dynamic>> getProfile(String mitgliedernummer) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/auth/get_profile.php'),
      headers: _headers,
      body: jsonEncode({
        'mitgliedernummer': mitgliedernummer,
      }),
    );

    return jsonDecode(response.body);
  }

  // Get Account Status (trial days remaining for 'neu' accounts)
  Future<Map<String, dynamic>> getAccountStatus(String mitgliedernummer) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/auth/account_status.php'),
      headers: _headers,
      body: jsonEncode({
        'mitgliedernummer': mitgliedernummer,
      }),
    );

    return jsonDecode(response.body);
  }

  // Update Profile (personal data)
  Future<Map<String, dynamic>> updateProfile({
    required String mitgliedernummer,
    String? vorname,
    String? nachname,
    String? strasse,
    String? hausnummer,
    String? plz,
    String? ort,
    String? telefonMobil,
    String? telefonFix,
  }) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/auth/update_profile.php'),
      headers: _headers,
      body: jsonEncode({
        'mitgliedernummer': mitgliedernummer,
        'vorname': vorname,
        'nachname': nachname,
        'strasse': strasse,
        'hausnummer': hausnummer,
        'plz': plz,
        'ort': ort,
        'telefon_mobil': telefonMobil,
        'telefon_fix': telefonFix,
      }),
    );

    return jsonDecode(response.body);
  }

  // Logout
  Future<void> logout() async {
    await clearTokens();
  }

  // ============= VERIFIZIERUNG API =============

  // Get my verification status (all 6 steps + personal data)
  Future<Map<String, dynamic>> getMyVerifizierung() async {
    final response = await _client.get(
      Uri.parse('$baseUrl/member/verifizierung_list.php'),
      headers: _headers,
    );
    return jsonDecode(response.body);
  }

  // Update personal data (Stufe 1)
  Future<Map<String, dynamic>> updatePersonalData({
    required String vorname,
    String? vorname2,
    required String nachname,
    required String strasse,
    required String hausnummer,
    required String plz,
    required String ort,
    String? bundesland,
    String? land,
    String? telefonMobil,
    String? telefonFix,
    String? geburtsdatum,
    String? geburtsort,
    String? staatsangehoerigkeit,
    String? muttersprache,
    String? mitgliedsart,
  }) async {
    final body = <String, dynamic>{
      'vorname': vorname,
      'vorname2': vorname2 ?? '',
      'nachname': nachname,
      'strasse': strasse,
      'hausnummer': hausnummer,
      'plz': plz,
      'ort': ort,
      'bundesland': bundesland ?? '',
      'land': land ?? '',
      'telefon_mobil': telefonMobil ?? '',
      'telefon_fix': telefonFix ?? '',
    };
    if (geburtsdatum != null && geburtsdatum.isNotEmpty) body['geburtsdatum'] = geburtsdatum;
    if (geburtsort != null && geburtsort.isNotEmpty) body['geburtsort'] = geburtsort;
    if (staatsangehoerigkeit != null && staatsangehoerigkeit.isNotEmpty) body['staatsangehoerigkeit'] = staatsangehoerigkeit;
    if (muttersprache != null && muttersprache.isNotEmpty) body['muttersprache'] = muttersprache;
    if (mitgliedsart != null && mitgliedsart.isNotEmpty) body['mitgliedsart'] = mitgliedsart;

    final response = await _client.post(
      Uri.parse('$baseUrl/member/update_personal_data.php'),
      headers: _headers,
      body: jsonEncode(body),
    );
    return jsonDecode(response.body);
  }

  // Update Finanzielle Situation (Stufe 3 - member verification)
  Future<Map<String, dynamic>> updateFinanzielleSituation({
    required String finanzielleSituation,
  }) async {
    final body = <String, dynamic>{'finanzielle_situation': finanzielleSituation};
    final response = await _client.post(
      Uri.parse('$baseUrl/member/update_finanzielle_situation.php'),
      headers: _headers,
      body: jsonEncode(body),
    );
    return jsonDecode(response.body);
  }

  // Update Mitgliedschaftsbeginn (Stufe 5)
  Future<Map<String, dynamic>> updateMitgliedschaftsbeginn({
    required String option,
    String? datum,
  }) async {
    final body = <String, dynamic>{'mitgliedschaftsbeginn_option': option};
    if (datum != null) body['mitgliedschaftsbeginn_datum'] = datum;
    final response = await _client.post(
      Uri.parse('$baseUrl/member/update_mitgliedschaftsbeginn.php'),
      headers: _headers,
      body: jsonEncode(body),
    );
    return jsonDecode(response.body);
  }

  // Upload Leistungsbescheid (Stufe 3 - finanzielle Situation)
  Future<Map<String, dynamic>> uploadLeistungsbescheid(String filePath) async {
    final uri = Uri.parse('$baseUrl/member/upload_leistungsbescheid.php');
    final request = http.MultipartRequest('POST', uri);

    request.headers['User-Agent'] = 'ICD360S-Mitglieder-Android/1.0';
    if (_token != null) request.headers['Authorization'] = 'Bearer $_token';

    final deviceKey = DeviceKeyService().deviceKey ?? '';
    if (deviceKey.isNotEmpty) request.headers['X-Device-Key'] = deviceKey;

    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    return jsonDecode(response.body);
  }

  // Update Zahlungsdaten (Stufe 4 - member verification)
  Future<Map<String, dynamic>> updateZahlungsdaten({
    required String zahlungsmethode,
    int? zahlungstag,
  }) async {
    final body = <String, dynamic>{'zahlungsmethode': zahlungsmethode};
    if (zahlungstag != null) body['zahlungstag'] = zahlungstag;
    final response = await _client.post(
      Uri.parse('$baseUrl/member/update_zahlungsdaten.php'),
      headers: _headers,
      body: jsonEncode(body),
    );
    return jsonDecode(response.body);
  }

  // Update Zahlungsmethode (legacy endpoint)
  Future<Map<String, dynamic>> updateZahlungsmethode(String zahlungsmethode, {int? zahlungstag}) async {
    final body = <String, dynamic>{'zahlungsmethode': zahlungsmethode};
    if (zahlungstag != null) body['zahlungstag'] = zahlungstag;
    final response = await _client.post(
      Uri.parse('$baseUrl/auth/update_zahlungsmethode.php'),
      headers: _headers,
      body: jsonEncode(body),
    );
    return jsonDecode(response.body);
  }

  // Accept document (Stufe 4/5/6)
  Future<Map<String, dynamic>> acceptDocument(int stufe) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/auth/accept_document.php'),
      headers: _headers,
      body: jsonEncode({'stufe': stufe}),
    );
    return jsonDecode(response.body);
  }

  // ============= VERWARNUNGEN API =============

  // Get my warnings (read-only)
  Future<Map<String, dynamic>> getMyVerwarnungen() async {
    final response = await _client.get(
      Uri.parse('$baseUrl/auth/my_verwarnungen.php'),
      headers: _headers,
    );
    return jsonDecode(response.body);
  }

  // ============= DOKUMENTE API =============

  // Get my documents (read-only)
  Future<Map<String, dynamic>> getMyDokumente() async {
    final response = await _client.get(
      Uri.parse('$baseUrl/auth/my_dokumente.php'),
      headers: _headers,
    );
    return jsonDecode(response.body);
  }

  // Download my document (Base64)
  Future<Map<String, dynamic>> downloadMyDokument(int id) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/auth/my_dokumente_download.php'),
      headers: _headers,
      body: jsonEncode({'id': id}),
    );
    return jsonDecode(response.body);
  }

  // ============= CHAT API =============

  // Start a new chat conversation
  Future<Map<String, dynamic>> startChat(String mitgliedernummer, {String subject = 'Support'}) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/chat/start.php'),
      headers: _headers,
      body: jsonEncode({
        'mitgliedernummer': mitgliedernummer,
        'subject': subject,
      }),
    );

    return jsonDecode(response.body);
  }

  // Send a chat message
  Future<Map<String, dynamic>> sendChatMessage(int conversationId, String mitgliedernummer, String message) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/chat/send.php'),
      headers: _headers,
      body: jsonEncode({
        'conversation_id': conversationId,
        'mitgliedernummer': mitgliedernummer,
        'message': message,
      }),
    );

    return jsonDecode(response.body);
  }

  // Get chat messages
  Future<Map<String, dynamic>> getChatMessages(int conversationId, String mitgliedernummer, {int? lastMessageId}) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/chat/messages.php'),
      headers: _headers,
      body: jsonEncode({
        'conversation_id': conversationId,
        'mitgliedernummer': mitgliedernummer,
        if (lastMessageId != null) 'last_message_id': lastMessageId,
      }),
    );

    return jsonDecode(response.body);
  }

  // Get support online status
  Future<Map<String, dynamic>> getSupportStatus() async {
    final response = await _client.post(
      Uri.parse('$baseUrl/chat/support_status.php'),
      headers: _headers,
      body: jsonEncode({}),
    );

    return jsonDecode(response.body);
  }

  // Send heartbeat to update last_seen (with optional network info)
  Future<Map<String, dynamic>> sendHeartbeat(
    String mitgliedernummer, {
    String? connectionType,
    int? latencyMs,
    String? networkQuality,
  }) async {
    final body = <String, dynamic>{
      'mitgliedernummer': mitgliedernummer,
    };
    if (connectionType != null) body['connection_type'] = connectionType;
    if (latencyMs != null) body['latency_ms'] = latencyMs;
    if (networkQuality != null) body['network_quality'] = networkQuality;

    final response = await _client.post(
      Uri.parse('$baseUrl/auth/heartbeat.php'),
      headers: _headers,
      body: jsonEncode(body),
    );

    return jsonDecode(response.body);
  }

  // Get all conversations (for admin) or user's conversations
  Future<Map<String, dynamic>> getChatConversations(String mitgliedernummer, {String? status}) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/chat/conversations.php'),
      headers: _headers,
      body: jsonEncode({
        'mitgliedernummer': mitgliedernummer,
        if (status != null) 'status': status,
      }),
    );

    return jsonDecode(response.body);
  }

  // Close a chat conversation (admin only)
  Future<Map<String, dynamic>> closeChatConversation(int conversationId, String mitgliedernummer) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/chat/close.php'),
      headers: _headers,
      body: jsonEncode({
        'conversation_id': conversationId,
        'mitgliedernummer': mitgliedernummer,
      }),
    );

    return jsonDecode(response.body);
  }

  // Upload chat attachments (max 10 files, 50MB total)
  Future<Map<String, dynamic>> uploadChatAttachments({
    required int conversationId,
    required String mitgliedernummer,
    required List<File> files,
    String? message,
  }) async {
    try {
      final deviceKey = _deviceKeyService.deviceKey;

      // Create multipart request
      final uri = Uri.parse('$baseUrl/chat/upload.php');
      final request = http.MultipartRequest('POST', uri);

      // Add headers
      request.headers['User-Agent'] = 'ICD360S-Mitglied/1.0';
      if (deviceKey != null) {
        request.headers['X-Device-Key'] = deviceKey;
      }
      // Security: Legacy API Key removed

      // Add fields
      request.fields['conversation_id'] = conversationId.toString();
      request.fields['mitgliedernummer'] = mitgliedernummer;
      if (message != null && message.isNotEmpty) {
        request.fields['message'] = message;
      }

      // Add files
      for (final file in files) {
        request.files.add(await http.MultipartFile.fromPath(
          'files[]',
          file.path,
        ));
      }

      // Send request using our custom IOClient
      final streamedResponse = await _client.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Upload failed: $e'};
    }
  }

  // Download chat attachment
  Future<Map<String, dynamic>> downloadChatAttachment({
    required int attachmentId,
    required String mitgliedernummer,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/chat/download.php'),
        headers: _headers,
        body: jsonEncode({
          'attachment_id': attachmentId,
          'mitgliedernummer': mitgliedernummer,
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Download failed: $e'};
    }
  }

  // Mark messages as read/delivered (WhatsApp-style read receipts)
  Future<Map<String, dynamic>> markMessagesRead({
    required int conversationId,
    required String mitgliedernummer,
    required String status, // 'delivered' or 'read'
    List<int>? messageIds,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/chat/mark_read.php'),
        headers: _headers,
        body: jsonEncode({
          'conversation_id': conversationId,
          'mitgliedernummer': mitgliedernummer,
          'status': status,
          if (messageIds != null) 'message_ids': messageIds,
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Mark read failed: $e'};
    }
  }

  // ============= VEREINVERWALTUNG API =============

  // Get Vereinverwaltung data (partners, notary, etc.)
  Future<Map<String, dynamic>> getVereinverwaltung({String? kategorie}) async {
    try {
      String url = '$baseUrl/vereinverwaltung/get.php';
      if (kategorie != null) {
        url += '?kategorie=$kategorie';
      }

      final response = await _client.get(
        Uri.parse(url),
        headers: _headers,
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Failed to load data: $e'};
    }
  }

  // Update Vereinverwaltung entry
  Future<Map<String, dynamic>> updateVereinverwaltung(Map<String, dynamic> data) async {
    try {
      final response = await _client.put(
        Uri.parse('$baseUrl/vereinverwaltung/update.php'),
        headers: _headers,
        body: jsonEncode(data),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Failed to update: $e'};
    }
  }

  // ============= NOTAR API =============

  // Get Notar Rechnungen (Invoices)
  Future<Map<String, dynamic>> getNotarRechnungen({int? notarId}) async {
    try {
      String url = '$baseUrl/notar/rechnungen.php';
      if (notarId != null) {
        url += '?notar_id=$notarId';
      }
      final response = await _client.get(Uri.parse(url), headers: _headers);
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Failed to load: $e'};
    }
  }

  // Create Notar Rechnung
  Future<Map<String, dynamic>> createNotarRechnung(Map<String, dynamic> data) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/notar/rechnungen.php'),
        headers: _headers,
        body: jsonEncode(data),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Failed to create: $e'};
    }
  }

  // Update Notar Rechnung
  Future<Map<String, dynamic>> updateNotarRechnung(Map<String, dynamic> data) async {
    try {
      final response = await _client.put(
        Uri.parse('$baseUrl/notar/rechnungen.php'),
        headers: _headers,
        body: jsonEncode(data),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Failed to update: $e'};
    }
  }

  // Delete Notar Rechnung
  Future<Map<String, dynamic>> deleteNotarRechnung(int id) async {
    try {
      final response = await _client.delete(
        Uri.parse('$baseUrl/notar/rechnungen.php?id=$id'),
        headers: _headers,
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Failed to delete: $e'};
    }
  }

  // Get Notar Besuche (Visits)
  Future<Map<String, dynamic>> getNotarBesuche({int? notarId}) async {
    try {
      String url = '$baseUrl/notar/besuche.php';
      if (notarId != null) {
        url += '?notar_id=$notarId';
      }
      final response = await _client.get(Uri.parse(url), headers: _headers);
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Failed to load: $e'};
    }
  }

  // Create Notar Besuch
  Future<Map<String, dynamic>> createNotarBesuch(Map<String, dynamic> data) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/notar/besuche.php'),
        headers: _headers,
        body: jsonEncode(data),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Failed to create: $e'};
    }
  }

  // Update Notar Besuch
  Future<Map<String, dynamic>> updateNotarBesuch(Map<String, dynamic> data) async {
    try {
      final response = await _client.put(
        Uri.parse('$baseUrl/notar/besuche.php'),
        headers: _headers,
        body: jsonEncode(data),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Failed to update: $e'};
    }
  }

  // Delete Notar Besuch
  Future<Map<String, dynamic>> deleteNotarBesuch(int id) async {
    try {
      final response = await _client.delete(
        Uri.parse('$baseUrl/notar/besuche.php?id=$id'),
        headers: _headers,
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Failed to delete: $e'};
    }
  }

  // Get Notar Dokumente
  Future<Map<String, dynamic>> getNotarDokumente({int? notarId, String? typ}) async {
    try {
      String url = '$baseUrl/notar/dokumente.php';
      List<String> params = [];
      if (notarId != null) params.add('notar_id=$notarId');
      if (typ != null) params.add('typ=$typ');
      if (params.isNotEmpty) url += '?${params.join('&')}';
      final response = await _client.get(Uri.parse(url), headers: _headers);
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Failed to load: $e'};
    }
  }

  // Create Notar Dokument
  Future<Map<String, dynamic>> createNotarDokument(Map<String, dynamic> data) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/notar/dokumente.php'),
        headers: _headers,
        body: jsonEncode(data),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Failed to create: $e'};
    }
  }

  // Update Notar Dokument
  Future<Map<String, dynamic>> updateNotarDokument(Map<String, dynamic> data) async {
    try {
      final response = await _client.put(
        Uri.parse('$baseUrl/notar/dokumente.php'),
        headers: _headers,
        body: jsonEncode(data),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Failed to update: $e'};
    }
  }

  // Delete Notar Dokument
  Future<Map<String, dynamic>> deleteNotarDokument(int id) async {
    try {
      final response = await _client.delete(
        Uri.parse('$baseUrl/notar/dokumente.php?id=$id'),
        headers: _headers,
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Failed to delete: $e'};
    }
  }

  // Get Notar Zahlungen (Payments)
  Future<Map<String, dynamic>> getNotarZahlungen({int? notarId, int? rechnungId}) async {
    try {
      String url = '$baseUrl/notar/zahlungen.php';
      List<String> params = [];
      if (notarId != null) params.add('notar_id=$notarId');
      if (rechnungId != null) params.add('rechnung_id=$rechnungId');
      if (params.isNotEmpty) url += '?${params.join('&')}';
      final response = await _client.get(Uri.parse(url), headers: _headers);
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Failed to load: $e'};
    }
  }

  // Create Notar Zahlung
  Future<Map<String, dynamic>> createNotarZahlung(Map<String, dynamic> data) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/notar/zahlungen.php'),
        headers: _headers,
        body: jsonEncode(data),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Failed to create: $e'};
    }
  }

  // Update Notar Zahlung
  Future<Map<String, dynamic>> updateNotarZahlung(Map<String, dynamic> data) async {
    try {
      final response = await _client.put(
        Uri.parse('$baseUrl/notar/zahlungen.php'),
        headers: _headers,
        body: jsonEncode(data),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Failed to update: $e'};
    }
  }

  // Delete Notar Zahlung
  Future<Map<String, dynamic>> deleteNotarZahlung(int id) async {
    try {
      final response = await _client.delete(
        Uri.parse('$baseUrl/notar/zahlungen.php?id=$id'),
        headers: _headers,
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Failed to delete: $e'};
    }
  }

  // ============= LOGS API =============

  // Push client logs to server
  Future<Map<String, dynamic>> pushLogs({
    required String mitgliedernummer,
    required String deviceId,
    required String machineName,
    required String platform,
    required List<Map<String, dynamic>> logs,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/logs/store.php'),
        headers: _headers,
        body: jsonEncode({
          'mitgliedernummer': mitgliedernummer,
          'device_id': deviceId,
          'machine_name': machineName,
          'platform': platform,
          'logs': logs,
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Push logs failed: $e'};
    }
  }

  // ============= CHANGELOG API =============

  /// Get changelog data for all versions
  /// Returns version history with detailed changes per category
  Future<Map<String, dynamic>> getChangelog() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/changelog_mitglieder.php'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'success': false,
          'error': 'Failed to load changelog: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Failed to load changelog: $e'};
    }
  }

  // ============= PASSWORDLESS LOGIN (APPROVAL) API =============

  /// Request passwordless login - sends approval request to admins
  Future<Map<String, dynamic>> requestLoginApproval(String mitgliedernummer) async {
    try {
      final deviceId = LoggerService().deviceId;
      final response = await _client.post(
        Uri.parse('$baseUrl/auth/login_request.php'),
        headers: _headers,
        body: jsonEncode({
          'mitgliedernummer': mitgliedernummer,
          'device_id': deviceId,
        }),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Request failed: $e'};
    }
  }

  /// Check approval status (polling)
  Future<Map<String, dynamic>> checkApprovalStatus(String requestToken) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/auth/check_approval.php'),
        headers: _headers,
        body: jsonEncode({'request_token': requestToken}),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Check failed: $e'};
    }
  }

  /// Login with 30-day approval token (auto-login)
  Future<Map<String, dynamic>> loginWithApproval(String mitgliedernummer, String approvalToken) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/auth/login_with_approval.php'),
        headers: _headers,
        body: jsonEncode({
          'mitgliedernummer': mitgliedernummer,
          'approval_token': approvalToken,
        }),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Approval login failed: $e'};
    }
  }
}
