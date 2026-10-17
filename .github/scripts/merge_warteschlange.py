#!/usr/bin/env python3
"""Merge-Warteschlange: mergt die offenen PRs der Reihe nach, vom aeltesten zum
neuesten — den naechsten erst, wenn die Fassung des vorigen gebaut und
veroeffentlicht ist.

Wunsch des Vorsitzenden (17.10.2026): „pai faci un sistem sa automatizeze
prurile in ordine cronologica cand detecteaza un pr pentru merge sa faca merge
si daca apare un pr in acelasi timp asteapta pana cand se termina pr care sa
facut merge“. Gleiche Datei in vorsitzer, mitglieder und schatzmeister; was
sich je App unterscheidet, steht in .github/workflows/merge-warteschlange.yml.

Jeder Lauf mergt hoechstens EINEN PR und sieht nur nach, was GitHub gerade
zeigt — er merkt sich nichts. Reihenfolge der Pruefung:
  1. laeuft ein Release oder ein Bau (ohne PR-Pruefungen)?  -> warten
  2. ist der Release-Ablauf gerade erst fertig (seine Folgelaeufe melden
     sich erst nach Sekunden)?                               -> warten
  3. wurde gerade erst gemergt (die Laeufe dazu zeigen sich noch nicht)?
                                                             -> warten
  4. ist der Release-PR von release-please offen (mitglieder)? -> warten
  5. ist der letzte Release gescheitert, oder kam die letzte Fassung nicht ins
     GitHub-Release (der Schritt BAU_VEROEFFENTLICHT)?        -> halt
     (scheitert nur ein Nebenschritt — mitglieder v1.109.0: das AAB fuer
     Google Play —, ist die Fassung trotzdem draussen: kein Halt)
  6. der aelteste PR, der in Frage kommt:
       Pruefungen laufen noch / GitHub rechnet noch          -> warten
       (die Reihenfolge bleibt: kein juengerer zieht vorbei)
       rot, Konflikt, Entwurf, Etikett `asteapta`, Fork,
       fremder Autor (auch Dependabot)                       -> uebersprungen
       gruen und mergebar                                    -> mergen

Einstellungen (Umgebung):
  MERGE_ART        squash | merge — wie der Knopf „Mergen" der Vorsitzer-App
  LAEUFE_WARTEN    Ablaeufe, deren Laeufe (ohne PR-Pruefungen) die Schlange
                   anhalten, solange sie laufen
  FREIGABE_LAUF    der Release-Ablauf (release.yml / release-please.yml)
  BAU_LAUF         der Android-Bau (build-android.yml)
  BAU_VEROEFFENTLICHT  der Schritt darin, der die Fassung ins GitHub-Release
                   stellt — gelang er, ist sie draussen
  NACH_DEM_MERGEN  Ablaeufe, die ein Push auf main sonst startet: ein Merge mit
                   dem GITHUB_TOKEN startet KEINEN (Schleifenschutz von
                   GitHub). `datei.yml@pfad,pfad` — nur, wenn der PR einen
                   dieser Pfade beruehrt (wie `paths:` am Push).
  AUTOREN          wessen PRs — nie die eines Fremden: mitglieder und
                   schatzmeister sind oeffentlich, jeder kann einen PR stellen
  TROCKEN          gesetzt: nur sagen, was geschaehe
  GH_REPO, GH_TOKEN  fuer gh

  --entscheiden DATEI   nur die Entscheidung, aus einer JSON-Datei (Tests)
  --folgelaeufe DATEI   nur, welche Ablaeufe nach dem Merge starten (Tests)
"""
import argparse
import json
import os
import re
import subprocess
import sys
from datetime import datetime, timedelta, timezone

# Nach einem fertigen Release-Ablauf: so lange, bis sich der Bau zeigt, den er
# angestossen hat (release.yml -> build-android, release-please -> Tag).
NACHLAUF = timedelta(minutes=2)
# Nach einem Merge: so lange, bis sich die Laeufe dazu zeigen.
SETZEN = timedelta(minutes=3)
# Ein PR ganz ohne Pruefungen: so lange warten, dann ueberspringen.
OHNE_PRUEFUNG = timedelta(minutes=30)

HALTE_ETIKETT = 'asteapta'
RELEASE_PLEASE_ZWEIG = 'release-please--'
FASSUNG = re.compile(r'^v\d')
GUT = {'SUCCESS', 'SKIPPED', 'NEUTRAL'}


def _zeit(text):
    return datetime.fromisoformat(text.replace('Z', '+00:00'))


def _alter(text, jetzt):
    return jetzt - _zeit(text) if text else timedelta.max


def _warten(grund, **mehr):
    return {'aktion': 'warten', 'grund': grund, **mehr}


def pruefungen(rollup):
    """gruen | laeuft | rot | keine — aus statusCheckRollup eines PR."""
    if not rollup:
        return 'keine'
    laeuft = rot = False
    for c in rollup:
        if c.get('__typename') == 'StatusContext':
            stand = (c.get('state') or '').upper()
            if stand in ('PENDING', 'EXPECTED'):
                laeuft = True
            elif stand != 'SUCCESS':
                rot = True
        elif (c.get('status') or '').upper() != 'COMPLETED':
            laeuft = True
        elif (c.get('conclusion') or '').upper() not in GUT:
            rot = True
    return 'rot' if rot else ('laeuft' if laeuft else 'gruen')


def _ausgeschlossen(pr, k):
    """Warum ein PR nie in die Schlange kommt — oder None."""
    if pr.get('isDraft'):
        return 'Entwurf'
    if pr.get('baseRefName', 'main') != 'main':
        return f"zielt auf {pr.get('baseRefName')}"
    if pr.get('isCrossRepository'):
        return 'aus einem fremden Fork'
    autor = (pr.get('author') or {}).get('login', '')
    if autor not in k['autoren']:
        return f'von {autor}'
    if any(e.get('name') == HALTE_ETIKETT for e in pr.get('labels') or []):
        return f'Etikett {HALTE_ETIKETT}'
    return None


def _letzter_fertiger(laeufe, datei, nur_fassungen):
    """Der juengste beendete Lauf von [datei] — ohne PR-Pruefungen und ohne
    abgebrochene (die hat ein neuerer abgeloest)."""
    fertig = [
        l for l in laeufe
        if l.get('datei') == datei
        and l.get('event') != 'pull_request'
        and l.get('status') == 'completed'
        and l.get('conclusion') not in ('cancelled', 'skipped')
        and (not nur_fassungen or FASSUNG.match(l.get('headBranch') or ''))
    ]
    return max(fertig, key=lambda l: l.get('createdAt') or '', default=None)


def _veroeffentlicht(lauf, schritt):
    """Kam die Fassung trotz rotem Lauf ins GitHub-Release? Ohne Angaben zu den
    Schritten: nein."""
    if not schritt:
        return False
    return any(j.get('name') == schritt and j.get('conclusion') == 'success'
               for j in lauf.get('jobs') or [])


def entscheiden(daten, k, jetzt):
    laeufe = daten.get('laeufe') or []
    prs = sorted(daten.get('prs') or [], key=lambda p: p['number'])

    # 1. Release oder Bau unterwegs: der naechste Merge braeche ihn ab
    #    (build-android der Vorsitzer-App: eine Spur, cancel-in-progress) oder
    #    vermengte zwei Fassungen.
    for l in laeufe:
        if l.get('event') != 'pull_request' and l.get('status') != 'completed':
            name = l.get('workflowName') or l.get('datei')
            return _warten(f"{name} läuft ({l.get('headBranch')})")

    # 2. Der Release-Ablauf ist eben erst fertig geworden.
    for l in laeufe:
        if (l.get('datei') == k['freigabe'] and l.get('event') != 'pull_request'
                and _alter(l.get('updatedAt'), jetzt) < NACHLAUF):
            return _warten(f"{l.get('workflowName') or k['freigabe']} eben fertig — der Bau meldet sich noch")

    # 3. Eben gemergt — von hier, vom Knopf in der App oder von Hand.
    gemergt = [m.get('mergedAt') for m in daten.get('merges') or [] if m.get('mergedAt')]
    if gemergt and _alter(max(gemergt), jetzt) < SETZEN:
        return _warten('eben gemergt — die Läufe dazu melden sich noch')

    # 4. release-please (mitglieder) hat seinen Release-PR offen: die Fassung
    #    ist unterwegs, er mergt sich selbst.
    for pr in prs:
        if (pr.get('headRefName') or '').startswith(RELEASE_PLEASE_ZWEIG):
            return _warten(f"Release-PR #{pr['number']} ist offen")

    # 5. Ist die letzte Fassung gescheitert, kommt nichts darauf.
    for datei, nur_fassungen, was in ((k['freigabe'], False, 'Release'), (k['bau'], True, 'Bau')):
        letzter = _letzter_fertiger(laeufe, datei, nur_fassungen)
        if not letzter or letzter.get('conclusion') == 'success':
            continue
        if was == 'Bau' and _veroeffentlicht(letzter, k.get('veroeffentlicht')):
            continue
        return {
            'aktion': 'halt',
            'grund': f"der letzte {was} ist gescheitert ({letzter.get('headBranch')}, "
                     f"{letzter.get('conclusion')}) — erst ein gelungener geht weiter",
        }

    # 6. Der aelteste PR, der in Frage kommt.
    uebersprungen = []
    for pr in prs:
        n = pr['number']
        grund = _ausgeschlossen(pr, k)
        if grund:
            uebersprungen.append(f'#{n}: {grund}')
            continue
        if pr.get('mergeable') == 'CONFLICTING':
            uebersprungen.append(f'#{n}: Konflikt')
            continue
        stand = pruefungen(pr.get('statusCheckRollup'))
        if stand == 'rot':
            uebersprungen.append(f'#{n}: Prüfungen rot')
            continue
        if stand == 'keine':
            if _alter(pr.get('createdAt'), jetzt) < OHNE_PRUEFUNG:
                return _warten(f'#{n}: noch keine Prüfungen', uebersprungen=uebersprungen)
            uebersprungen.append(f'#{n}: ohne Prüfungen')
            continue
        if stand == 'laeuft':
            return _warten(f'#{n}: Prüfungen laufen', uebersprungen=uebersprungen)
        if pr.get('mergeable') != 'MERGEABLE':
            return _warten(f'#{n}: GitHub rechnet noch, ob er sich mergen lässt',
                           uebersprungen=uebersprungen)
        return {
            'aktion': 'mergen',
            'pr': n,
            'titel': pr.get('title', ''),
            'sha': pr.get('headRefOid', ''),
            'grund': f"#{n} ist der älteste fertige PR",
            'uebersprungen': uebersprungen,
        }
    return {'aktion': 'nichts', 'grund': 'kein PR bereit', 'uebersprungen': uebersprungen}


def folgelaeufe(eintraege, dateien):
    """Welche Ablaeufe nach dem Merge starten — `datei.yml@pfad,pfad` nur, wenn
    der PR einen der Pfade beruehrt. Wie `paths:` am Push: `ordner/**` heisst
    alles darunter, sonst genau diese Datei."""
    starten = []
    for eintrag in eintraege:
        datei, _, pfade = eintrag.partition('@')
        if not pfade:
            starten.append(datei)
            continue
        muster = [p for p in pfade.split(',') if p]
        if any(_trifft(f, p) for f in dateien for p in muster):
            starten.append(datei)
    return starten


def _trifft(datei, muster):
    if muster.endswith('/**'):
        return datei.startswith(muster[:-2])
    return datei == muster


def konfig_aus_umgebung():
    k = {
        'art': os.environ.get('MERGE_ART', ''),
        'warten': os.environ.get('LAEUFE_WARTEN', '').split(),
        'freigabe': os.environ.get('FREIGABE_LAUF', ''),
        'bau': os.environ.get('BAU_LAUF', ''),
        'veroeffentlicht': os.environ.get('BAU_VEROEFFENTLICHT', ''),
        'nach': os.environ.get('NACH_DEM_MERGEN', '').split(),
        'autoren': os.environ.get('AUTOREN', '').split(),
    }
    if k['art'] not in ('squash', 'merge') or not k['warten'] or not k['freigabe'] \
            or not k['bau'] or not k['autoren']:
        sys.exit(f'Einstellungen unvollständig: {k}')
    return k


def _gh(*args):
    r = subprocess.run(['gh', *args], check=True, capture_output=True, text=True)
    return r.stdout


def _gh_json(*args):
    return json.loads(_gh(*args) or 'null')


def daten_holen(k):
    prs = _gh_json(
        'pr', 'list', '--state', 'open', '--base', 'main', '--limit', '100', '--json',
        'number,title,author,isDraft,isCrossRepository,headRefName,headRefOid,baseRefName,'
        'mergeable,labels,createdAt,statusCheckRollup')
    laeufe = []
    for datei in dict.fromkeys(k['warten'] + [k['freigabe'], k['bau']]):
        for l in _gh_json('run', 'list', '--workflow', datei, '--limit', '15', '--json',
                          'databaseId,status,conclusion,event,headBranch,createdAt,updatedAt,workflowName'):
            l['datei'] = datei
            laeufe.append(l)
    # Nur fuer den letzten roten Bau einer Fassung: welche Schritte gelangen?
    letzter = _letzter_fertiger(laeufe, k['bau'], True)
    if letzter and letzter.get('conclusion') != 'success':
        letzter['jobs'] = (_gh_json('run', 'view', str(letzter['databaseId']), '--json', 'jobs')
                           or {}).get('jobs') or []
    merges = _gh_json('pr', 'list', '--state', 'merged', '--base', 'main', '--limit', '5',
                      '--json', 'number,mergedAt')
    return {'prs': prs, 'laeufe': laeufe, 'merges': merges}


def mergen(e, k):
    n = str(e['pr'])
    befehl = ['pr', 'merge', n, '--match-head-commit', e['sha']]
    if k['art'] == 'squash':
        # Wie githubSquashTitel der Vorsitzer-App: „<Titel> (#N)".
        befehl += ['--squash', '--subject', f"{e['titel']} (#{n})"]
    else:
        befehl += ['--merge']
    _gh(*befehl)
    dateien = _gh('pr', 'view', n, '--json', 'files', '--jq', '.files[].path').split()
    gestartet = []
    for datei in folgelaeufe(k['nach'], dateien):
        _gh('workflow', 'run', datei, '--ref', 'main')
        gestartet.append(datei)
    return gestartet


def _zusammenfassung(zeilen):
    ziel = os.environ.get('GITHUB_STEP_SUMMARY')
    text = '\n'.join(zeilen) + '\n'
    print(text, end='')
    if ziel:
        with open(ziel, 'a', encoding='utf-8') as f:
            f.write(text)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--entscheiden')
    ap.add_argument('--folgelaeufe')
    a = ap.parse_args()

    if a.entscheiden:
        with open(a.entscheiden, encoding='utf-8') as f:
            d = json.load(f)
        print(json.dumps(entscheiden(d, d['konfig'], _zeit(d['jetzt'])), ensure_ascii=False))
        return
    if a.folgelaeufe:
        with open(a.folgelaeufe, encoding='utf-8') as f:
            d = json.load(f)
        print(json.dumps(folgelaeufe(d['eintraege'], d['dateien'])))
        return

    k = konfig_aus_umgebung()
    e = entscheiden(daten_holen(k), k, datetime.now(timezone.utc))
    zeilen = [f"**Merge-Warteschlange:** {e['aktion']} — {e['grund']}"]
    zeilen += [f'- übersprungen {u}' for u in e.get('uebersprungen') or []]
    if e['aktion'] == 'mergen':
        if os.environ.get('TROCKEN'):
            zeilen.append(f"- trocken: #{e['pr']} würde jetzt gemergt ({k['art']})")
        else:
            gestartet = mergen(e, k)
            zeilen.append(f"- gemergt: #{e['pr']} {e['titel']}")
            zeilen.append(f"- gestartet: {', '.join(gestartet) or '—'}")
    _zusammenfassung(zeilen)


if __name__ == '__main__':
    main()
