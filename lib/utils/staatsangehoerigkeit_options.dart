/// Aufbereitung der Staatsangehörigkeiten für ein Auswahlfeld.
///
/// Die Liste selbst kommt vom Server (`api/member/staatsangehoerigkeiten_list.php`,
/// gespeist aus dem Verzeichnis der Staatsangehörigkeiten der Staats- und
/// Gebietssystematik, Destatis, Stand August 2024). Hier wird sie nur
/// gruppiert und sortiert — die Bezeichnungen werden bewusst nicht im Code
/// wiederholt, sonst gäbe es zwei Wahrheiten.
///
/// Bei 205 Einträgen ist eine durchlaufende Liste nicht zu überblicken,
/// deshalb nach Erdteil gruppiert, Erdteile in fester Reihenfolge und die im
/// Verein tatsächlich vorkommenden Staatsangehörigkeiten oben in ihrer Gruppe.
library;

/// Reihenfolge der Gruppen. Alles, was der Server anders benennt, landet
/// hinten — eine unbekannte Gruppe soll auftauchen, nicht verschwinden.
const List<String> kontinentReihenfolge = [
  'Europa',
  'Asien',
  'Afrika',
  'Amerika',
  'Australien/Ozeanien',
  'Sonstige',
];

/// Kommt im Verein vor und steht deshalb in seiner Gruppe oben.
const Set<String> haeufigeStaatsangehoerigkeiten = {
  'deutsch',
  'rumänisch',
  'ukrainisch',
  'russisch',
  'polnisch',
};

class StaatsangehoerigkeitGruppe {
  final String kontinent;
  final List<String> bezeichnungen;
  const StaatsangehoerigkeitGruppe(this.kontinent, this.bezeichnungen);
}

/// Gruppiert die Serverliste. Erwartet die Rohdaten des Endpunkts mit den
/// Schlüsseln `bezeichnung` und `kontinent`.
///
/// Zeilen ohne Kontinent kommen unter „Sonstige" — vor der Migration vom
/// 02.08.2026 hatte die Spalte niemand, und eine ältere Serverfassung darf
/// nicht dazu führen, dass die Auswahl leer bleibt.
List<StaatsangehoerigkeitGruppe> gruppiereStaatsangehoerigkeiten(
    List<Map<String, dynamic>> roh) {
  final nachKontinent = <String, List<String>>{};
  final gesehen = <String>{};

  for (final e in roh) {
    final b = (e['bezeichnung'] ?? '').toString().trim();
    if (b.isEmpty || !gesehen.add(b)) continue;
    final k = (e['kontinent'] ?? '').toString().trim();
    nachKontinent.putIfAbsent(k.isEmpty ? 'Sonstige' : k, () => []).add(b);
  }

  int rang(String k) {
    final i = kontinentReihenfolge.indexOf(k);
    return i < 0 ? kontinentReihenfolge.length : i;
  }

  final gruppen = nachKontinent.keys.toList()
    ..sort((a, b) {
      final r = rang(a).compareTo(rang(b));
      return r != 0 ? r : a.compareTo(b);
    });

  return [
    for (final k in gruppen)
      StaatsangehoerigkeitGruppe(k, nachKontinent[k]!..sort(_vergleich)),
  ];
}

int _vergleich(String a, String b) {
  final ha = haeufigeStaatsangehoerigkeiten.contains(a);
  final hb = haeufigeStaatsangehoerigkeiten.contains(b);
  if (ha != hb) return ha ? -1 : 1;
  return _sortierform(a).compareTo(_sortierform(b));
}

/// „ägyptisch" gehört zu „a", nicht ans Ende des Alphabets.
String _sortierform(String s) => s
    .toLowerCase()
    .replaceAll('ä', 'a')
    .replaceAll('ö', 'o')
    .replaceAll('ü', 'u')
    .replaceAll('ß', 'ss');

/// Bringt einen gespeicherten Freitext auf die Schreibweise der Serverliste,
/// damit das Dropdown ihn wiederfindet: früher wurde das Feld getippt, und
/// „Rumanisch" ist dieselbe Staatsangehörigkeit wie „rumänisch".
///
/// Ohne Entsprechung bleibt der Wert unverändert — eine Angabe stehen zu
/// lassen, die wir nicht zuordnen können, ist besser, als sie auf die
/// nächstbeste Staatsangehörigkeit zu verbiegen.
String staatsangehoerigkeitNormalisieren(String? roh, List<Map<String, dynamic>> liste) {
  final s = (roh ?? '').trim();
  if (s.isEmpty) return '';
  final klein = _sortierform(s);
  for (final e in liste) {
    final b = (e['bezeichnung'] ?? '').toString().trim();
    if (b.isNotEmpty && _sortierform(b) == klein) return b;
  }
  return s;
}
