"""
One-shot script: adds security banner / permission dialog strings to every
ARB file in lib/l10n/. Manual translations for de/en/ro/ru/uk; English used
as placeholder for the remaining 23 locales. Idempotent: skips files that
already contain the keys.
"""
import json
import os
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
L10N = ROOT / "lib" / "l10n"

SECURITY_KEYS = [
    "securityBannerTlsInterception",
    "securityBannerDnsFailure",
    "securityBannerCaptivePortal",
    "securityBannerSlowNetwork",
    "securityBannerNetworkOffline",
    "securityPermissionDialogTitle",
    "securityPermissionDialogBody",
    "securityPermissionDialogAllow",
    "securityPermissionDialogDeny",
]

EN = {
    "securityBannerTlsInterception": "Your network is intercepting secure connections. Switch networks or disable VPN/antivirus.",
    "securityBannerDnsFailure": "DNS problem detected. Check your connection or try another network.",
    "securityBannerCaptivePortal": "Please open your browser and sign in to the WiFi.",
    "securityBannerSlowNetwork": "Slow connection.",
    "securityBannerNetworkOffline": "No network connection.",
    "securityPermissionDialogTitle": "Possible network attack detected",
    "securityPermissionDialogBody": "Something on your network may be intercepting connections. To identify the network and protect you, we need permission to read the WiFi name. No location tracking.",
    "securityPermissionDialogAllow": "Allow",
    "securityPermissionDialogDeny": "Not now",
}

DE = {
    "securityBannerTlsInterception": "Ihr Netzwerk fängt sichere Verbindungen ab. Bitte wechseln Sie das Netzwerk oder deaktivieren Sie VPN/Antivirus.",
    "securityBannerDnsFailure": "DNS-Problem erkannt. Prüfen Sie Ihre Verbindung oder wechseln Sie das Netzwerk.",
    "securityBannerCaptivePortal": "Bitte öffnen Sie Ihren Browser und melden Sie sich beim WLAN an.",
    "securityBannerSlowNetwork": "Langsame Verbindung.",
    "securityBannerNetworkOffline": "Keine Netzwerkverbindung.",
    "securityPermissionDialogTitle": "Möglicher Netzwerkangriff erkannt",
    "securityPermissionDialogBody": "Etwas in Ihrem Netzwerk fängt möglicherweise Verbindungen ab. Um das Netzwerk zu identifizieren und Sie zu schützen, benötigen wir die Berechtigung, den WLAN-Namen zu lesen. Keine Standortverfolgung.",
    "securityPermissionDialogAllow": "Erlauben",
    "securityPermissionDialogDeny": "Jetzt nicht",
}

RO = {
    "securityBannerTlsInterception": "Reteaua ta intercepteaza conexiunile securizate. Schimba reteaua sau dezactiveaza VPN-ul/antivirusul.",
    "securityBannerDnsFailure": "Problema DNS detectata. Verifica conexiunea sau incearca alta retea.",
    "securityBannerCaptivePortal": "Deschide browser-ul si conecteaza-te la WiFi.",
    "securityBannerSlowNetwork": "Conexiune lenta.",
    "securityBannerNetworkOffline": "Fara conexiune la retea.",
    "securityPermissionDialogTitle": "Posibil atac de retea detectat",
    "securityPermissionDialogBody": "Ceva din reteaua ta ar putea intercepta conexiunile. Pentru a identifica reteaua si a te proteja, avem nevoie de permisiunea de a citi numele WiFi. Fara urmarirea locatiei.",
    "securityPermissionDialogAllow": "Permite",
    "securityPermissionDialogDeny": "Nu acum",
}

RU = {
    "securityBannerTlsInterception": "Ваша сеть перехватывает защищённые соединения. Смените сеть или отключите VPN/антивирус.",
    "securityBannerDnsFailure": "Обнаружена проблема с DNS. Проверьте соединение или смените сеть.",
    "securityBannerCaptivePortal": "Откройте браузер и войдите в Wi-Fi.",
    "securityBannerSlowNetwork": "Медленное соединение.",
    "securityBannerNetworkOffline": "Нет соединения с сетью.",
    "securityPermissionDialogTitle": "Обнаружена возможная атака на сеть",
    "securityPermissionDialogBody": "Что-то в вашей сети может перехватывать соединения. Чтобы определить сеть и защитить вас, нам нужно разрешение читать имя Wi-Fi. Никакого отслеживания местоположения.",
    "securityPermissionDialogAllow": "Разрешить",
    "securityPermissionDialogDeny": "Не сейчас",
}

UK = {
    "securityBannerTlsInterception": "Ваша мережа перехоплює захищені з'єднання. Змініть мережу або вимкніть VPN/антивірус.",
    "securityBannerDnsFailure": "Виявлено проблему з DNS. Перевірте з'єднання або спробуйте іншу мережу.",
    "securityBannerCaptivePortal": "Відкрийте браузер і увійдіть у Wi-Fi.",
    "securityBannerSlowNetwork": "Повільне з'єднання.",
    "securityBannerNetworkOffline": "Немає з'єднання з мережею.",
    "securityPermissionDialogTitle": "Виявлено можливу мережеву атаку",
    "securityPermissionDialogBody": "Щось у вашій мережі може перехоплювати з'єднання. Щоб ідентифікувати мережу та захистити вас, потрібен дозвіл на читання назви Wi-Fi. Без відстеження місцезнаходження.",
    "securityPermissionDialogAllow": "Дозволити",
    "securityPermissionDialogDeny": "Не зараз",
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
    raw = path.read_text(encoding="utf-8")
    data = json.loads(raw)

    locale = path.stem.replace("app_", "")
    translations = MANUAL.get(locale, EN)  # fallback to English for unsupported

    added = 0
    for key in SECURITY_KEYS:
        if key not in data:
            data[key] = translations[key]
            added += 1

    if added == 0:
        print(f"  {path.name}: already present")
        return

    # Write back with stable formatting matching existing files
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
