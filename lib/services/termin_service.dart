import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'api_service.dart';
import 'device_key_service.dart';
import 'http_client_factory.dart';
import '../utils/app_theme.dart';

/// Termin Model
class Termin {
  final int id;
  final String title;
  final String category; // vorstandssitzung, mitgliederversammlung, schulung, sonstiges
  final String description;
  final DateTime terminDate;
  final int durationMinutes;
  final String location;
  final int createdBy;
  final String? createdByName;
  final int? ticketId;
  final String? ticketSubject;
  // Vorstand-Flag: Anwesenheit dieses Teilnehmers ist erforderlich.
  // Spalte termine.braucht_mich (tinyint(1), default 0). Wird seit dem
  // Vorsitzer-Update zurückgegeben, der Member-Client zeigt einen Chip an.
  final bool brauchtMich;
  final String status; // scheduled, completed, cancelled
  final DateTime createdAt;
  final DateTime? updatedAt;

  // Termin-Nachbearbeitung — manuelles Status-Tracking nach dem Termin.
  // Wird vom Vorstand über /api/admin/termine_nachbearbeitung.php gesetzt;
  // Member sieht das Ergebnis read-only.
  final String feedbackStatus; // offen | wahrgenommen | nicht_wahrgenommen
  final bool feedbackErhalten;
  final String? nichtWahrgenommenGrund; // key aus Server-Allowlist
  final String? nichtWahrgenommenGrundText; // Freitext bei "sonstiges"
  final String? feedbackText;
  final DateTime? feedbackEingegangenAm;
  final int? markiertVonUserId;
  final DateTime? markiertAm;

  // Participant stats (când vine din admin list)
  final int? totalParticipants;
  final int? confirmedCount;
  final int? declinedCount;
  final int? pendingCount;
  final int? reschedulingCount;

  // My response (când vine din member list)
  final String? myResponse;
  final String? myReschedulingReason;
  final DateTime? myRespondedAt;

  // Participant (server-side aggregation: parent users see their children's
  // termine alongside their own. Server fills these in for every termin when
  // the response is aggregated; missing for legacy/non-aggregated endpoints.)
  final int? participantUserId;
  final String? participantVorname;
  final String? participantNachname;
  final String? participantMitgliedernummer;
  final String? participantRole;

  Termin({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.terminDate,
    required this.durationMinutes,
    required this.location,
    required this.createdBy,
    this.createdByName,
    this.ticketId,
    this.ticketSubject,
    this.brauchtMich = false,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.feedbackStatus = 'offen',
    this.feedbackErhalten = false,
    this.nichtWahrgenommenGrund,
    this.nichtWahrgenommenGrundText,
    this.feedbackText,
    this.feedbackEingegangenAm,
    this.markiertVonUserId,
    this.markiertAm,
    this.totalParticipants,
    this.confirmedCount,
    this.declinedCount,
    this.pendingCount,
    this.reschedulingCount,
    this.myResponse,
    this.myReschedulingReason,
    this.myRespondedAt,
    this.participantUserId,
    this.participantVorname,
    this.participantNachname,
    this.participantMitgliedernummer,
    this.participantRole,
  });

  factory Termin.fromJson(Map<String, dynamic> json) {
    return Termin(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      title: json['title'] ?? '',
      category: json['category'] ?? 'sonstiges',
      description: json['description'] ?? '',
      terminDate: DateTime.tryParse(json['termin_date']?.toString() ?? '') ?? DateTime.now(),
      durationMinutes: json['duration_minutes'] is int
          ? json['duration_minutes']
          : int.parse(json['duration_minutes']?.toString() ?? '60'),
      location: json['location'] ?? '',
      createdBy: json['created_by'] is int
          ? json['created_by']
          : int.parse(json['created_by'].toString()),
      createdByName: json['created_by_name'],
      ticketId: json['ticket_id'] != null
          ? (json['ticket_id'] is int ? json['ticket_id'] : int.parse(json['ticket_id'].toString()))
          : null,
      ticketSubject: json['ticket_subject'],
      brauchtMich: json['braucht_mich'] == 1
          || json['braucht_mich'] == '1'
          || json['braucht_mich'] == true,
      status: json['status'] ?? 'scheduled',
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at'].toString()) : null,
      feedbackStatus: (json['feedback_status'] ?? 'offen').toString(),
      feedbackErhalten: json['feedback_erhalten'] == 1
          || json['feedback_erhalten'] == '1'
          || json['feedback_erhalten'] == true,
      nichtWahrgenommenGrund: json['nicht_wahrgenommen_grund']?.toString(),
      nichtWahrgenommenGrundText: json['nicht_wahrgenommen_grund_text']?.toString(),
      feedbackText: json['feedback_text']?.toString(),
      feedbackEingegangenAm: (json['feedback_eingegangen_am'] != null
              && json['feedback_eingegangen_am'].toString().isNotEmpty)
          ? DateTime.tryParse(json['feedback_eingegangen_am'].toString())
          : null,
      markiertVonUserId: json['markiert_von_user_id'] == null
          ? null
          : (json['markiert_von_user_id'] is int
              ? json['markiert_von_user_id'] as int
              : int.tryParse(json['markiert_von_user_id'].toString())),
      markiertAm: (json['markiert_am'] != null
              && json['markiert_am'].toString().isNotEmpty)
          ? DateTime.tryParse(json['markiert_am'].toString())
          : null,
      totalParticipants: json['total_participants'] != null
          ? (json['total_participants'] is int
              ? json['total_participants']
              : int.parse(json['total_participants'].toString()))
          : null,
      confirmedCount: json['confirmed_count'] != null
          ? (json['confirmed_count'] is int
              ? json['confirmed_count']
              : int.parse(json['confirmed_count'].toString()))
          : null,
      declinedCount: json['declined_count'] != null
          ? (json['declined_count'] is int
              ? json['declined_count']
              : int.parse(json['declined_count'].toString()))
          : null,
      pendingCount: json['pending_count'] != null
          ? (json['pending_count'] is int
              ? json['pending_count']
              : int.parse(json['pending_count'].toString()))
          : null,
      reschedulingCount: json['rescheduling_count'] != null
          ? (json['rescheduling_count'] is int
              ? json['rescheduling_count']
              : int.parse(json['rescheduling_count'].toString()))
          : null,
      myResponse: json['response'],
      myReschedulingReason: json['rescheduling_reason'],
      myRespondedAt:
          json['responded_at'] != null ? DateTime.tryParse(json['responded_at'].toString()) : null,
      participantUserId: json['participant_user_id'] == null
          ? null
          : (json['participant_user_id'] is int
              ? json['participant_user_id'] as int
              : int.tryParse(json['participant_user_id'].toString())),
      participantVorname: json['participant_vorname'] as String?,
      participantNachname: json['participant_nachname'] as String?,
      participantMitgliedernummer: json['participant_mitgliedernummer'] as String?,
      participantRole: json['participant_role'] as String?,
    );
  }

  /// True if this termin belongs to a Jugendmitglied participant (a child
  /// the current parent user has authority over). Useful for filtering /
  /// labelling.
  bool get isKindTermin => participantRole == 'jugendmitglied';

  /// Returns the display label for the "kind badge" rendered above the title,
  /// or null if no badge should be shown (i.e. this termin is the user's own).
  ///
  /// Logic:
  ///   - If the server did not aggregate participant info (legacy endpoint),
  ///     [participantMitgliedernummer] is null -> no badge.
  ///   - If the participant is the user themselves, no badge.
  ///   - Otherwise return the participant's full name; fall back to their
  ///     Mitgliedernummer when the name is missing.
  String? forKindBadge(String selfMitgliedernummer) {
    final theirNumber = participantMitgliedernummer;
    if (theirNumber == null || theirNumber.isEmpty) return null;
    if (theirNumber == selfMitgliedernummer) return null;

    final first = participantVorname?.trim() ?? '';
    final last = participantNachname?.trim() ?? '';
    final fullName = '$first $last'.trim();
    if (fullName.isNotEmpty) return fullName;
    return theirNumber;
  }

  String get categoryDisplay {
    switch (category) {
      case 'vorstandssitzung':
        return 'Vorstandssitzung';
      case 'mitgliederversammlung':
        return 'Mitgliederversammlung';
      case 'schulung':
        return 'Schulung';
      case 'sonstiges':
        return 'Sonstiges';
      default:
        return category;
    }
  }

  /// Takes the context rather than being a getter: the status palette differs
  /// between the light and dark themes, so the answer depends on which one is
  /// live at the moment the chip is painted.
  Color categoryColor(BuildContext context) {
    switch (category) {
      case 'vorstandssitzung':
        return Colors.purple;
      case 'mitgliederversammlung':
        return context.colors.infoFg;
      case 'schulung':
        return context.colors.successFg;
      case 'sonstiges':
        return context.colors.warningFg;
      default:
        return context.colors.textSecondary;
    }
  }

  DateTime get terminEndTime {
    return terminDate.add(Duration(minutes: durationMinutes));
  }

  bool get isUpcoming => terminDate.isAfter(DateTime.now());
  bool get isPast => terminDate.isBefore(DateTime.now());
}

/// Termin Participant Model
class TerminParticipant {
  final int id;
  final int userId;
  final String userName;
  final String mitgliedernummer;
  final String response; // pending, confirmed, declined, rescheduling
  final String? reschedulingReason;
  final DateTime? respondedAt;

  TerminParticipant({
    required this.id,
    required this.userId,
    required this.userName,
    required this.mitgliedernummer,
    required this.response,
    this.reschedulingReason,
    this.respondedAt,
  });

  factory TerminParticipant.fromJson(Map<String, dynamic> json) {
    return TerminParticipant(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      userId: json['user_id'] is int ? json['user_id'] : int.parse(json['user_id'].toString()),
      userName: json['user_name'] ?? '',
      mitgliedernummer: json['mitgliedernummer'] ?? '',
      response: json['response'] ?? 'pending',
      reschedulingReason: json['rescheduling_reason'],
      respondedAt:
          json['responded_at'] != null ? DateTime.tryParse(json['responded_at'].toString()) : null,
    );
  }

  String get responseDisplay {
    switch (response) {
      case 'confirmed':
        return 'Bestätigt';
      case 'declined':
        return 'Abgelehnt';
      case 'pending':
        return 'Ausstehend';
      case 'rescheduling':
        return 'Verschiebung';
      default:
        return response;
    }
  }

  /// See [Termin.categoryColor] for why this takes a context.
  Color responseColor(BuildContext context) {
    switch (response) {
      case 'confirmed':
        return context.colors.successFg;
      case 'declined':
        return context.colors.dangerFg;
      case 'pending':
        return context.colors.warningFg;
      case 'rescheduling':
        return context.colors.warningFg;
      default:
        return context.colors.textSecondary;
    }
  }
}

/// Urlaub (Vacation) Model
class Urlaub {
  final int id;
  final DateTime startDate;
  final DateTime endDate;
  final String description;

  Urlaub({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.description,
  });

  factory Urlaub.fromJson(Map<String, dynamic> json) {
    return Urlaub(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '') ?? 0,
      startDate: DateTime.tryParse(json['start_date']?.toString() ?? '') ?? DateTime.now(),
      endDate: DateTime.tryParse(json['end_date']?.toString() ?? '') ?? DateTime.now(),
      description: json['description'] as String? ?? 'Urlaub',
    );
  }
}

/// Calendar Data Model - response from calendar endpoint
class CalendarData {
  final List<Termin> termine;
  final List<Urlaub> urlaubPeriods;

  CalendarData({
    required this.termine,
    required this.urlaubPeriods,
  });

  factory CalendarData.fromJson(Map<String, dynamic> json) {
    return CalendarData(
      termine: (json['termine'] as List<dynamic>?)
              ?.map((t) => Termin.fromJson(t as Map<String, dynamic>))
              .toList() ??
          [],
      urlaubPeriods: (json['urlaub'] as List<dynamic>?)
              ?.map((u) => Urlaub.fromJson(u as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

/// Termin Service - handles termine API calls
class TerminService {
  static const String baseUrl = 'https://icd360sev.icd360s.de/api';

  late http.Client _client;
  final DeviceKeyService _deviceKeyService = DeviceKeyService();

  String? _token;

  // Singleton
  static final TerminService _instance = TerminService._internal();
  factory TerminService() => _instance;

  TerminService._internal() {
    _client = IOClient(HttpClientFactory.createPinnedHttpClient());
  }

  void setToken(String? token) {
    _token = token;
  }

  Map<String, String> get _headers {
    final deviceKey = _deviceKeyService.deviceKey;
    final authToken = _token ?? ApiService().token;
    return {
      'Content-Type': 'application/json',
      'User-Agent': 'ICD360S-Mitglied/1.0',
      if (authToken != null) 'Authorization': 'Bearer $authToken',
      if (deviceKey != null) 'X-Device-Key': deviceKey,
    };
  }

  /// Runs an HTTP request, and if the server responds 401, refreshes the
  /// access token once and retries. Without this, the 60-second calendar
  /// poll keeps reusing the expired token past the 1h JWT lifetime — the
  /// server then returns 401 + `{success:false, message:"Invalid or expired
  /// token"}`, the calendar parses `null` for the `termine` field, and the
  /// member sees an empty calendar with no error indication.
  Future<Map<String, dynamic>> _withAuthRetry(
    Future<http.Response> Function() request,
  ) async {
    http.Response response = await request().timeout(const Duration(seconds: 15));
    if (response.statusCode == 401 && ApiService().refreshToken != null) {
      final refreshed = await ApiService().refreshAccessToken();
      if (refreshed) {
        response = await request().timeout(const Duration(seconds: 15));
      }
    }
    try {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (_) {
      return {'success': false, 'message': 'Invalid server response'};
    }
  }

  // ========== ADMIN METHODS ==========

  /// Create termin (admin only)
  Future<Map<String, dynamic>> createTermin({
    required String title,
    required String category,
    required String description,
    required DateTime terminDate,
    required int durationMinutes,
    required String location,
    required List<int> participantIds,
    int? ticketId,
  }) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/admin/termine_create.php'),
      headers: _headers,
      body: jsonEncode({
        'title': title,
        'category': category,
        'description': description,
        'termin_date': terminDate.toIso8601String().substring(0, 19).replaceAll('T', ' '),
        'duration_minutes': durationMinutes,
        'location': location,
        'participant_ids': participantIds,
        if (ticketId != null) 'ticket_id': ticketId,
      }),
    );

    return jsonDecode(response.body);
  }

  /// Get all termine (admin only) with optional date range for weekly calendar
  Future<Map<String, dynamic>> getAllTermine({DateTime? from, DateTime? to}) async {
    String url = '$baseUrl/admin/termine_list.php';

    if (from != null && to != null) {
      final fromStr = from.toIso8601String().substring(0, 10);
      final toStr = to.toIso8601String().substring(0, 10);
      url += '?from=$fromStr&to=$toStr';
    }

    final response = await _client.get(
      Uri.parse(url),
      headers: _headers,
    );

    return jsonDecode(response.body);
  }

  /// Get termin details with participants (admin only)
  Future<Map<String, dynamic>> getTerminDetails(int terminId) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/admin/termine_details.php'),
      headers: _headers,
      body: jsonEncode({'termin_id': terminId}),
    );

    return jsonDecode(response.body);
  }

  /// Update termin (admin only)
  Future<Map<String, dynamic>> updateTermin({
    required int terminId,
    String? title,
    String? category,
    String? description,
    DateTime? terminDate,
    int? durationMinutes,
    String? location,
    List<int>? participantIds,
    int? ticketId,
  }) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/admin/termine_update.php'),
      headers: _headers,
      body: jsonEncode({
        'termin_id': terminId,
        if (title != null) 'title': title,
        if (category != null) 'category': category,
        if (description != null) 'description': description,
        if (terminDate != null)
          'termin_date': terminDate.toIso8601String().substring(0, 19).replaceAll('T', ' '),
        if (durationMinutes != null) 'duration_minutes': durationMinutes,
        if (location != null) 'location': location,
        if (participantIds != null) 'participant_ids': participantIds,
        if (ticketId != null) 'ticket_id': ticketId,
      }),
    );

    return jsonDecode(response.body);
  }

  /// Delete termin (admin only)
  Future<Map<String, dynamic>> deleteTermin(int terminId) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/admin/termine_delete.php'),
      headers: _headers,
      body: jsonEncode({'termin_id': terminId}),
    );

    return jsonDecode(response.body);
  }

  // ========== URLAUB METHODS (Admin) ==========

  /// Create urlaub period (admin only)
  Future<Map<String, dynamic>> createUrlaub({
    required DateTime startDate,
    required DateTime endDate,
    String beschreibung = 'Urlaub',
  }) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/admin/urlaub_create.php'),
      headers: _headers,
      body: jsonEncode({
        'start_date': startDate.toIso8601String().substring(0, 10),
        'end_date': endDate.toIso8601String().substring(0, 10),
        'beschreibung': beschreibung,
      }),
    );

    return jsonDecode(response.body);
  }

  /// Get urlaub periods (admin only)
  Future<Map<String, dynamic>> getUrlaub({DateTime? from, DateTime? to}) async {
    String url = '$baseUrl/admin/urlaub_list.php';

    if (from != null && to != null) {
      final fromStr = from.toIso8601String().substring(0, 10);
      final toStr = to.toIso8601String().substring(0, 10);
      url += '?from=$fromStr&to=$toStr';
    }

    final response = await _client.get(Uri.parse(url), headers: _headers);
    return jsonDecode(response.body);
  }

  /// Update urlaub period (admin only)
  Future<Map<String, dynamic>> updateUrlaub({
    required int urlaubId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/admin/urlaub_update.php'),
      headers: _headers,
      body: jsonEncode({
        'urlaub_id': urlaubId,
        'start_date': startDate.toIso8601String().substring(0, 10),
        'end_date': endDate.toIso8601String().substring(0, 10),
      }),
    );

    return jsonDecode(response.body);
  }

  /// Delete urlaub period (admin only)
  Future<Map<String, dynamic>> deleteUrlaub(int urlaubId) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/admin/urlaub_delete.php'),
      headers: _headers,
      body: jsonEncode({'urlaub_id': urlaubId}),
    );

    return jsonDecode(response.body);
  }

  // ========== MEMBER METHODS ==========

  /// Get my termine (member). Supports optional from/to range for weekly view
  /// (server endpoint extended 2026-05-20 with the vormund-kinder aggregation).
  Future<Map<String, dynamic>> getMyTermine({
    String filter = 'upcoming',
    DateTime? from,
    DateTime? to,
  }) async {
    final params = <String, String>{'filter': filter};
    if (from != null && to != null) {
      params['from'] = from.toIso8601String().substring(0, 10);
      params['to'] = to.toIso8601String().substring(0, 10);
    }
    final uri = Uri.parse('$baseUrl/termine/my_termine.php')
        .replace(queryParameters: params);
    return _withAuthRetry(() => _client.get(uri, headers: _headers));
  }

  /// Respond to termin (member)
  Future<Map<String, dynamic>> respondToTermin({
    required int terminId,
    required String response, // confirmed, declined, rescheduling
    String? reason,
  }) async {
    return _withAuthRetry(() => _client.post(
          Uri.parse('$baseUrl/termine/respond.php'),
          headers: _headers,
          body: jsonEncode({
            'termin_id': terminId,
            'response': response,
            if (reason != null) 'reason': reason,
          }),
        ));
  }

  /// Get calendar view for member (read-only)
  Future<CalendarData> getCalendarView({
    required String mitgliedernummer,
    required DateTime from,
    required DateTime to,
  }) async {
    final fromStr = '${from.year}-${from.month.toString().padLeft(2, '0')}-${from.day.toString().padLeft(2, '0')}';
    final toStr = '${to.year}-${to.month.toString().padLeft(2, '0')}-${to.day.toString().padLeft(2, '0')}';

    final uri = Uri.parse('$baseUrl/termine/calendar.php').replace(
      queryParameters: {
        'mitgliedernummer': mitgliedernummer,
        'from': fromStr,
        'to': toStr,
      },
    );

    http.Response res = await _client.get(uri, headers: _headers);
    if (res.statusCode == 401 && ApiService().refreshToken != null) {
      if (await ApiService().refreshAccessToken()) {
        res = await _client.get(uri, headers: _headers);
      }
    }

    if (res.statusCode != 200) {
      throw Exception('Failed to load calendar: ${res.statusCode}');
    }

    final data = jsonDecode(res.body);
    if (data['success'] != true) {
      throw Exception(data['error'] ?? 'Failed to load calendar');
    }

    return CalendarData.fromJson(data);
  }
}
