// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get appName => 'Viikkonro';

  @override
  String get wordmark => 'Viikko nyt';

  @override
  String get home => 'Acasă';

  @override
  String get weeks => 'Săptămâni';

  @override
  String get calendar => 'Calendar';

  @override
  String get tools => 'Calculatoare';

  @override
  String get more => 'Mai mult';

  @override
  String get settings => 'Setări';

  @override
  String get eyebrow => 'INSTRUMENT PENTRU NUMĂRUL SĂPTĂMÂNII';

  @override
  String get homeTitle => 'În ce săptămână suntem?';

  @override
  String get homeLead =>
      'Numere de săptămână, date și zile importante din calendar într-un singur loc.';

  @override
  String get rightNow => 'CHIAR ACUM';

  @override
  String get week => 'Săptămâna';

  @override
  String weekLabel(int number) {
    return 'Săptămâna $number';
  }

  @override
  String weekShort(int number) {
    return 'Săpt. $number';
  }

  @override
  String yearLabel(int number) {
    return 'Anul $number';
  }

  @override
  String weekOf(int current, int total) {
    return 'Săptămâna $current / $total';
  }

  @override
  String yearProgress(int percent) {
    return '$percent % din an a trecut';
  }

  @override
  String get weeksTotal => '52/53 de săptămâni';

  @override
  String get previous => 'Anterior';

  @override
  String get next => 'Următor';

  @override
  String get today => 'Astăzi';

  @override
  String get thisWeek => 'Săptămâna aceasta';

  @override
  String get thisMonth => 'Luna aceasta';

  @override
  String get thisYear => 'Anul acesta';

  @override
  String get lookupTitle => 'Află numărul săptămânii pentru orice dată';

  @override
  String get chooseDate => 'Alege o dată';

  @override
  String get dateToWeek => 'Dată în săptămână';

  @override
  String get weekToDate => 'Săptămână în date';

  @override
  String get weekdayCalculator => 'Ziua săptămânii';

  @override
  String get openWeek => 'Deschide detaliile săptămânii';

  @override
  String get year => 'An';

  @override
  String get month => 'Lună';

  @override
  String get weekNumber => 'Numărul săptămânii';

  @override
  String get dayOfYear => 'Ziua din an';

  @override
  String get daysRemaining => 'Zile rămase';

  @override
  String get quarter => 'Trimestru';

  @override
  String quarterLabel(int number) {
    return 'Trimestrul $number';
  }

  @override
  String get weekRange => 'De luni până duminică';

  @override
  String dayCount(int count) {
    return '$count zile';
  }

  @override
  String weekDaysResult(int weeks, int days) {
    return '$weeks săptămâni și $days zile';
  }

  @override
  String get holidays => 'Zile de sărbătoare';

  @override
  String get flagDays => 'Zile de arborare a drapelului';

  @override
  String get schoolHolidays => 'Vacanțe școlare';

  @override
  String get nextHoliday => 'Următoarea sărbătoare';

  @override
  String get noEvents => 'Nicio zi marcantă';

  @override
  String get official => 'Sărbătoare legală';

  @override
  String get observance => 'Zi marcantă';

  @override
  String get all => 'Toate';

  @override
  String get confirmed => 'Confirmat';

  @override
  String get estimated => 'estimat';

  @override
  String get unknown => 'Încă nepublicat';

  @override
  String get noSchoolData =>
      'Nu există date publicate despre vacanțele școlare pentru acest an.';

  @override
  String get schoolCoverage =>
      'Datele școlii tale pot diferi de calendarul municipal.';

  @override
  String get winterBreak => 'Vacanța de iarnă';

  @override
  String get autumnBreak => 'Vacanța de toamnă';

  @override
  String get city => 'Oraș';

  @override
  String get source => 'Sursă';

  @override
  String verifiedAt(String date) {
    return 'Verificat la $date';
  }

  @override
  String get daysBetween => 'Zile între date';

  @override
  String get workingDaysBetween => 'Calculator de zile lucrătoare';

  @override
  String get workingDays => 'Zile lucrătoare';

  @override
  String get weekends => 'Weekenduri';

  @override
  String get weekdayHolidays => 'Sărbători în zilele lucrătoare';

  @override
  String get totalDays => 'Zile în total';

  @override
  String get firstDate => 'Data de început';

  @override
  String get lastDate => 'Data de sfârșit';

  @override
  String get invalidRange =>
      'Data de sfârșit trebuie să fie aceeași sau ulterioară celei de început.';

  @override
  String get distanceNote =>
      'Rezultatul este distanța dintre date. Ordinea nu contează.';

  @override
  String get workingNote =>
      'Ambele date sunt incluse. Zilele lucrătoare sunt de luni până vineri, fără sărbătorile legale. Ajunul Crăciunului și ajunul Sânzienelor se consideră zile lucrătoare.';

  @override
  String get yearWeeks => 'Toate săptămânile anului';

  @override
  String get yearCalendar => 'Calendar anual';

  @override
  String get firstHalf => 'Primul semestru';

  @override
  String get secondHalf => 'Al doilea semestru';

  @override
  String get wholeYear => 'Tot anul';

  @override
  String get yearWorkingDays => 'Zile lucrătoare pe an';

  @override
  String get monthWorkingDays => 'Zile lucrătoare pe lună';

  @override
  String get share => 'Distribuie';

  @override
  String get openWebsite => 'Deschide site-ul';

  @override
  String get copy => 'Copiază';

  @override
  String get copied => 'Copiat';

  @override
  String get printPdf => 'Tipărește / salvează PDF';

  @override
  String get exportCsv => 'Exportă CSV';

  @override
  String get exportCalendar => 'Exportă calendarul (.ics)';

  @override
  String get exportFailed => 'Exportul a eșuat. Încearcă din nou.';

  @override
  String get openFailed => 'Linkul nu a putut fi deschis.';

  @override
  String get language => 'Limbă';

  @override
  String get finnish => 'Finlandeză';

  @override
  String get english => 'Engleză';

  @override
  String get theme => 'Aspect';

  @override
  String get system => 'Sistem';

  @override
  String get light => 'Luminos';

  @override
  String get dark => 'Întunecat';

  @override
  String get firstScreen => 'Ecran de pornire';

  @override
  String get privacyNote =>
      'Funcționează offline. Nu necesită cont. Aplicația folosește rapoarte de blocare, analiză și reclame cu opțiuni de confidențialitate.';

  @override
  String get dataCoverage =>
      'Date de calendar: 2020–2035. Vacanțele școlare sunt disponibile doar pentru anii publicați.';

  @override
  String get about => 'Despre aplicație';

  @override
  String get licenses => 'Licențe open source';

  @override
  String get info => 'Despre numerele săptămânilor';

  @override
  String get faq => 'Întrebări frecvente';

  @override
  String get methodology => 'Metodologie';

  @override
  String get sources => 'Surse de date';

  @override
  String get editorial => 'Principii editoriale';

  @override
  String get usComparison => 'Finlanda și SUA';

  @override
  String get isoWeek => 'Săptămâna ISO';

  @override
  String get usWeek => 'Săptămâna americană';

  @override
  String get isoExplanation =>
      'Săptămâna începe luni. Prima săptămână ISO a anului conține 4 ianuarie. Anul ISO poate diferi de anul calendaristic.';

  @override
  String get openData => 'Date deschise';

  @override
  String get dataExplorer => 'Explorează datele calendarului';

  @override
  String get bundledData => 'Set de date inclus';

  @override
  String get dataCopyNote => 'Copiază anul selectat în format JSON.';

  @override
  String get websiteResources => 'Mai multe pe site';

  @override
  String get websiteResourcesNote =>
      'Celelalte servicii ale site-ului se deschid în browser și necesită conexiune la internet.';

  @override
  String get contact => 'Contact';

  @override
  String get privacy => 'Confidențialitate';

  @override
  String get terms => 'Termeni';

  @override
  String get timeManagement => 'Gestionarea timpului';

  @override
  String get sun => 'Soarele la Helsinki';

  @override
  String get sunrise => 'Răsărit';

  @override
  String get sunset => 'Apus';

  @override
  String get daylight => 'Durata zilei';

  @override
  String get polarDay => 'Soare de miezul nopții';

  @override
  String get polarNight => 'Noapte polară';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get weekNotes => 'Notiță săptămânală';

  @override
  String get noteHint => 'Scrie o notiță pentru această săptămână…';

  @override
  String get saved => 'Salvat pe acest dispozitiv';

  @override
  String get save => 'Salvează';

  @override
  String get cancel => 'Anulează';

  @override
  String get notFound => 'Pagina nu a fost găsită';

  @override
  String get outOfRange => 'Alege un an între 2020 și 2035.';

  @override
  String get backHome => 'Înapoi acasă';

  @override
  String get loadingError => 'Datele calendarului nu au putut fi încărcate.';

  @override
  String get retry => 'Reîncearcă';

  @override
  String get menu => 'Deschide meniul';

  @override
  String get dayDetails => 'Detaliile zilei';

  @override
  String get close => 'Închide';

  @override
  String get holidayRule => 'Regula datei';

  @override
  String get fiContent => 'Materialul sursă al site-ului este în finlandeză.';

  @override
  String get nameDaysUnavailable =>
      'Zilele onomastice vor fi adăugate după verificarea licenței.';

  @override
  String get weekList => 'Lista săptămânilor';
}
