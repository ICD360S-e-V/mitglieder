"""
Inject the two new call-error keys into every ARB. Manual translations for
de/en/ro/ru/uk; English used as fallback for the other 23. Idempotent.
"""
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
L10N = ROOT / "lib" / "l10n"

KEYS = [
    "callErrorMicPermissionDenied",
    "callErrorMicNotFound",
]

EN = {
    "callErrorMicPermissionDenied": "Microphone access is blocked. Enable it in Windows Settings → Privacy → Microphone (or your system's privacy settings), then try again.",
    "callErrorMicNotFound": "No microphone was found. Connect a headset or microphone and try again.",
}

DE = {
    "callErrorMicPermissionDenied": "Mikrofonzugriff ist blockiert. Aktivieren Sie ihn in Windows-Einstellungen → Datenschutz → Mikrofon (oder den Datenschutz-Einstellungen Ihres Systems) und versuchen Sie es erneut.",
    "callErrorMicNotFound": "Kein Mikrofon gefunden. Schließen Sie ein Headset oder Mikrofon an und versuchen Sie es erneut.",
}

RO = {
    "callErrorMicPermissionDenied": "Accesul la microfon este blocat. Activeaza-l in Windows Settings → Privacy → Microphone (sau setarile de confidentialitate ale sistemului tau) si incearca din nou.",
    "callErrorMicNotFound": "Nu a fost gasit niciun microfon. Conecteaza casti sau un microfon si incearca din nou.",
}

RU = {
    "callErrorMicPermissionDenied": "Доступ к микрофону заблокирован. Включите его в Windows Settings → Privacy → Microphone (или в настройках конфиденциальности вашей системы) и попробуйте снова.",
    "callErrorMicNotFound": "Микрофон не найден. Подключите гарнитуру или микрофон и попробуйте снова.",
}

UK = {
    "callErrorMicPermissionDenied": "Доступ до мікрофона заблоковано. Увімкніть його в Windows Settings → Privacy → Microphone (або в налаштуваннях конфіденційності вашої системи) і спробуйте знову.",
    "callErrorMicNotFound": "Мікрофон не знайдено. Під'єднайте гарнітуру або мікрофон і спробуйте знову.",
}

MANUAL = {"en": EN, "de": DE, "ro": RO, "ru": RU, "uk": UK}


def update_arb(path: Path) -> None:
    data = json.loads(path.read_text(encoding="utf-8"))
    locale = path.stem.replace("app_", "")
    translations = MANUAL.get(locale, EN)
    added = 0
    for key in KEYS:
        if key not in data:
            data[key] = translations[key]
            added += 1
    if added == 0:
        print(f"  {path.name}: already present")
        return
    out = json.dumps(data, ensure_ascii=False, indent=2)
    path.write_text(out + "\n", encoding="utf-8")
    print(f"  {path.name}: +{added} ({locale}{' MANUAL' if locale in MANUAL else ' EN-fallback'})")


def main():
    arb_files = sorted(L10N.glob("app_*.arb"))
    print(f"Found {len(arb_files)} ARB files")
    for path in arb_files:
        update_arb(path)
    print("Done.")


if __name__ == "__main__":
    main()
