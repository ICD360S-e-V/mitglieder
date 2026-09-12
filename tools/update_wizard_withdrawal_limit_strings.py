"""
One-shot script: der Abbruch-Dialog nennt jetzt 10 statt drei Rueckzuege.

Anlass: die Zahl im Text stimmte mit keiner Zahl im Code ueberein.
check_age.php sperrte beim ERSTEN Rueckzug im 90-Tage-Fenster, finalize.php
erst beim dritten, und der Dialog versprach drei. Seit RueckzugFenster::GRENZE
zaehlen beide Enden dasselbe — und der Text muss dieselbe Zahl nennen.

Absichtlich als Ziffer „10" und nicht ausgeschrieben: die Beschriftung steht
in 28 Sprachen, davon 23 auf Englisch, und eine Ziffer liest auch, wer den
Satz drumherum nicht lesen kann.

Ueberschreibt den Schluessel (anders als die add_*-Skripte, die nur
hinzufuegen). Idempotent: laeuft der Text schon so, bleibt die Datei liegen.
"""
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
L10N = ROOT / "lib" / "l10n"

KEY = "wizardAbandonDialogBody"

EN = (
    "Your application will be marked as withdrawn by you. The data stays "
    "stored for audit reasons (GDPR). Important: 10 withdrawals within 90 "
    "days means you can no longer register on your own and will need to "
    "talk to the board. If you just need a break, choose “Continue "
    "later”."
)

MANUAL = {
    "en": EN,
    "de": (
        "Dein Antrag wird als von dir zurückgezogen markiert. Die Daten "
        "bleiben aus Auditgründen (DSGVO) gespeichert. Wichtig: Wer sich "
        "innerhalb von 90 Tagen 10-mal zurückzieht, kann sich nicht mehr "
        "allein anmelden und muss den Vorstand ansprechen. Wenn du nur eine "
        "Pause brauchst, wähle „Später weitermachen“."
    ),
    "ro": (
        "Cererea ta va fi marcată ca retrasă de tine. Datele rămân "
        "salvate din motive de audit (GDPR). Important: 10 retrageri în 90 "
        "de zile înseamnă că nu te mai poți înregistra singur și va trebui "
        "să vorbești cu conducerea. Dacă ai nevoie doar de o pauză, alege "
        "„Continui mai târziu”."
    ),
    "ru": (
        "Ваша заявка будет отмечена как отозванная вами. Данные "
        "останутся сохранёнными для целей аудита (GDPR). Важно: 10 "
        "отзывов за 90 дней означают, что вы больше не сможете "
        "зарегистрироваться самостоятельно и вам нужно будет "
        "обратиться к правлению. Если вам просто нужен перерыв, "
        "выберите «Продолжить позже»."
    ),
    "uk": (
        "Вашу заявку буде позначено як відкликану вами. Дані "
        "залишаться збереженими для цілей аудиту (GDPR). Важливо: 10 "
        "відкликань за 90 днів означають, що ви більше не зможете "
        "зареєструватися самостійно і вам потрібно буде "
        "звернутися до правління. Якщо вам просто потрібна "
        "перерва, оберіть «Продовжити пізніше»."
    ),
}


def update_arb(path: Path) -> None:
    data = json.loads(path.read_text(encoding="utf-8"))
    locale = path.stem.replace("app_", "")
    text = MANUAL.get(locale, EN)

    if data.get(KEY) == text:
        print(f"  {path.name}: schon aktuell")
        return
    if KEY not in data:
        print(f"  {path.name}: WARNUNG — {KEY} fehlt, nichts geaendert")
        return

    data[KEY] = text
    path.write_text(
        json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    print(f"  {path.name}: aktualisiert "
          f"({locale}{' MANUAL' if locale in MANUAL else ' EN-fallback'})")


def main():
    files = sorted(L10N.glob("app_*.arb"))
    print(f"{len(files)} ARB-Dateien")
    for p in files:
        update_arb(p)
    print("Fertig.")


if __name__ == "__main__":
    main()
