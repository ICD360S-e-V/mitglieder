class User {
  final int id;
  final String mitgliedernummer;
  final String email;
  final String name;
  final String status;
  final String role;
  final DateTime? createdAt;
  final DateTime? lastLogin;
  final int? zahlungstag;
  final String? vorname2;
  final String? geburtsdatum;
  final String? geburtsort;
  final String? staatsangehoerigkeit;
  final String? muttersprache;
  final String? bundesland;
  final String? land;
  final String? mitgliedsart;
  final String? zahlungsmethode;

  User({
    required this.id,
    required this.mitgliedernummer,
    required this.email,
    required this.name,
    required this.status,
    required this.role,
    this.createdAt,
    this.lastLogin,
    this.zahlungstag,
    this.vorname2,
    this.geburtsdatum,
    this.geburtsort,
    this.staatsangehoerigkeit,
    this.muttersprache,
    this.bundesland,
    this.land,
    this.mitgliedsart,
    this.zahlungsmethode,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      mitgliedernummer: json['mitgliedernummer'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      status: json['status'] ?? 'active',
      role: json['role'] ?? 'mitglied',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      lastLogin: json['last_login'] != null
          ? DateTime.tryParse(json['last_login'])
          : null,
      zahlungstag: json['zahlungstag'] != null
          ? int.tryParse(json['zahlungstag'].toString())
          : null,
      vorname2: json['vorname2'],
      geburtsdatum: json['geburtsdatum'],
      geburtsort: json['geburtsort'],
      staatsangehoerigkeit: json['staatsangehoerigkeit'],
      muttersprache: json['muttersprache'],
      bundesland: json['bundesland'],
      land: json['land'],
      mitgliedsart: json['mitgliedsart'],
      zahlungsmethode: json['zahlungsmethode'],
    );
  }

  bool get isActive => status == 'active';
  bool get isNeu => status == 'neu';
  bool get isSuspended => status == 'suspended';
  bool get isDeleted => status == 'deleted';
}
