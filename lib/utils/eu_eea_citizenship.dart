/// Staatsangehörigkeiten mit Freizügigkeitsrecht — EU 27, EWR und die Schweiz.
///
/// Aus dieser Menge leiten Wizard (Stufe 1d) und Verifizierung-Tab denselben
/// Aufenthaltsstatus ab: wer hier steht, bekommt `eu_eea_freizuegigkeit` und
/// wird nicht nach einem Aufenthaltstitel gefragt; alles andere außer
/// „deutsch" gilt als Drittstaat.
///
/// Warum das an genau einer Stelle steht: die Liste lag bis August 2026 in
/// beiden Dateien identisch herum. Tritt ein Staat der EU bei und pflegt
/// jemand nur eine der beiden nach, stufen Wizard und Verifizierung denselben
/// Menschen unterschiedlich ein — und das fällt niemandem auf, weil beide für
/// sich schlüssig aussehen.
///
/// Enthalten sind auch englische Formen und Schreibweisen ohne Umlaut, weil
/// das Feld früher frei getippt wurde und diese Werte real in der Datenbank
/// stehen (etwa „rumanisch" bei 13 Mitgliedern).
library;

const Set<String> euEeaAdjectives = {
  // EU 27 (deutsche und englische Form)
  'österreichisch', 'osterreichisch', 'austrian',
  'belgisch', 'belgian',
  'bulgarisch', 'bulgarian',
  'kroatisch', 'croatian',
  'zyprisch', 'cypriot',
  'tschechisch', 'czech',
  'dänisch', 'danisch', 'danish',
  'estnisch', 'estonian',
  'finnisch', 'finnish',
  'französisch', 'franzosisch', 'french',
  'griechisch', 'greek',
  'ungarisch', 'hungarian',
  'irisch', 'irish',
  'italienisch', 'italian',
  'lettisch', 'latvian',
  'litauisch', 'lithuanian',
  'luxemburgisch', 'luxembourgish',
  'maltesisch', 'maltese',
  'niederländisch', 'niederlandisch', 'dutch',
  'polnisch', 'polish',
  'portugiesisch', 'portuguese',
  'rumänisch', 'rumanisch', 'romanian',
  'slowakisch', 'slovak',
  'slowenisch', 'slovenian',
  'spanisch', 'spanish',
  'schwedisch', 'swedish',
  // EWR
  'isländisch', 'islandisch', 'icelandic',
  'liechtensteinisch',
  'norwegisch', 'norwegian',
  // Schweiz, über die bilateralen Abkommen
  'schweizerisch', 'swiss',
};

/// Einstufung einer eingetragenen Staatsangehörigkeit.
enum CitizenshipBucket { none, german, euEea, thirdCountry }

/// Ordnet den Freitext bzw. den Auswahlwert einer Gruppe zu.
///
/// Leer heißt bewusst [CitizenshipBucket.none] und nicht „Drittstaat": solange
/// nichts eingetragen ist, darf die Oberfläche keinen Aufenthaltstitel
/// verlangen.
CitizenshipBucket citizenshipBucket(String? staatsangehoerigkeit) {
  final lower = (staatsangehoerigkeit ?? '').trim().toLowerCase();
  if (lower.isEmpty) return CitizenshipBucket.none;
  if (lower == 'deutsch' || lower == 'german') return CitizenshipBucket.german;
  if (euEeaAdjectives.contains(lower)) return CitizenshipBucket.euEea;
  return CitizenshipBucket.thirdCountry;
}
