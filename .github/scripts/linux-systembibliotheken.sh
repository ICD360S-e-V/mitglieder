#!/usr/bin/env bash
# Listet die SYSTEM-Bibliotheken, die ein Linux-Bundle braucht: alle
# NEEDED-Eintraege der ausfuehrbaren Datei und von lib/*.so*, ohne die, die
# das Bundle selbst mitbringt. Eine Zeile je Bibliothek, sortiert.
#
# Wozu: das RPM zaehlt seine Abhaengigkeiten von Hand auf (`AutoReq: no` in
# build.yml). Bringt ein Plugin-Update eine NEUE Systembibliothek mit, bleibt
# der Bau gruen — aber die App startet auf einem Rechner ohne sie nicht.
# deps-update.yml vergleicht diese Liste vor und nach dem Anheben und hebt
# nicht an, wenn eine dazukommt.
set -euo pipefail

B=${1:?Aufruf: $0 <bundle-ordner>   (z. B. build/linux/x64/debug/bundle)}
if [ ! -d "$B/lib" ]; then
  echo "Kein Bundle unter $B (lib/ fehlt)." >&2
  exit 2
fi

# Was das Bundle mitbringt: Dateinamen UND SONAMEs — ein NEEDED-Eintrag nennt
# den SONAME (libfoo.so.1), die Datei kann laenger heissen (libfoo.so.1.22.0).
eigene=$(
  for f in "$B"/lib/*.so*; do
    [ -f "$f" ] || continue
    basename "$f"
    readelf -d "$f" 2>/dev/null | sed -n 's/.*(SONAME).*\[\(.*\)\]/\1/p' || true
  done | sort -u
)

# Die ausfuehrbare Datei liegt direkt im Bundle, alles andere unter lib/.
# ⚠️ Nicht auf das x-Bit achten: ein Bundle aus einem Actions-Artefakt hat es
# nicht mehr (upload-artifact speichert keine Dateirechte). readelf sagt ohnehin
# nichts zu Dateien, die kein ELF sind.
for f in "$B"/* "$B"/lib/*.so*; do
  [ -f "$f" ] || continue
  # `|| true`: readelf scheitert an allem, was kein ELF ist — mit pipefail und
  # -e bräche sonst die Schleife dort ab, und alles danach fehlte.
  readelf -d "$f" 2>/dev/null | sed -n 's/.*(NEEDED).*\[\(.*\)\]/\1/p' || true
done | sort -u | while read -r so; do
  if ! grep -qxF -- "$so" <<<"$eigene"; then
    echo "$so"
  fi
done
