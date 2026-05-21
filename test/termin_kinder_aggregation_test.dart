import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/services/termin_service.dart';

/// Minimal stable JSON payload matching the new aggregated response from
/// /api/termine/my_termine.php. Tests override or omit specific keys.
Map<String, dynamic> _baseJson({
  Object? participantUserId,
  String? participantVorname,
  String? participantNachname,
  String? participantMitgliedernummer,
  String? participantRole,
  bool includeParticipant = true,
}) {
  final base = <String, dynamic>{
    'id': 100,
    'title': 'Vorstandssitzung Mai',
    'category': 'vorstandssitzung',
    'description': 'Monatliche Sitzung',
    'termin_date': '2026-05-21 18:00:00',
    'duration_minutes': 90,
    'location': 'Vereinsheim',
    'created_by': 1,
    'status': 'scheduled',
    'created_at': '2026-05-15 10:00:00',
  };
  if (includeParticipant) {
    base['participant_user_id'] = participantUserId;
    base['participant_vorname'] = participantVorname;
    base['participant_nachname'] = participantNachname;
    base['participant_mitgliedernummer'] = participantMitgliedernummer;
    base['participant_role'] = participantRole;
  }
  return base;
}

void main() {
  group('Termin.fromJson — participant fields', () {
    test('reads all 5 participant_* fields when present (int form)', () {
      final t = Termin.fromJson(_baseJson(
        participantUserId: 54,
        participantVorname: 'mykhailo',
        participantNachname: 'tsynhalov',
        participantMitgliedernummer: 'J23960',
        participantRole: 'jugendmitglied',
      ));

      expect(t.participantUserId, 54);
      expect(t.participantVorname, 'mykhailo');
      expect(t.participantNachname, 'tsynhalov');
      expect(t.participantMitgliedernummer, 'J23960');
      expect(t.participantRole, 'jugendmitglied');
    });

    test('coerces participant_user_id when server sends it as a string', () {
      final t = Termin.fromJson(_baseJson(
        participantUserId: '54', // PHP/MySQL sometimes stringifies
        participantMitgliedernummer: 'J23960',
      ));
      expect(t.participantUserId, 54);
    });

    test('leaves participant_user_id null when server sends garbage', () {
      final t = Termin.fromJson(_baseJson(
        participantUserId: 'not-a-number',
        participantMitgliedernummer: 'J23960',
      ));
      expect(t.participantUserId, isNull);
    });

    test('all participant fields stay null when omitted (back-compat)', () {
      final t = Termin.fromJson(_baseJson(includeParticipant: false));
      expect(t.participantUserId, isNull);
      expect(t.participantVorname, isNull);
      expect(t.participantNachname, isNull);
      expect(t.participantMitgliedernummer, isNull);
      expect(t.participantRole, isNull);
    });
  });

  group('Termin.forKindBadge', () {
    test('returns null when participant matches self (own termin)', () {
      final t = Termin.fromJson(_baseJson(
        participantUserId: 48,
        participantVorname: 'Olha',
        participantNachname: 'Pasichnyk',
        participantMitgliedernummer: 'M82983',
        participantRole: 'mitglied',
      ));
      expect(t.forKindBadge('M82983'), isNull);
    });

    test('returns full name when participant is a different user (child)', () {
      final t = Termin.fromJson(_baseJson(
        participantUserId: 54,
        participantVorname: 'mykhailo',
        participantNachname: 'tsynhalov',
        participantMitgliedernummer: 'J23960',
        participantRole: 'jugendmitglied',
      ));
      expect(t.forKindBadge('M82983'), 'mykhailo tsynhalov');
    });

    test('falls back to Mitgliedernummer when name parts are missing', () {
      final t = Termin.fromJson(_baseJson(
        participantUserId: 54,
        participantMitgliedernummer: 'J23960',
        participantRole: 'jugendmitglied',
      ));
      expect(t.forKindBadge('M82983'), 'J23960');
    });

    test('falls back to Mitgliedernummer when names are blank strings', () {
      final t = Termin.fromJson(_baseJson(
        participantVorname: '   ',
        participantNachname: '',
        participantMitgliedernummer: 'J23960',
      ));
      expect(t.forKindBadge('M82983'), 'J23960');
    });

    test('returns null when participant fields absent (legacy payload)', () {
      final t = Termin.fromJson(_baseJson(includeParticipant: false));
      expect(t.forKindBadge('M82983'), isNull);
    });

    test('uses only vorname when nachname missing', () {
      final t = Termin.fromJson(_baseJson(
        participantVorname: 'mykhailo',
        participantMitgliedernummer: 'J23960',
      ));
      expect(t.forKindBadge('M82983'), 'mykhailo');
    });
  });

  group('Termin.isKindTermin', () {
    test('true when role is jugendmitglied', () {
      final t = Termin.fromJson(_baseJson(participantRole: 'jugendmitglied'));
      expect(t.isKindTermin, isTrue);
    });

    test('false when role is mitglied', () {
      final t = Termin.fromJson(_baseJson(participantRole: 'mitglied'));
      expect(t.isKindTermin, isFalse);
    });

    test('false when role missing', () {
      final t = Termin.fromJson(_baseJson(includeParticipant: false));
      expect(t.isKindTermin, isFalse);
    });
  });
}
