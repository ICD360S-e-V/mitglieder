#!/usr/bin/env python3
"""Text fuer den PR bzw. die Meldung aus deps-update.yml.

Alles kommt aus Dateien — damit laesst sich der Text ohne Netz und ohne
Flutter pruefen (test/deps_pr_text_test.dart).

  --alt / --neu   pubspec.lock vor und nach `flutter pub upgrade`
  --outdated      `flutter pub outdated --json --show-all` (nach dem Anheben)
  --deps          `flutter pub deps --json`
  --pubspec       pubspec.yaml (fuer die Kopien unter packages/vendor/)
  --lauf          Link auf den Actions-Lauf
  --gescheitert   Name der Pruefung, die rot war -> Meldung statt PR-Text
  --neue-bibliotheken  Datei mit neuen Systembibliotheken (eine je Zeile)
  --hinweise      "VORHER:NACHHER" — Anzahl der analyze-Hinweise
"""
import argparse
import json
import re
import sys

# Wo eine Probe auf dem Geraet dazugehoert. Kamera, PDF-Anzeige und Anrufe
# haben keine Testabdeckung (siehe deps-monthly.yml); der Rest faellt im
# Betrieb zuerst auf.
GERAETEPROBE = [
    (r'^(flutter_webrtc|dart_webrtc|flutter_ringtone_player)$',
     'Anruf führen, auch mit dem Systemfenster auf Android — Anrufe prüft kein Test auf dem Gerät'),
    (r'^flutter_secure_storage', 'nach dem Update weiter angemeldet?'),
    (r'^(flutter_local_notifications|windows_notification)', 'Benachrichtigung kommt an'),
    (r'^(flutter_background_service|workmanager)',
     'Hintergrund: Nachrichten und Erinnerungen kommen bei geschlossener App an'),
    (r'^(file_picker|android_file_picker|file_selector|windows_file_picker|image_picker|crop_your_image)',
     'Datei bzw. Bild anhängen'),
    (r'^(pdfrx|pdfium_)', 'PDF ansehen'),
    (r'^(just_audio|media_kit)', 'Ton abspielen'),
    (r'^webview_flutter', 'Webansicht öffnen'),
    (r'^permission_handler', 'Berechtigungsabfragen (Mikrofon, Kamera, Benachrichtigungen)'),
    (r'^(tray_manager|window_manager|launch_at_startup|screen_retriever)',
     'Desktop: Fenster, Tray und Autostart'),
]

# Was deps-update.yml vorab prüft. Der Ablauf gibt die Zeilen mit den Links
# auf die gestarteten Bau-Läufe per --pruefung mit; dies ist nur die Vorgabe.
PRUEFUNGEN = [
    'flutter test (ganze Suite — sie läuft sonst in keinem Ablauf)',
    'Android: build-android.yml — alle Flavors, Release mit R8',
    'Linux: build-linux-flatpak.yml — Bundle, .deb, .rpm, AppImage, Flatpak',
    'iOS, macOS, Windows: build-extras-platforms.yml',
    'Systembibliotheken im Linux-Bundle: keine neue gegenüber dem letzten Release '
    '(.deb/.rpm zählen sie mit --depends von Hand auf)',
]


def lock_lesen(pfad):
    """{name: {'version', 'art', 'quelle'}} aus einer pubspec.lock."""
    pakete, name, drin = {}, None, False
    felder = {'dependency': 'art', 'source': 'quelle', 'version': 'version'}
    with open(pfad, encoding='utf-8') as f:
        for zeile in f:
            z = zeile.rstrip('\n')
            if z == 'packages:':
                drin = True
                continue
            if drin and z and not z.startswith(' '):
                break  # sdks: — Ende der Paketliste
            if not drin:
                continue
            m = re.match(r'^  ([A-Za-z0-9_]+):$', z)
            if m:
                name = m.group(1)
                pakete[name] = {}
                continue
            m = re.match(r'^    (dependency|source|version): "?([^"]*)"?$', z)
            if m and name:
                pakete[name][felder[m.group(1)]] = m.group(2)
    return pakete


def kopien_lesen(pfad):
    """Pakete, die per dependency_overrides aus packages/vendor/ kommen."""
    kopien, drin, name = set(), False, None
    with open(pfad, encoding='utf-8') as f:
        for zeile in f:
            z = zeile.rstrip('\n')
            if z.startswith('dependency_overrides:'):
                drin = True
                continue
            if drin and z and not z.startswith(' ') and not z.startswith('#'):
                break
            m = re.match(r'^  ([A-Za-z0-9_]+):', z)
            if drin and m:
                name = m.group(1)
            if drin and name and re.match(r'^\s+path:\s*packages/vendor/', z):
                kopien.add(name)
    return kopien


def verweis(name, info):
    if info.get('quelle') == 'hosted':
        return f'[{name}](https://pub.dev/packages/{name}/changelog)'
    return f'`{name}`'


def art(info):
    return 'direkt' if 'direct' in info.get('art', '') else 'transitiv'


def aenderungen(alt, neu):
    angehoben = sorted(n for n in neu if n in alt and neu[n].get('version') != alt[n].get('version'))
    return angehoben, sorted(set(neu) - set(alt)), sorted(set(alt) - set(neu))


def tabelle(alt, neu):
    angehoben, hinzu, weg = aenderungen(alt, neu)
    z = ['| Paket | vorher | jetzt | |', '|---|---|---|---|']
    for n in angehoben:
        z.append(f"| {verweis(n, neu[n])} | {alt[n].get('version')} | {neu[n].get('version')} | {art(neu[n])} |")
    for n in hinzu:
        z.append(f"| {verweis(n, neu[n])} | — | {neu[n].get('version')} | neu, {art(neu[n])} |")
    for n in weg:
        z.append(f"| `{n}` | {alt[n].get('version')} | — | entfällt |")
    return z, angehoben + hinzu


def abhaengige(deps, name):
    """Wer das Paket einbindet — ohne die App selbst."""
    wer = []
    for p in deps.get('packages', []):
        if p.get('kind') == 'root' or name not in p.get('dependencies', []):
            continue
        wer.append('Flutter-SDK' if p.get('source') == 'sdk' else p['name'])
    return sorted(set(wer))


def nicht_automatisch(outdated, deps, kopien):
    sprung, blockiert, kopie, warnung = [], [], [], []
    for p in outdated.get('packages', []):
        n = p.get('package')
        cur = (p.get('current') or {}).get('version')
        res = (p.get('resolvable') or {}).get('version')
        lat = (p.get('latest') or {}).get('version')
        if not n or not cur:
            continue
        wer = abhaengige(deps, n)
        herkunft = f' (eingebunden von: {", ".join(wer)})' if wer else ' (direkt)'
        if p.get('isCurrentAffectedByAdvisory'):
            warnung.append(f'🔴 **{n} {cur} ist von einer Sicherheitsmeldung betroffen**{herkunft} — sofort ansehen')
        if p.get('isCurrentRetracted'):
            warnung.append(f'🔴 {n} {cur} wurde vom Autor zurückgezogen{herkunft}')
        if p.get('isDiscontinued'):
            ersatz = p.get('replacedBy')
            warnung.append(f'⚠️ {n} ist eingestellt{herkunft}' + (f' — Nachfolger: {ersatz}' if ersatz else ''))
        if n in kopien:
            if lat and lat != cur:
                kopie.append(f'- `{n}`: Kopie {cur}, pub.dev hat {lat} — `packages/vendor/README.md` (Built-in Kotlin prüfen)')
            continue
        if p.get('kind') in ('direct', 'dev') and res and res != cur:
            rest = f' (neueste {lat} bleibt blockiert)' if lat and lat != res else ''
            sprung.append(f'- {n} {cur} → {res}{rest}')
        elif lat and lat != cur and lat != res:
            if p.get('kind') in ('direct', 'dev'):
                grund = f'direkt; den Grund nennt `flutter pub add {n}:{lat}`'
            else:
                grund = 'eingebunden von: ' + (', '.join(wer) if wer else '?')
            blockiert.append(f'- {n} {cur} ({lat} verfügbar) — {grund}')
    return sprung, blockiert, kopie, warnung


def main():
    ap = argparse.ArgumentParser()
    for a in ('--alt', '--neu', '--outdated', '--deps', '--pubspec'):
        ap.add_argument(a, required=True)
    ap.add_argument('--lauf', default='')
    ap.add_argument('--gescheitert', default='')
    ap.add_argument('--neue-bibliotheken', default='')
    ap.add_argument('--hinweise', default='')
    ap.add_argument('--pruefung', action='append', default=[])
    a = ap.parse_args()

    alt, neu = lock_lesen(a.alt), lock_lesen(a.neu)
    with open(a.outdated, encoding='utf-8') as f:
        outdated = json.load(f)
    with open(a.deps, encoding='utf-8') as f:
        deps = json.load(f)
    kopien = kopien_lesen(a.pubspec)
    zeilen, geaendert = tabelle(alt, neu)
    sprung, blockiert, kopie, warnung = nicht_automatisch(outdated, deps, kopien)
    lauf = f' — [Lauf]({a.lauf})' if a.lauf else ''
    out = []

    if a.gescheitert:
        # Meldung ins Issue: nichts angehoben, und warum.
        out += [f'## Anhebung zurückgehalten: **{a.gescheitert}** war rot{lauf}', '',
                'Es wurde **nichts** angehoben — kein PR, der Prüfzweig ist wieder gelöscht. So hätte es ausgesehen:',
                '']
        out += zeilen
        if a.neue_bibliotheken:
            with open(a.neue_bibliotheken, encoding='utf-8') as f:
                libs = [l.strip() for l in f if l.strip()]
            if libs:
                out += ['', 'Neue Systembibliotheken im Linux-Bundle (das RPM bräuchte neue `Requires`): '
                        + ', '.join(f'`{l}`' for l in libs)]
        out += ['', 'Nächster Versuch am nächsten Montag. Welches Paket es war, sagt das Protokoll des Laufs.']
        print('\n'.join(out))
        return 0

    out += ['Automatisch von `.github/workflows/deps-update.yml`. Angehoben ist nur, was die Grenzen in '
            '`pubspec.yaml` schon erlauben; der PR entsteht **erst, nachdem alle Prüfungen unten grün waren**. '
            'Gemergt wird von Hand; der Commit heisst `fix(deps): …`, release-please macht daraus ein Patch-Release.',
            '',
            f'## Angehoben ({len(zeilen) - 2})', '']
    out += zeilen
    out += ['', f'## Vorab geprüft{lauf}', '']
    for p in (a.pruefung or PRUEFUNGEN):
        out.append(f'- ✅ {p}')
    if a.hinweise and ':' in a.hinweise:
        vorher, nachher = a.hinweise.split(':', 1)
        if vorher.strip().isdigit() and nachher.strip().isdigit() and int(nachher) > int(vorher):
            out.append(f'- ℹ️ `flutter analyze` meldet {int(nachher) - int(vorher)} Hinweis(e) mehr als vorher '
                       f'({vorher} → {nachher}) — nicht fatal, meist `deprecated`')
    out += ['', 'Das Freigeben der wartenden Prüfungen („Approve workflows to run") ist nicht nötig — '
            'pr-check.yml würde nur `flutter analyze` wiederholen, das in jedem Bau oben schon lief.']

    probe = []
    for muster, text in GERAETEPROBE:
        treffer = [n for n in geaendert if re.search(muster, n)]
        if treffer:
            probe.append(f'- {text} ({", ".join(treffer)})')
    if probe:
        out += ['', '## Nach dem Merge auf dem Gerät prüfen', ''] + probe

    if warnung:
        out += ['', '## Achtung', ''] + [f'- {w}' for w in warnung]

    if sprung or blockiert or kopie:
        out += ['', '## Nicht automatisch', '']
        if sprung:
            out += ['Braucht eine Änderung in `pubspec.yaml` (Major-Sprung, oft auch am Code):', ''] + sprung + ['']
        if blockiert:
            out += ['Von anderen Paketen festgehalten:', ''] + blockiert + ['']
        if kopie:
            out += ['Kopien unter `packages/vendor/`:', ''] + kopie + ['']

    out += ['', 'Nicht auf einem Gerät erprobt.']
    print('\n'.join(out).rstrip() + '\n')
    return 0


if __name__ == '__main__':
    sys.exit(main())
