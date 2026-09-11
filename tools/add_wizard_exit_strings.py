"""
One-shot script: adds the wizard exit / resume strings to every ARB file in
lib/l10n/. Manual translations for de/en/ro/ru/uk; English used as placeholder
for the remaining 23 locales. Idempotent: skips keys that already exist.

Context: the onboarding wizard had no way out. Back walked down to the intro
story, which has no back of its own, and the welcome screen pushed the wizard
again on every launch. These strings back the two deliberate exits ("continue
later" / "cancel the application") and the resume banner that replaces the
forced push.
"""
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
L10N = ROOT / "lib" / "l10n"

WIZARD_EXIT_KEYS = [
    "wizardExitLink",
    "wizardExitSheetTitle",
    "wizardExitSheetBody",
    "wizardExitLater",
    "wizardExitLaterHint",
    "wizardExitAbandon",
    "wizardExitAbandonHint",
    "wizardExitCancel",
    "wizardAbandonDialogTitle",
    "wizardAbandonDialogBody",
    "wizardAbandonKeep",
    "wizardAbandonConfirm",
    "wizardFinalBackToMenu",
    "wizardResumeBannerTitle",
    "wizardResumeBannerBody",
    "wizardResumeBannerAction",
    "wizardResumeBannerPendingTitle",
    "wizardResumeBannerPendingBody",
    "wizardResumeBannerPendingAction",
]

DE = {
    "wizardExitLink": "Anmeldung unterbrechen",
    "wizardExitSheetTitle": "Anmeldung verlassen?",
    "wizardExitSheetBody": "Du hast zwei Möglichkeiten. Wähle die, die zu dir passt.",
    "wizardExitLater": "Später weitermachen",
    "wizardExitLaterHint": "Deine Antworten bleiben gespeichert. Du kannst jederzeit vom Startbildschirm aus weitermachen.",
    "wizardExitAbandon": "Anmeldung abbrechen",
    "wizardExitAbandonHint": "Dein Antrag wird zurückgezogen. Das lässt sich nicht rückgängig machen.",
    "wizardExitCancel": "Doch weitermachen",
    "wizardAbandonDialogTitle": "Anmeldung wirklich abbrechen?",
    "wizardAbandonDialogBody": "Dein Antrag wird als von dir zurückgezogen markiert. Die Daten bleiben aus Auditgründen (DSGVO) gespeichert. Wichtig: Wer sich innerhalb von 90 Tagen dreimal zurückzieht, kann sich nicht mehr allein anmelden und muss den Vorstand ansprechen. Wenn du nur eine Pause brauchst, wähle „Später weitermachen“.",
    "wizardAbandonKeep": "Nein, weitermachen",
    "wizardAbandonConfirm": "Ja, abbrechen",
    "wizardFinalBackToMenu": "Zurück zum Hauptmenü",
    "wizardResumeBannerTitle": "Deine Anmeldung läuft noch",
    "wizardResumeBannerBody": "Du hast eine begonnene Anmeldung. Deine Antworten sind gespeichert — du kannst dort weitermachen, wo du aufgehört hast.",
    "wizardResumeBannerAction": "Weitermachen",
    "wizardResumeBannerPendingTitle": "Dein Antrag wird geprüft",
    "wizardResumeBannerPendingBody": "Der Vorstand prüft deinen Antrag. Du bekommst eine Nachricht, sobald dein Konto aktiv ist.",
    "wizardResumeBannerPendingAction": "Status ansehen",
}

EN = {
    "wizardExitLink": "Pause registration",
    "wizardExitSheetTitle": "Leave the registration?",
    "wizardExitSheetBody": "You have two options. Pick the one that fits.",
    "wizardExitLater": "Continue later",
    "wizardExitLaterHint": "Your answers stay saved. You can pick up again any time from the start screen.",
    "wizardExitAbandon": "Cancel registration",
    "wizardExitAbandonHint": "Your application will be withdrawn. This cannot be undone.",
    "wizardExitCancel": "Keep going",
    "wizardAbandonDialogTitle": "Really cancel the registration?",
    "wizardAbandonDialogBody": "Your application will be marked as withdrawn by you. The data stays stored for audit reasons (GDPR). Important: three withdrawals within 90 days means you can no longer register on your own and will need to talk to the board. If you just need a break, choose “Continue later”.",
    "wizardAbandonKeep": "No, keep going",
    "wizardAbandonConfirm": "Yes, cancel",
    "wizardFinalBackToMenu": "Back to main menu",
    "wizardResumeBannerTitle": "Your registration is still open",
    "wizardResumeBannerBody": "You have a registration in progress. Your answers are saved — you can carry on where you left off.",
    "wizardResumeBannerAction": "Continue",
    "wizardResumeBannerPendingTitle": "Your application is under review",
    "wizardResumeBannerPendingBody": "The board is reviewing your application. You will get a message as soon as your account is active.",
    "wizardResumeBannerPendingAction": "View status",
}

RO = {
    "wizardExitLink": "Întrerup înregistrarea",
    "wizardExitSheetTitle": "Ieși din înregistrare?",
    "wizardExitSheetBody": "Ai două variante. Alege-o pe cea potrivită pentru tine.",
    "wizardExitLater": "Continui mai târziu",
    "wizardExitLaterHint": "Răspunsurile tale rămân salvate. Poți relua oricând din ecranul principal.",
    "wizardExitAbandon": "Renunț la înregistrare",
    "wizardExitAbandonHint": "Cererea ta va fi retrasă. Această acțiune nu poate fi anulată.",
    "wizardExitCancel": "Rămân aici",
    "wizardAbandonDialogTitle": "Sigur renunți la înregistrare?",
    "wizardAbandonDialogBody": "Cererea ta va fi marcată ca retrasă de tine. Datele rămân salvate din motive de audit (GDPR). Important: trei retrageri în 90 de zile înseamnă că nu te mai poți înregistra singur și va trebui să vorbești cu conducerea. Dacă ai nevoie doar de o pauză, alege „Continui mai târziu”.",
    "wizardAbandonKeep": "Nu, continui",
    "wizardAbandonConfirm": "Da, renunț",
    "wizardFinalBackToMenu": "Înapoi la meniul principal",
    "wizardResumeBannerTitle": "Înregistrarea ta e încă deschisă",
    "wizardResumeBannerBody": "Ai o înregistrare începută. Răspunsurile sunt salvate — poți continua de unde ai rămas.",
    "wizardResumeBannerAction": "Continuă",
    "wizardResumeBannerPendingTitle": "Cererea ta este în verificare",
    "wizardResumeBannerPendingBody": "Conducerea îți verifică cererea. Primești un mesaj de îndată ce contul tău este activ.",
    "wizardResumeBannerPendingAction": "Vezi statusul",
}

RU = {
    "wizardExitLink": "Прервать регистрацию",
    "wizardExitSheetTitle": "Выйти из регистрации?",
    "wizardExitSheetBody": "У вас есть два варианта. Выберите подходящий.",
    "wizardExitLater": "Продолжить позже",
    "wizardExitLaterHint": "Ваши ответы сохранятся. Вы сможете продолжить в любой момент с главного экрана.",
    "wizardExitAbandon": "Отменить регистрацию",
    "wizardExitAbandonHint": "Ваша заявка будет отозвана. Это действие необратимо.",
    "wizardExitCancel": "Остаться здесь",
    "wizardAbandonDialogTitle": "Точно отменить регистрацию?",
    "wizardAbandonDialogBody": "Ваша заявка будет отмечена как отозванная вами. Данные останутся сохранёнными для целей аудита (GDPR). Важно: три отзыва за 90 дней означают, что вы больше не сможете зарегистрироваться самостоятельно и вам нужно будет обратиться к правлению. Если вам просто нужен перерыв, выберите «Продолжить позже».",
    "wizardAbandonKeep": "Нет, продолжить",
    "wizardAbandonConfirm": "Да, отменить",
    "wizardFinalBackToMenu": "В главное меню",
    "wizardResumeBannerTitle": "Ваша регистрация не завершена",
    "wizardResumeBannerBody": "У вас есть начатая регистрация. Ответы сохранены — вы можете продолжить с того места, где остановились.",
    "wizardResumeBannerAction": "Продолжить",
    "wizardResumeBannerPendingTitle": "Ваша заявка на проверке",
    "wizardResumeBannerPendingBody": "Правление рассматривает вашу заявку. Вы получите сообщение, как только аккаунт будет активирован.",
    "wizardResumeBannerPendingAction": "Посмотреть статус",
}

UK = {
    "wizardExitLink": "Перервати реєстрацію",
    "wizardExitSheetTitle": "Вийти з реєстрації?",
    "wizardExitSheetBody": "У вас є два варіанти. Оберіть той, що підходить.",
    "wizardExitLater": "Продовжити пізніше",
    "wizardExitLaterHint": "Ваші відповіді залишаться збереженими. Ви зможете продовжити будь-коли з головного екрана.",
    "wizardExitAbandon": "Скасувати реєстрацію",
    "wizardExitAbandonHint": "Вашу заявку буде відкликано. Цю дію не можна скасувати.",
    "wizardExitCancel": "Залишитися тут",
    "wizardAbandonDialogTitle": "Справді скасувати реєстрацію?",
    "wizardAbandonDialogBody": "Вашу заявку буде позначено як відкликану вами. Дані залишаться збереженими для цілей аудиту (GDPR). Важливо: три відкликання за 90 днів означають, що ви більше не зможете зареєструватися самостійно і вам потрібно буде звернутися до правління. Якщо вам просто потрібна перерва, оберіть «Продовжити пізніше».",
    "wizardAbandonKeep": "Ні, продовжити",
    "wizardAbandonConfirm": "Так, скасувати",
    "wizardFinalBackToMenu": "До головного меню",
    "wizardResumeBannerTitle": "Ваша реєстрація ще не завершена",
    "wizardResumeBannerBody": "У вас є розпочата реєстрація. Відповіді збережено — ви можете продовжити з того місця, де зупинилися.",
    "wizardResumeBannerAction": "Продовжити",
    "wizardResumeBannerPendingTitle": "Вашу заявку розглядають",
    "wizardResumeBannerPendingBody": "Правління розглядає вашу заявку. Ви отримаєте повідомлення, щойно акаунт стане активним.",
    "wizardResumeBannerPendingAction": "Переглянути статус",
}

# Locales with manual translations
MANUAL = {
    "en": EN,
    "de": DE,
    "ro": RO,
    "ru": RU,
    "uk": UK,
}


def update_arb(path: Path) -> None:
    data = json.loads(path.read_text(encoding="utf-8"))

    locale = path.stem.replace("app_", "")
    translations = MANUAL.get(locale, EN)  # fallback to English for unsupported

    added = 0
    for key in WIZARD_EXIT_KEYS:
        if key not in data:
            data[key] = translations[key]
            added += 1

    if added == 0:
        print(f"  {path.name}: already present")
        return

    out = json.dumps(data, ensure_ascii=False, indent=2)
    path.write_text(out + "\n", encoding="utf-8")
    print(f"  {path.name}: +{added} keys ({locale}{' MANUAL' if locale in MANUAL else ' EN-fallback'})")


def main():
    arb_files = sorted(L10N.glob("app_*.arb"))
    print(f"Found {len(arb_files)} ARB files")
    for path in arb_files:
        update_arb(path)
    print("Done.")


if __name__ == "__main__":
    main()
