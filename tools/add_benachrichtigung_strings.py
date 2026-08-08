"""
One-shot script: adds the SMS-reminder (Benachrichtigung) strings to the 21
ARB files that are missing them.

These 16 keys existed only in ar/de/en/ro/ru/tr/uk, so `flutter gen-l10n`
reported "16 untranslated message(s)" for every other locale and those users
silently got German text through the template fallback.

Real translations, not English placeholders. The feature asks for consent to
send medication names by SMS - explicitly flagged in the copy as health
information - so a member being asked in a language they do not read is not an
acceptable outcome here.

Inserted after `wizardChatHelpSubtitle`, the key they follow in app_de.arb, so
the block sits in the same place everywhere. Line-based rather than a
json.load/dump round-trip, to keep the diff to the added lines.
"""
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
L10N = ROOT / "lib" / "l10n"

ANCHOR = "wizardChatHelpSubtitle"

KEYS = [
    "benachrichtigungTitel",
    "benachrichtigungIntro",
    "benachrichtigungTermineFrage",
    "benachrichtigungTermineDetail",
    "benachrichtigungMedikamenteFrage",
    "benachrichtigungMedikamenteDetail",
    "benachrichtigungWetterFrage",
    "benachrichtigungWetterDetail",
    "benachrichtigungHinweis",
    "benachrichtigungJa",
    "benachrichtigungNein",
    "benachrichtigungSpaeter",
    "benachrichtigungSpeichern",
    "benachrichtigungGespeichert",
    "benachrichtigungenLeer",
    "benachrichtigungenAlleGelesen",
]

T = {
"bg": ["SMS напомняния",
 "За да не пропуснете среща, сдружението може да Ви изпрати SMS. Вие решавате дали и за какво — и можете да го промените по всяко време.",
 "Желаете ли напомняния за Вашите срещи по SMS?",
 "Съобщението съдържа дата, час, място и тема на срещата.",
 "Желаете ли да Ви напомняме и за лекарствата Ви?",
 "Тогава в съобщението се посочва името на лекарството. Това е здравна информация — затова питаме отделно.",
 "Желаете ли да бъдете предупреждавани при опасно време по местоживеене?",
 "Само официални предупреждения на Германската метеорологична служба от степен „тежко“ нагоре — не при всеки дъжд.",
 "Напомнянето е помощ, а не гаранция: моля, не разчитайте само на него. Можете да промените това по всяко време в профила си.",
 "Да", "Не", "Решаване по-късно", "Запазване", "Благодарим, запазено.",
 "Няма известия", "Отбележи всички като прочетени"],

"cs": ["SMS připomínky",
 "Abyste nezmeškali schůzku, může vám spolek poslat SMS. Vy rozhodujete, zda a k čemu — a kdykoli to můžete změnit.",
 "Přejete si připomínky schůzek prostřednictvím SMS?",
 "Zpráva obsahuje datum, čas, místo a předmět schůzky.",
 "Přejete si připomínat také vaše léky?",
 "Ve zprávě pak bude uveden název léku. To je zdravotní údaj — proto se ptáme zvlášť.",
 "Přejete si varování při nebezpečném počasí ve vašem bydlišti?",
 "Pouze úřední varování Německé meteorologické služby od stupně „silné“ výše — ne při každém dešti.",
 "Připomínka je pomůcka, nikoli záruka: nespoléhejte se prosím pouze na ni. Kdykoli to můžete změnit ve svém profilu.",
 "Ano", "Ne", "Rozhodnout později", "Uložit", "Děkujeme, uloženo.",
 "Žádná oznámení", "Označit vše jako přečtené"],

"da": ["SMS-påmindelser",
 "For at du ikke går glip af en aftale, kan foreningen sende dig en SMS. Du bestemmer, om og hvad — og du kan altid ændre det.",
 "Vil du modtage påmindelser om dine aftaler via SMS?",
 "Beskeden indeholder dato, tidspunkt, sted og emne for aftalen.",
 "Vil du også mindes om din medicin?",
 "Så står medicinens navn i beskeden. Det er en helbredsoplysning — derfor spørger vi særskilt.",
 "Vil du advares om farligt vejr, hvor du bor?",
 "Kun officielle advarsler fra den tyske vejrtjeneste fra niveauet „kraftig“ og opefter — ikke ved hver regnbyge.",
 "Påmindelsen er en hjælp og ingen garanti: stol venligst ikke på den alene. Du kan altid ændre dette i din profil.",
 "Ja", "Nej", "Beslut senere", "Gem", "Tak, gemt.",
 "Ingen notifikationer", "Markér alle som læst"],

"el": ["Υπενθυμίσεις SMS",
 "Για να μη χάσετε κάποιο ραντεβού, ο σύλλογος μπορεί να σας στείλει SMS. Εσείς αποφασίζετε αν και για τι — και μπορείτε να το αλλάξετε οποιαδήποτε στιγμή.",
 "Θέλετε να λαμβάνετε υπενθυμίσεις για τα ραντεβού σας με SMS;",
 "Το μήνυμα περιέχει ημερομηνία, ώρα, τόπο και θέμα του ραντεβού.",
 "Θέλετε να σας υπενθυμίζουμε και τα φάρμακά σας;",
 "Τότε στο μήνυμα αναγράφεται το όνομα του φαρμάκου. Αυτό είναι στοιχείο υγείας — γι' αυτό ρωτάμε ξεχωριστά.",
 "Θέλετε να προειδοποιείστε για κακοκαιρία στον τόπο κατοικίας σας;",
 "Μόνο επίσημες προειδοποιήσεις της Γερμανικής Μετεωρολογικής Υπηρεσίας από το επίπεδο «σοβαρό» και άνω — όχι σε κάθε βροχή.",
 "Η υπενθύμιση είναι βοήθεια και όχι εγγύηση: παρακαλούμε μη βασίζεστε μόνο σε αυτήν. Μπορείτε να το αλλάξετε οποιαδήποτε στιγμή στο προφίλ σας.",
 "Ναι", "Όχι", "Απόφαση αργότερα", "Αποθήκευση", "Ευχαριστούμε, αποθηκεύτηκε.",
 "Καμία ειδοποίηση", "Σήμανση όλων ως αναγνωσμένων"],

"es": ["Recordatorios por SMS",
 "Para que no pierda ninguna cita, la asociación puede enviarle un SMS. Usted decide si lo desea y para qué — y puede cambiarlo en cualquier momento.",
 "¿Desea recibir recordatorios de sus citas por SMS?",
 "El mensaje contiene la fecha, la hora, el lugar y el asunto de la cita.",
 "¿Desea que también le recordemos sus medicamentos?",
 "En ese caso, el nombre del medicamento aparece en el mensaje. Es un dato de salud, por eso lo preguntamos por separado.",
 "¿Desea recibir avisos de temporal en su lugar de residencia?",
 "Solo avisos oficiales del Servicio Meteorológico Alemán a partir del nivel «grave» — no con cada lluvia.",
 "El recordatorio es una ayuda y no una garantía: por favor, no confíe únicamente en él. Puede cambiarlo en cualquier momento en su perfil.",
 "Sí", "No", "Decidir más tarde", "Guardar", "Gracias, guardado.",
 "Sin notificaciones", "Marcar todo como leído"],

"et": ["SMS-meeldetuletused",
 "Et te ei jätaks kohtumist vahele, võib ühing saata teile SMS-i. Teie otsustate, kas ja mille kohta — ja saate seda igal ajal muuta.",
 "Kas soovite oma kohtumiste kohta meeldetuletusi SMS-iga?",
 "Sõnum sisaldab kohtumise kuupäeva, kellaaega, kohta ja teemat.",
 "Kas soovite meeldetuletusi ka oma ravimite kohta?",
 "Siis on sõnumis ravimi nimi. See on terviseandmed — seetõttu küsime eraldi.",
 "Kas soovite hoiatusi ohtliku ilma eest oma elukohas?",
 "Ainult Saksa ilmateenistuse ametlikud hoiatused alates tasemest „raske“ — mitte iga vihma korral.",
 "Meeldetuletus on abi, mitte garantii: palun ärge tuginege ainult sellele. Saate seda igal ajal oma profiilis muuta.",
 "Jah", "Ei", "Otsustan hiljem", "Salvesta", "Aitäh, salvestatud.",
 "Teateid pole", "Märgi kõik loetuks"],

"fi": ["Tekstiviestimuistutukset",
 "Jotta et unohtaisi tapaamista, yhdistys voi lähettää sinulle tekstiviestin. Sinä päätät, haluatko ja mistä — ja voit muuttaa sen milloin tahansa.",
 "Haluatko muistutukset tapaamisistasi tekstiviestillä?",
 "Viesti sisältää tapaamisen päivämäärän, kellonajan, paikan ja aiheen.",
 "Haluatko muistutukset myös lääkkeistäsi?",
 "Silloin viestissä lukee lääkkeen nimi. Se on terveystieto — siksi kysymme erikseen.",
 "Haluatko varoituksen rajuilmasta asuinpaikkakunnallasi?",
 "Vain Saksan ilmatieteen laitoksen viralliset varoitukset tasosta „vakava“ ylöspäin — ei jokaisesta sateesta.",
 "Muistutus on apu eikä takuu: älä luota pelkästään siihen. Voit muuttaa tätä milloin tahansa profiilissasi.",
 "Kyllä", "Ei", "Päätän myöhemmin", "Tallenna", "Kiitos, tallennettu.",
 "Ei ilmoituksia", "Merkitse kaikki luetuiksi"],

"fr": ["Rappels par SMS",
 "Pour que vous ne manquiez aucun rendez-vous, l'association peut vous envoyer un SMS. Vous décidez si et pour quoi — et vous pouvez le modifier à tout moment.",
 "Souhaitez-vous recevoir des rappels de vos rendez-vous par SMS ?",
 "Le message contient la date, l'heure, le lieu et l'objet du rendez-vous.",
 "Souhaitez-vous également être rappelé pour vos médicaments ?",
 "Dans ce cas, le nom du médicament figure dans le message. Il s'agit d'une donnée de santé, c'est pourquoi nous posons la question séparément.",
 "Souhaitez-vous être alerté en cas d'intempéries à votre domicile ?",
 "Uniquement les alertes officielles du service météorologique allemand à partir du niveau « fort » — pas à chaque pluie.",
 "Le rappel est une aide et non une garantie : merci de ne pas vous y fier seul. Vous pouvez modifier cela à tout moment dans votre profil.",
 "Oui", "Non", "Décider plus tard", "Enregistrer", "Merci, enregistré.",
 "Aucune notification", "Tout marquer comme lu"],

"hr": ["SMS podsjetnici",
 "Kako ne biste propustili termin, udruga vam može poslati SMS. Vi odlučujete hoćete li i za što — i to možete promijeniti u svakom trenutku.",
 "Želite li podsjetnike na svoje termine putem SMS-a?",
 "Poruka sadrži datum, vrijeme, mjesto i temu termina.",
 "Želite li podsjetnike i za svoje lijekove?",
 "Tada u poruci stoji naziv lijeka. To je zdravstveni podatak — zato pitamo odvojeno.",
 "Želite li upozorenje na nevrijeme u mjestu stanovanja?",
 "Samo službena upozorenja Njemačke meteorološke službe od stupnja „jako“ naviše — ne pri svakoj kiši.",
 "Podsjetnik je pomoć, a ne jamstvo: molimo, nemojte se oslanjati samo na njega. To možete promijeniti u svakom trenutku u svom profilu.",
 "Da", "Ne", "Odluči kasnije", "Spremi", "Hvala, spremljeno.",
 "Nema obavijesti", "Označi sve kao pročitano"],

"hu": ["SMS-emlékeztetők",
 "Hogy ne maradjon le egy időpontról sem, az egyesület küldhet Önnek SMS-t. Ön dönti el, hogy kér-e és mihez — és ezt bármikor módosíthatja.",
 "Szeretne SMS-ben emlékeztetőt kapni az időpontjairól?",
 "Az üzenet tartalmazza az időpont dátumát, idejét, helyét és tárgyát.",
 "Szeretne emlékeztetőt a gyógyszereiről is?",
 "Ilyenkor a gyógyszer neve szerepel az üzenetben. Ez egészségügyi adat — ezért kérdezzük külön.",
 "Szeretne figyelmeztetést viharos időjárás esetén a lakóhelyén?",
 "Csak a Német Meteorológiai Szolgálat hivatalos figyelmeztetései „súlyos“ fokozattól felfelé — nem minden esőnél.",
 "Az emlékeztető segítség és nem garancia: kérjük, ne csak arra hagyatkozzon. Ezt bármikor módosíthatja a profiljában.",
 "Igen", "Nem", "Döntés később", "Mentés", "Köszönjük, elmentve.",
 "Nincsenek értesítések", "Összes megjelölése olvasottként"],

"it": ["Promemoria via SMS",
 "Per non farle perdere nessun appuntamento, l'associazione può inviarle un SMS. Decide lei se e per cosa — e può modificarlo in qualsiasi momento.",
 "Desidera ricevere promemoria dei suoi appuntamenti via SMS?",
 "Il messaggio contiene data, ora, luogo e oggetto dell'appuntamento.",
 "Desidera ricevere promemoria anche per i suoi farmaci?",
 "In tal caso il nome del farmaco compare nel messaggio. È un dato sanitario, per questo lo chiediamo separatamente.",
 "Desidera essere avvisato in caso di maltempo nel suo luogo di residenza?",
 "Solo avvisi ufficiali del Servizio meteorologico tedesco dal livello «forte» in su — non a ogni pioggia.",
 "Il promemoria è un aiuto e non una garanzia: la preghiamo di non affidarsi solo a esso. Può modificarlo in qualsiasi momento nel suo profilo.",
 "Sì", "No", "Decidere più tardi", "Salva", "Grazie, salvato.",
 "Nessuna notifica", "Segna tutto come letto"],

"lt": ["SMS priminimai",
 "Kad nepraleistumėte susitikimo, asociacija gali atsiųsti jums SMS žinutę. Jūs nusprendžiate, ar ir dėl ko — ir galite tai bet kada pakeisti.",
 "Ar norite gauti priminimus apie savo susitikimus SMS žinute?",
 "Žinutėje nurodoma susitikimo data, laikas, vieta ir tema.",
 "Ar norite priminimų ir apie savo vaistus?",
 "Tada žinutėje nurodomas vaisto pavadinimas. Tai sveikatos duomenys — todėl klausiame atskirai.",
 "Ar norite įspėjimų apie audrą jūsų gyvenamojoje vietoje?",
 "Tik oficialūs Vokietijos meteorologijos tarnybos įspėjimai nuo „stipraus“ lygio — ne per kiekvieną lietų.",
 "Priminimas yra pagalba, o ne garantija: prašome nesiremti vien juo. Tai galite bet kada pakeisti savo profilyje.",
 "Taip", "Ne", "Nuspręsti vėliau", "Išsaugoti", "Ačiū, išsaugota.",
 "Pranešimų nėra", "Žymėti visus kaip perskaitytus"],

"lv": ["SMS atgādinājumi",
 "Lai jūs nepalaistu garām tikšanos, biedrība var nosūtīt jums SMS. Jūs izlemjat, vai un par ko — un varat to jebkurā laikā mainīt.",
 "Vai vēlaties saņemt atgādinājumus par savām tikšanās reizēm ar SMS?",
 "Ziņojumā ir norādīts tikšanās datums, laiks, vieta un temats.",
 "Vai vēlaties atgādinājumus arī par savām zālēm?",
 "Tad ziņojumā ir norādīts zāļu nosaukums. Tie ir veselības dati — tāpēc jautājam atsevišķi.",
 "Vai vēlaties brīdinājumus par negaisu jūsu dzīvesvietā?",
 "Tikai oficiāli Vācijas meteoroloģijas dienesta brīdinājumi no līmeņa „smags“ un augstāk — ne pie katra lietus.",
 "Atgādinājums ir palīgs, nevis garantija: lūdzu, nepaļaujieties tikai uz to. To varat jebkurā laikā mainīt savā profilā.",
 "Jā", "Nē", "Izlemt vēlāk", "Saglabāt", "Paldies, saglabāts.",
 "Nav paziņojumu", "Atzīmēt visus kā izlasītus"],

"nb": ["SMS-påminnelser",
 "For at du ikke skal gå glipp av en avtale, kan foreningen sende deg en SMS. Du bestemmer om og for hva — og du kan endre det når som helst.",
 "Vil du få påminnelser om avtalene dine på SMS?",
 "Meldingen inneholder dato, klokkeslett, sted og tema for avtalen.",
 "Vil du også bli påminnet om medisinene dine?",
 "Da står navnet på medisinen i meldingen. Det er en helseopplysning — derfor spør vi separat.",
 "Vil du bli varslet om uvær der du bor?",
 "Kun offisielle varsler fra den tyske værtjenesten fra nivået „kraftig“ og oppover — ikke ved hvert regnvær.",
 "Påminnelsen er en hjelp og ingen garanti: vennligst ikke stol på den alene. Du kan endre dette når som helst i profilen din.",
 "Ja", "Nei", "Bestem senere", "Lagre", "Takk, lagret.",
 "Ingen varsler", "Merk alle som lest"],

"nl": ["Sms-herinneringen",
 "Zodat u geen afspraak mist, kan de vereniging u een sms sturen. U bepaalt of en waarvoor — en u kunt dit altijd wijzigen.",
 "Wilt u herinneringen aan uw afspraken per sms ontvangen?",
 "Het bericht bevat datum, tijd, plaats en onderwerp van de afspraak.",
 "Wilt u ook aan uw medicijnen herinnerd worden?",
 "Dan staat de naam van het medicijn in het bericht. Dat is een gezondheidsgegeven — daarom vragen we het apart.",
 "Wilt u gewaarschuwd worden bij noodweer op uw woonplaats?",
 "Alleen officiële waarschuwingen van de Duitse weerdienst vanaf niveau „zwaar“ — niet bij elke regenbui.",
 "De herinnering is een hulp en geen garantie: vertrouw er alstublieft niet alleen op. U kunt dit altijd wijzigen in uw profiel.",
 "Ja", "Nee", "Later beslissen", "Opslaan", "Bedankt, opgeslagen.",
 "Geen meldingen", "Alles als gelezen markeren"],

"pl": ["Przypomnienia SMS",
 "Aby nie przegapić wizyty, stowarzyszenie może wysłać Państwu SMS. Decydują Państwo, czy i w jakim zakresie — i mogą to zmienić w każdej chwili.",
 "Czy chcą Państwo otrzymywać przypomnienia o wizytach SMS-em?",
 "Wiadomość zawiera datę, godzinę, miejsce i temat spotkania.",
 "Czy chcą Państwo otrzymywać przypomnienia także o lekach?",
 "Wówczas w wiadomości podana jest nazwa leku. To dana dotycząca zdrowia — dlatego pytamy osobno.",
 "Czy chcą Państwo otrzymywać ostrzeżenia o niebezpiecznej pogodzie w miejscu zamieszkania?",
 "Tylko oficjalne ostrzeżenia Niemieckiej Służby Meteorologicznej od stopnia „silne“ wzwyż — nie przy każdym deszczu.",
 "Przypomnienie jest pomocą, a nie gwarancją: prosimy nie polegać wyłącznie na nim. Można to zmienić w każdej chwili w swoim profilu.",
 "Tak", "Nie", "Zdecyduję później", "Zapisz", "Dziękujemy, zapisano.",
 "Brak powiadomień", "Oznacz wszystkie jako przeczytane"],

"pt": ["Lembretes por SMS",
 "Para que não perca nenhuma marcação, a associação pode enviar-lhe um SMS. É você que decide se e para quê — e pode alterá-lo a qualquer momento.",
 "Deseja receber lembretes das suas marcações por SMS?",
 "A mensagem contém a data, a hora, o local e o assunto da marcação.",
 "Deseja também ser lembrado dos seus medicamentos?",
 "Nesse caso, o nome do medicamento consta da mensagem. Trata-se de um dado de saúde — por isso perguntamos separadamente.",
 "Deseja ser avisado em caso de mau tempo na sua área de residência?",
 "Apenas avisos oficiais do Serviço Meteorológico Alemão a partir do nível «forte» — não em cada chuva.",
 "O lembrete é uma ajuda e não uma garantia: por favor, não confie apenas nele. Pode alterar isto a qualquer momento no seu perfil.",
 "Sim", "Não", "Decidir mais tarde", "Guardar", "Obrigado, guardado.",
 "Sem notificações", "Marcar tudo como lido"],

"sk": ["SMS pripomienky",
 "Aby ste nezmeškali stretnutie, môže vám spolok poslať SMS. Vy rozhodujete, či a na čo — a kedykoľvek to môžete zmeniť.",
 "Želáte si pripomienky svojich stretnutí prostredníctvom SMS?",
 "Správa obsahuje dátum, čas, miesto a predmet stretnutia.",
 "Želáte si pripomínať aj svoje lieky?",
 "V správe potom bude uvedený názov lieku. Je to zdravotný údaj — preto sa pýtame osobitne.",
 "Želáte si varovanie pri nebezpečnom počasí vo vašom bydlisku?",
 "Iba úradné varovania Nemeckej meteorologickej služby od stupňa „silné“ vyššie — nie pri každom daždi.",
 "Pripomienka je pomôcka, nie záruka: nespoliehajte sa prosím iba na ňu. Kedykoľvek to môžete zmeniť vo svojom profile.",
 "Áno", "Nie", "Rozhodnúť neskôr", "Uložiť", "Ďakujeme, uložené.",
 "Žiadne oznámenia", "Označiť všetko ako prečítané"],

"sl": ["Opomniki po SMS",
 "Da ne bi zamudili termina, vam lahko društvo pošlje SMS. Vi se odločite, ali in za kaj — in to lahko kadar koli spremenite.",
 "Želite prejemati opomnike o svojih terminih po SMS?",
 "Sporočilo vsebuje datum, uro, kraj in zadevo termina.",
 "Želite opomnike tudi za svoja zdravila?",
 "Takrat je v sporočilu ime zdravila. To je zdravstveni podatek — zato vprašamo ločeno.",
 "Želite opozorilo ob neurju v kraju bivanja?",
 "Samo uradna opozorila nemške vremenske službe od stopnje „hudo“ naprej — ne ob vsakem dežju.",
 "Opomnik je pomoč in ne jamstvo: prosimo, ne zanašajte se samo nanj. To lahko kadar koli spremenite v svojem profilu.",
 "Da", "Ne", "Odločim se pozneje", "Shrani", "Hvala, shranjeno.",
 "Ni obvestil", "Označi vse kot prebrano"],

"sr": ["SMS подсетници",
 "Да не бисте пропустили термин, удружење може да вам пошаље SMS. Ви одлучујете да ли и за шта — и то можете променити у сваком тренутку.",
 "Желите ли подсетнике на своје термине путем SMS-а?",
 "Порука садржи датум, време, место и тему термина.",
 "Желите ли подсетнике и за своје лекове?",
 "Тада у поруци стоји назив лека. То је здравствени податак — зато питамо одвојено.",
 "Желите ли упозорење на невреме у месту становања?",
 "Само званична упозорења Немачке метеоролошке службе од степена „јако“ навише — не при свакој киши.",
 "Подсетник је помоћ, а не гаранција: молимо вас, немојте се ослањати само на њега. То можете променити у сваком тренутку у свом профилу.",
 "Да", "Не", "Одлучи касније", "Сачувај", "Хвала, сачувано.",
 "Нема обавештења", "Означи све као прочитано"],

"sv": ["SMS-påminnelser",
 "För att du inte ska missa ett möte kan föreningen skicka dig ett SMS. Du bestämmer om och för vad — och du kan ändra det när som helst.",
 "Vill du få påminnelser om dina möten via SMS?",
 "Meddelandet innehåller datum, tid, plats och ämne för mötet.",
 "Vill du även bli påmind om dina mediciner?",
 "Då står medicinens namn i meddelandet. Det är en hälsouppgift — därför frågar vi separat.",
 "Vill du bli varnad vid oväder där du bor?",
 "Endast officiella varningar från den tyska vädertjänsten från nivån „kraftig“ och uppåt — inte vid varje regn.",
 "Påminnelsen är en hjälp och ingen garanti: förlita dig inte enbart på den. Du kan ändra detta när som helst i din profil.",
 "Ja", "Nej", "Bestäm senare", "Spara", "Tack, sparat.",
 "Inga aviseringar", "Markera alla som lästa"],
}


def main() -> None:
    for loc, values in sorted(T.items()):
        path = L10N / f"app_{loc}.arb"
        if not path.exists():
            print(f"skip  {path.name} (nu exista)")
            continue
        if len(values) != len(KEYS):
            raise SystemExit(f"{loc}: {len(values)} traduceri pentru {len(KEYS)} chei")

        text = path.read_text(encoding="utf-8")
        data = json.loads(text)
        present = [k for k in KEYS if k in data]
        if present:
            print(f"skip  {path.name} ({len(present)} chei deja prezente)")
            continue

        lines = text.split("\n")
        idx = next((i for i, ln in enumerate(lines)
                    if ln.lstrip().startswith(f'"{ANCHOR}"')), None)
        if idx is None:
            raise SystemExit(f"{loc}: ancora '{ANCHOR}' nu a fost gasita")
        if not lines[idx].rstrip().endswith(","):
            raise SystemExit(f"{loc}: '{ANCHOR}' e ultima cheie, insertia ar strica JSON-ul")

        block = [f'  {json.dumps(k)}: {json.dumps(v, ensure_ascii=False)},'
                 for k, v in zip(KEYS, values)]
        lines[idx + 1:idx + 1] = block
        updated = "\n".join(lines)

        json.loads(updated)  # refuse to write anything that is not valid JSON
        path.write_text(updated, encoding="utf-8")
        print(f"write {path.name} (+{len(KEYS)} chei)")


if __name__ == "__main__":
    main()
