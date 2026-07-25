"""
One-shot script: adds the automatic-update consent strings to every ARB file
in lib/l10n/. Manual translations for de/en/ro/ru/uk; English used as
placeholder for the remaining 23 locales. Idempotent: skips files that already
contain the keys.

The new keys are inserted right after `appWillRestart` so the update block in
each ARB stays contiguous, and the `@autoUpdateInstalling` placeholder metadata
is written to every file (all locales here carry metadata, not just the
app_de.arb template).

Insertion is line-based rather than a json.load/json.dump round-trip: a few
existing metadata blocks use a compact one-line style that json.dumps would
expand, turning a 3-key addition into a diff across every ARB for no reason.
The result is still validated as JSON before being written.
"""
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
L10N = ROOT / "lib" / "l10n"

# Insert directly after this existing key to keep the update strings together.
ANCHOR = "appWillRestart"

KEYS = [
    "autoUpdateEnableTitle",
    "autoUpdateEnableHint",
    "autoUpdateInstalling",
]

METADATA = {
    "@autoUpdateInstalling": {"placeholders": {"version": {"type": "String"}}},
}

EN = {
    "autoUpdateEnableTitle": "Install future updates automatically",
    "autoUpdateEnableHint": "The app downloads and installs updates on its own and restarts briefly. No further prompts.",
    "autoUpdateInstalling": "Version {version} is being installed in the background. The app will restart shortly.",
}

DE = {
    "autoUpdateEnableTitle": "Zukünftige Updates automatisch installieren",
    "autoUpdateEnableHint": "Die App lädt Updates selbständig herunter, installiert sie und startet kurz neu. Ohne weitere Rückfragen.",
    "autoUpdateInstalling": "Version {version} wird im Hintergrund installiert. Die App startet gleich neu.",
}

RO = {
    "autoUpdateEnableTitle": "Instalează automat actualizările viitoare",
    "autoUpdateEnableHint": "Aplicația descarcă și instalează actualizările singură și repornește pentru scurt timp. Fără alte întrebări.",
    "autoUpdateInstalling": "Versiunea {version} se instalează în fundal. Aplicația va reporni imediat.",
}

RU = {
    "autoUpdateEnableTitle": "Автоматически устанавливать будущие обновления",
    "autoUpdateEnableHint": "Приложение само загрузит и установит обновления и ненадолго перезапустится. Без дополнительных вопросов.",
    "autoUpdateInstalling": "Версия {version} устанавливается в фоновом режиме. Приложение скоро перезапустится.",
}

UK = {
    "autoUpdateEnableTitle": "Автоматично встановлювати майбутні оновлення",
    "autoUpdateEnableHint": "Застосунок сам завантажить і встановить оновлення та ненадовго перезапуститься. Без додаткових запитань.",
    "autoUpdateInstalling": "Версія {version} встановлюється у фоновому режимі. Застосунок скоро перезапуститься.",
}

TRANSLATIONS = {"de": DE, "en": EN, "ro": RO, "ru": RU, "uk": UK}


def locale_of(path: Path) -> str:
    return path.stem.removeprefix("app_")


def block_for(strings: dict) -> list[str]:
    """The literal lines to splice in, matching the ARBs' 2-space style."""
    lines = []
    for key in KEYS:
        lines.append(f'  {json.dumps(key)}: {json.dumps(strings[key], ensure_ascii=False)},')
        meta_key = "@" + key
        if meta_key in METADATA:
            rendered = json.dumps(METADATA[meta_key], ensure_ascii=False, indent=2)
            # Re-indent the nested object to sit at the ARB's top-level depth.
            body = "\n".join("  " + ln for ln in rendered.splitlines())
            lines.append(f'  {json.dumps(meta_key)}: {body.lstrip()},')
    return lines


def main() -> None:
    for path in sorted(L10N.glob("app_*.arb")):
        text = path.read_text(encoding="utf-8")
        data = json.loads(text)
        if all(k in data for k in KEYS):
            print(f"skip  {path.name} (already present)")
            continue

        strings = TRANSLATIONS.get(locale_of(path), EN)
        lines = text.splitlines()
        anchor_idx = next(
            (i for i, ln in enumerate(lines) if ln.lstrip().startswith(f'"{ANCHOR}"')),
            None,
        )
        if anchor_idx is None:
            raise SystemExit(f"{path.name}: anchor key '{ANCHOR}' not found")
        if not lines[anchor_idx].rstrip().endswith(","):
            raise SystemExit(f"{path.name}: '{ANCHOR}' is the last key - insertion would break JSON")

        lines[anchor_idx + 1 : anchor_idx + 1] = block_for(strings)
        updated = "\n".join(lines) + "\n"

        # Fail loudly rather than writing a corrupt ARB that only surfaces as a
        # cryptic gen-l10n error later.
        json.loads(updated)
        path.write_text(updated, encoding="utf-8")

        translated = "translated" if locale_of(path) in TRANSLATIONS else "en-placeholder"
        print(f"write {path.name} ({translated})")


if __name__ == "__main__":
    main()
