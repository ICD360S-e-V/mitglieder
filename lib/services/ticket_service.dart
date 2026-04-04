import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'api_service.dart';
import 'device_key_service.dart';
import 'http_client_factory.dart';
import 'logger_service.dart';

/// Ticket Model
class Ticket {
  final int id;
  final String mitgliedernummer;
  final String subject;
  final String message;
  final String status;
  final String priority;
  final int? categoryId;
  final String? categoryName;
  final String? categoryIcon;
  final String? categoryColor;
  final String? adminName;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? closedAt;
  // Translation fields
  final String? originalSubject;
  final bool subjectIsTranslated;

  Ticket({
    required this.id,
    required this.mitgliedernummer,
    required this.subject,
    required this.message,
    required this.status,
    required this.priority,
    this.categoryId,
    this.categoryName,
    this.categoryIcon,
    this.categoryColor,
    this.adminName,
    required this.createdAt,
    this.updatedAt,
    this.closedAt,
    this.originalSubject,
    this.subjectIsTranslated = false,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: (json['id'] as int?) ?? 0,
      mitgliedernummer: (json['mitgliedernummer'] ?? '') as String,
      subject: (json['subject'] ?? '') as String,
      message: (json['message'] ?? '') as String,
      status: (json['status'] ?? 'open') as String,
      priority: (json['priority'] ?? 'medium') as String,
      categoryId: json['category_id'] as int?,
      categoryName: json['category_name'] as String?,
      categoryIcon: json['category_icon'] as String?,
      categoryColor: json['category_color'] as String?,
      adminName: json['admin_name'] as String?,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : null,
      closedAt: json['closed_at'] != null
          ? DateTime.tryParse(json['closed_at'] as String)
          : null,
      originalSubject: json['original_subject'] as String?,
      subjectIsTranslated: json['subject_is_translated'] == true,
    );
  }

  String get statusDisplay {
    switch (status) {
      case 'open':
        return 'Offen';
      case 'in_progress':
        return 'In Bearbeitung';
      case 'waiting_member':
        return 'Warten auf Mitglied';
      case 'waiting_staff':
        return 'Warten auf Mitarbeiter';
      case 'waiting_authority':
        return 'Warten auf Behörde';
      case 'done':
        return 'Erledigt';
      default:
        return status;
    }
  }

  String get priorityDisplay {
    switch (priority) {
      case 'high':
        return 'Hoch';
      case 'medium':
        return 'Mittel';
      case 'low':
        return 'Niedrig';
      default:
        return priority;
    }
  }
}

/// Ticket Category Model
class TicketCategory {
  final int id;
  final String name;
  final String icon;
  final String color;

  TicketCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  factory TicketCategory.fromJson(Map<String, dynamic> json) {
    return TicketCategory(
      id: json['id'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String,
      color: json['color'] as String,
    );
  }
}

/// Ticket Comment Model
class TicketComment {
  final int id;
  final int ticketId;
  final String userMitgliedernummer;
  final String userName;
  final String userRole;
  final String comment;
  final bool isInternal;
  final DateTime createdAt;
  // Translation fields
  final String? originalComment;
  final bool isTranslated;

  TicketComment({
    required this.id,
    required this.ticketId,
    required this.userMitgliedernummer,
    required this.userName,
    required this.userRole,
    required this.comment,
    required this.isInternal,
    required this.createdAt,
    this.originalComment,
    this.isTranslated = false,
  });

  factory TicketComment.fromJson(Map<String, dynamic> json) {
    return TicketComment(
      id: (json['id'] as int?) ?? 0,
      ticketId: (json['ticket_id'] as int?) ?? 0,
      userMitgliedernummer: (json['user_nummer'] ?? json['user_mitgliedernummer'] ?? '') as String,
      userName: (json['user_name'] ?? '') as String,
      userRole: (json['user_role'] ?? '') as String,
      comment: (json['comment'] ?? '') as String,
      isInternal: (json['is_internal'] ?? 0) == 1 || json['is_internal'] == true,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      originalComment: json['original_comment'] as String?,
      isTranslated: json['is_translated'] == true,
    );
  }
}

/// Ticket Translation Model (for ticket subject + message from comments endpoint)
class TicketTranslation {
  final String subject;
  final String? originalSubject;
  final bool subjectIsTranslated;
  final String message;
  final String? originalMessage;
  final bool messageIsTranslated;

  TicketTranslation({
    required this.subject,
    this.originalSubject,
    this.subjectIsTranslated = false,
    required this.message,
    this.originalMessage,
    this.messageIsTranslated = false,
  });

  factory TicketTranslation.fromJson(Map<String, dynamic> json) {
    return TicketTranslation(
      subject: json['subject'] ?? '',
      originalSubject: json['original_subject'] as String?,
      subjectIsTranslated: json['subject_is_translated'] == true,
      message: json['message'] ?? '',
      originalMessage: json['original_message'] as String?,
      messageIsTranslated: json['message_is_translated'] == true,
    );
  }
}

/// Ticket Attachment Model
class TicketAttachment {
  final int id;
  final int ticketId;
  final String originalFilename;
  final String storedFilename;
  final int filesize;
  final DateTime uploadedAt;

  TicketAttachment({
    required this.id,
    required this.ticketId,
    required this.originalFilename,
    required this.storedFilename,
    required this.filesize,
    required this.uploadedAt,
  });

  factory TicketAttachment.fromJson(Map<String, dynamic> json) {
    return TicketAttachment(
      id: (json['id'] as int?) ?? 0,
      ticketId: (json['ticket_id'] as int?) ?? 0,
      originalFilename: (json['original_filename'] ?? '') as String,
      storedFilename: (json['stored_filename'] ?? '') as String,
      filesize: (json['filesize'] as int?) ?? 0,
      uploadedAt: DateTime.tryParse(json['uploaded_at'] ?? '') ?? DateTime.now(),
    );
  }

  bool get isImage {
    final ext = originalFilename.toLowerCase().split('.').last;
    return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(ext);
  }

  String get filesizeDisplay {
    if (filesize < 1024) {
      return '${filesize}B';
    } else if (filesize < 1024 * 1024) {
      return '${(filesize / 1024).toStringAsFixed(1)}KB';
    } else {
      return '${(filesize / (1024 * 1024)).toStringAsFixed(1)}MB';
    }
  }
}

/// Ticket List Response
class TicketListResponse {
  final List<Ticket> tickets;
  final int total;

  TicketListResponse({
    required this.tickets,
    required this.total,
  });

  factory TicketListResponse.fromJson(Map<String, dynamic> json) {
    return TicketListResponse(
      tickets: (json['tickets'] as List)
          .map((t) => Ticket.fromJson(t as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
    );
  }
}

/// Ticket Comments Response
class TicketCommentsResponse {
  final List<TicketComment> comments;
  final List<TicketAttachment> attachments;
  final TicketTranslation? ticketTranslation;
  final String? userLanguage;

  TicketCommentsResponse({
    required this.comments,
    required this.attachments,
    this.ticketTranslation,
    this.userLanguage,
  });

  factory TicketCommentsResponse.fromJson(Map<String, dynamic> json) {
    return TicketCommentsResponse(
      comments: (json['comments'] as List)
          .map((c) => TicketComment.fromJson(c as Map<String, dynamic>))
          .toList(),
      attachments: (json['attachments'] as List)
          .map((a) => TicketAttachment.fromJson(a as Map<String, dynamic>))
          .toList(),
      ticketTranslation: json['ticket_translation'] != null
          ? TicketTranslation.fromJson(json['ticket_translation'] as Map<String, dynamic>)
          : null,
      userLanguage: json['user_language'] as String?,
    );
  }
}

/// Ticket Service
class TicketService {
  static final TicketService _instance = TicketService._internal();
  factory TicketService() => _instance;
  TicketService._internal() {
    _client = IOClient(HttpClientFactory.createPinnedHttpClient());
  }

  final String baseUrl = 'https://icd360sev.icd360s.de/api';
  final _apiService = ApiService();

  static String get _userAgent => 'ICD360S-Mitglieder-${Platform.operatingSystem}/1.0';
  final _deviceKeyService = DeviceKeyService();
  final _logger = LoggerService();

  late final http.Client _client;

  // ==================== CATEGORIES ====================

  /// Get available ticket categories
  Future<List<TicketCategory>> getCategories({
    required String mitgliedernummer,
  }) async {
    try {
      final token = _apiService.token;
      if (token == null) {
        _logger.log('TicketService.getCategories: No token');
        return [];
      }

      final deviceKey = _deviceKeyService.deviceKey ?? '';
      final headers = {
        'Authorization': 'Bearer $token',
        'X-Device-Key': deviceKey,
        'Content-Type': 'application/json',
        'User-Agent': _userAgent,
      };

      final url = Uri.parse('$baseUrl/tickets/categories.php');
      final response = await _client.get(url, headers: headers);

      _logger.log(
        'TicketService.getCategories: ${response.statusCode}',
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        if (data['success'] == true) {
          return (data['categories'] as List)
              .map((c) => TicketCategory.fromJson(c as Map<String, dynamic>))
              .toList();
        }
      }

      return [];
    } catch (e) {
      _logger.log('TicketService.getCategories error: $e');
      return [];
    }
  }

  // ==================== CREATE TICKET ====================

  /// Create a new ticket
  Future<Ticket?> createTicket({
    required String mitgliedernummer,
    required String subject,
    required String message,
    required String priority,
    int? categoryId,
  }) async {
    try {
      debugPrint('[TicketService] createTicket called for user: $mitgliedernummer');
      debugPrint('[TicketService] Subject: $subject, Priority: $priority');

      final token = _apiService.token;
      if (token == null) {
        debugPrint('[TicketService] ERROR: No token available!');
        _logger.log('TicketService.createTicket: No token');
        return null;
      }
      debugPrint('[TicketService] Token available: yes');

      final deviceKey = _deviceKeyService.deviceKey ?? '';
      debugPrint('[TicketService] Device key: ${deviceKey.isNotEmpty ? "present" : "MISSING"}');

      final headers = {
        'Authorization': 'Bearer $token',
        'X-Device-Key': deviceKey,
        'Content-Type': 'application/json',
        'User-Agent': _userAgent,
      };

      final url = Uri.parse('$baseUrl/tickets/create.php');
      final body = json.encode({
        'mitgliedernummer': mitgliedernummer,
        'subject': subject,
        'message': message,
        'priority': priority,
        if (categoryId != null) 'category_id': categoryId,
      });

      debugPrint('[TicketService] Sending POST to: $url');
      debugPrint('[TicketService] Request body: $body');

      final response = await _client.post(url, headers: headers, body: body);

      debugPrint('[TicketService] Response status: ${response.statusCode}');
      debugPrint('[TicketService] Response body: ${response.body}');

      _logger.log(
        'TicketService.createTicket: ${response.statusCode} - ${response.body}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        debugPrint('[TicketService] Parsed response: success=${data['success']}');

        if (data['success'] == true && data['ticket'] != null) {
          debugPrint('[TicketService] Ticket created successfully!');
          return Ticket.fromJson(data['ticket'] as Map<String, dynamic>);
        } else {
          debugPrint('[TicketService] ERROR: success=false or no ticket in response');
          debugPrint('[TicketService] Error message: ${data['message'] ?? data['error'] ?? 'unknown'}');
        }
      } else {
        debugPrint('[TicketService] ERROR: Bad status code ${response.statusCode}');
      }

      return null;
    } catch (e, stackTrace) {
      debugPrint('[TicketService] EXCEPTION in createTicket: $e');
      debugPrint('[TicketService] Stack trace: $stackTrace');
      _logger.log('TicketService.createTicket error: $e');
      return null;
    }
  }

  // ==================== MY TICKETS ====================

  /// Get my tickets (member)
  Future<TicketListResponse?> getMyTickets({
    required String mitgliedernummer,
    String? status,
  }) async {
    try {
      debugPrint('[TicketService] getMyTickets called for user: $mitgliedernummer');

      final token = _apiService.token;
      if (token == null) {
        debugPrint('[TicketService] ERROR: No token for getMyTickets!');
        _logger.log('TicketService.getMyTickets: No token');
        return null;
      }

      final deviceKey = _deviceKeyService.deviceKey ?? '';
      final headers = {
        'Authorization': 'Bearer $token',
        'X-Device-Key': deviceKey,
        'Content-Type': 'application/json',
        'User-Agent': _userAgent,
      };

      final url = Uri.parse('$baseUrl/tickets/list.php');
      final body = json.encode({
        'mitgliedernummer': mitgliedernummer,
        if (status != null && status.isNotEmpty) 'status': status,
      });

      debugPrint('[TicketService] Fetching tickets from: $url');
      debugPrint('[TicketService] Request body: $body');

      final response = await _client.post(url, headers: headers, body: body);

      debugPrint('[TicketService] getMyTickets Response status: ${response.statusCode}');
      debugPrint('[TicketService] getMyTickets Response body: ${response.body}');

      _logger.log(
        'TicketService.getMyTickets: ${response.statusCode} - ${response.body}',
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        debugPrint('[TicketService] Parsed data: success=${data['success']}, total=${data['total']}');

        if (data['success'] == true) {
          final ticketList = TicketListResponse.fromJson(data);
          debugPrint('[TicketService] Found ${ticketList.tickets.length} tickets');
          return ticketList;
        }
      } else {
        debugPrint('[TicketService] ERROR: Bad status ${response.statusCode}');
      }

      return null;
    } catch (e, stackTrace) {
      debugPrint('[TicketService] EXCEPTION in getMyTickets: $e');
      debugPrint('[TicketService] Stack trace: $stackTrace');
      _logger.log('TicketService.getMyTickets error: $e');
      return null;
    }
  }

  // ==================== COMMENTS & ATTACHMENTS ====================

  /// Get comments and attachments for a ticket
  Future<TicketCommentsResponse?> getComments({
    required String mitgliedernummer,
    required int ticketId,
  }) async {
    try {
      debugPrint('[TicketService] getComments called for ticket: $ticketId');

      final token = _apiService.token;
      if (token == null) {
        debugPrint('[TicketService] ERROR: No token for getComments!');
        _logger.log('TicketService.getComments: No token');
        return null;
      }

      final deviceKey = _deviceKeyService.deviceKey ?? '';
      final headers = {
        'Authorization': 'Bearer $token',
        'X-Device-Key': deviceKey,
        'Content-Type': 'application/json',
        'User-Agent': _userAgent,
      };

      final url = Uri.parse('$baseUrl/tickets/comments/list.php');
      final body = json.encode({
        'mitgliedernummer': mitgliedernummer,
        'ticket_id': ticketId,
      });

      debugPrint('[TicketService] POST to: $url');
      debugPrint('[TicketService] Request body: $body');

      final response = await _client.post(url, headers: headers, body: body);

      debugPrint('[TicketService] getComments Response status: ${response.statusCode}');
      debugPrint('[TicketService] getComments Response body: ${response.body}');

      _logger.log(
        'TicketService.getComments: ${response.statusCode} - ${response.body}',
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        debugPrint('[TicketService] Parsed: success=${data['success']}');

        if (data['success'] == true) {
          final result = TicketCommentsResponse.fromJson(data);
          debugPrint('[TicketService] Found ${result.comments.length} comments, ${result.attachments.length} attachments');
          return result;
        } else {
          debugPrint('[TicketService] ERROR: ${data['message'] ?? data['error']}');
        }
      } else {
        debugPrint('[TicketService] ERROR: Bad status ${response.statusCode}');
      }

      return null;
    } catch (e, stackTrace) {
      debugPrint('[TicketService] EXCEPTION in getComments: $e');
      debugPrint('[TicketService] Stack trace: $stackTrace');
      _logger.log('TicketService.getComments error: $e');
      return null;
    }
  }

  /// Add a comment to a ticket
  Future<TicketComment?> addComment({
    required String mitgliedernummer,
    required int ticketId,
    required String comment,
    bool isInternal = false,
  }) async {
    try {
      debugPrint('[TicketService] addComment called for ticket: $ticketId');
      debugPrint('[TicketService] Comment: $comment');

      final token = _apiService.token;
      if (token == null) {
        debugPrint('[TicketService] ERROR: No token for addComment!');
        _logger.log('TicketService.addComment: No token');
        return null;
      }

      final deviceKey = _deviceKeyService.deviceKey ?? '';
      final headers = {
        'Authorization': 'Bearer $token',
        'X-Device-Key': deviceKey,
        'Content-Type': 'application/json',
        'User-Agent': _userAgent,
      };

      final url = Uri.parse('$baseUrl/tickets/comments/add.php');
      final body = json.encode({
        'mitgliedernummer': mitgliedernummer,
        'ticket_id': ticketId,
        'comment': comment,
        'is_internal': isInternal ? 1 : 0,
      });

      debugPrint('[TicketService] POST to: $url');
      debugPrint('[TicketService] Request body: $body');

      final response = await _client.post(url, headers: headers, body: body);

      debugPrint('[TicketService] addComment Response status: ${response.statusCode}');
      debugPrint('[TicketService] addComment Response body: ${response.body}');

      _logger.log(
        'TicketService.addComment: ${response.statusCode} - ${response.body}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        debugPrint('[TicketService] Parsed: success=${data['success']}');

        if (data['success'] == true && data['comment'] != null) {
          debugPrint('[TicketService] Comment added successfully!');
          return TicketComment.fromJson(data['comment'] as Map<String, dynamic>);
        } else {
          debugPrint('[TicketService] ERROR: ${data['message'] ?? data['error']}');
        }
      } else {
        debugPrint('[TicketService] ERROR: Bad status ${response.statusCode}');
      }

      return null;
    } catch (e, stackTrace) {
      debugPrint('[TicketService] EXCEPTION in addComment: $e');
      debugPrint('[TicketService] Stack trace: $stackTrace');
      _logger.log('TicketService.addComment error: $e');
      return null;
    }
  }

  /// Upload attachment to a ticket
  Future<TicketAttachment?> uploadAttachment({
    required String mitgliedernummer,
    required int ticketId,
    required String filePath,
  }) async {
    try {
      final token = _apiService.token;
      if (token == null) {
        _logger.log('TicketService.uploadAttachment: No token');
        return null;
      }

      final deviceKey = _deviceKeyService.deviceKey ?? '';
      final url = Uri.parse('$baseUrl/tickets/upload.php');

      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['X-Device-Key'] = deviceKey;
      request.headers['User-Agent'] = 'ICD360S-Mitglieder-Android/1.0';  // ← SPECIFIC ANDROID

      request.fields['ticket_id'] = ticketId.toString();
      request.files.add(
        await http.MultipartFile.fromPath('file', filePath),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      _logger.log(
        'TicketService.uploadAttachment: ${response.statusCode}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        if (data['success'] == true && data['attachment'] != null) {
          return TicketAttachment.fromJson(
              data['attachment'] as Map<String, dynamic>);
        }
      }

      return null;
    } catch (e) {
      _logger.log('TicketService.uploadAttachment error: $e');
      return null;
    }
  }

  /// Get attachment download URL
  String getAttachmentDownloadUrl(
      String mitgliedernummer, int attachmentId) {
    return '$baseUrl/tickets/download.php?attachment_id=$attachmentId';
  }
}
