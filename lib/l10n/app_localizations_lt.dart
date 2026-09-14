// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class AppLocalizationsLt extends AppLocalizations {
  AppLocalizationsLt([String locale = 'lt']) : super(locale);

  @override
  String get appName => 'Viikkonro';

  @override
  String get wordmark => 'Viikko nyt';

  @override
  String get home => 'Pradžia';

  @override
  String get weeks => 'Savaitės';

  @override
  String get calendar => 'Kalendorius';

  @override
  String get tools => 'Skaičiuoklės';

  @override
  String get more => 'Daugiau';

  @override
  String get settings => 'Nustatymai';

  @override
  String get eyebrow => 'SAVAITĖS NUMERIO ĮRANKIS';

  @override
  String get homeTitle => 'Kuri dabar savaitė?';

  @override
  String get homeLead =>
      'Savaičių numeriai, datos ir svarbios kalendoriaus dienos vienoje vietoje.';

  @override
  String get rightNow => 'KAIP TIK DABAR';

  @override
  String get week => 'Savaitė';

  @override
  String weekLabel(int number) {
    return 'Savaitė $number';
  }

  @override
  String weekShort(int number) {
    return 'Sav. $number';
  }

  @override
  String yearLabel(int number) {
    return 'Metai $number';
  }

  @override
  String weekOf(int current, int total) {
    return 'Savaitė $current / $total';
  }

  @override
  String yearProgress(int percent) {
    return 'Praėjo $percent % metų';
  }

  @override
  String get weeksTotal => '52/53 savaitės';

  @override
  String get previous => 'Ankstesnė';

  @override
  String get next => 'Kita';

  @override
  String get today => 'Šiandien';

  @override
  String get thisWeek => 'Ši savaitė';

  @override
  String get thisMonth => 'Šis mėnuo';

  @override
  String get thisYear => 'Šie metai';

  @override
  String get lookupTitle => 'Sužinokite bet kurios datos savaitės numerį';

  @override
  String get chooseDate => 'Pasirinkite datą';

  @override
  String get dateToWeek => 'Data į savaitę';

  @override
  String get weekToDate => 'Savaitė į datas';

  @override
  String get weekdayCalculator => 'Savaitės diena';

  @override
  String get openWeek => 'Atverti savaitės informaciją';

  @override
  String get year => 'Metai';

  @override
  String get month => 'Mėnuo';

  @override
  String get weekNumber => 'Savaitės numeris';

  @override
  String get dayOfYear => 'Metų diena';

  @override
  String get daysRemaining => 'Liko dienų';

  @override
  String get quarter => 'Ketvirtis';

  @override
  String quarterLabel(int number) {
    return '$number ketvirtis';
  }

  @override
  String get weekRange => 'Nuo pirmadienio iki sekmadienio';

  @override
  String dayCount(int count) {
    return '$count d.';
  }

  @override
  String weekDaysResult(int weeks, int days) {
    return '$weeks sav. ir $days d.';
  }

  @override
  String get holidays => 'Švenčių dienos';

  @override
  String get flagDays => 'Vėliavos dienos';

  @override
  String get schoolHolidays => 'Mokinių atostogos';

  @override
  String get nextHoliday => 'Artimiausia šventė';

  @override
  String get noEvents => 'Atmintinų dienų nėra';

  @override
  String get official => 'Oficiali šventė';

  @override
  String get observance => 'Atmintina diena';

  @override
  String get all => 'Visos';

  @override
  String get confirmed => 'Patvirtinta';

  @override
  String get estimated => 'apytikslė';

  @override
  String get unknown => 'Dar nepaskelbta';

  @override
  String get noSchoolData =>
      'Šiems metams paskelbtų mokinių atostogų duomenų nėra.';

  @override
  String get schoolCoverage =>
      'Jūsų mokyklos datos gali skirtis nuo savivaldybės kalendoriaus.';

  @override
  String get winterBreak => 'Žiemos atostogos';

  @override
  String get autumnBreak => 'Rudens atostogos';

  @override
  String get city => 'Miestas';

  @override
  String get source => 'Šaltinis';

  @override
  String verifiedAt(String date) {
    return 'Patikrinta $date';
  }

  @override
  String get daysBetween => 'Dienos tarp datų';

  @override
  String get workingDaysBetween => 'Darbo dienų skaičiuoklė';

  @override
  String get workingDays => 'Darbo dienos';

  @override
  String get weekends => 'Savaitgaliai';

  @override
  String get weekdayHolidays => 'Šventės darbo dienomis';

  @override
  String get totalDays => 'Iš viso dienų';

  @override
  String get firstDate => 'Pradžios data';

  @override
  String get lastDate => 'Pabaigos data';

  @override
  String get invalidRange =>
      'Pabaigos data turi sutapti su pradžios data arba būti vėlesnė.';

  @override
  String get distanceNote =>
      'Rezultatas yra atstumas tarp datų. Eiliškumas nesvarbus.';

  @override
  String get workingNote =>
      'Įskaičiuojamos abi datos. Darbo dienos – nuo pirmadienio iki penktadienio, išskyrus oficialias šventes. Kūčios ir Joninių išvakarės laikomos darbo dienomis.';

  @override
  String get yearWeeks => 'Visos metų savaitės';

  @override
  String get yearCalendar => 'Metų kalendorius';

  @override
  String get firstHalf => 'Pirmas pusmetis';

  @override
  String get secondHalf => 'Antras pusmetis';

  @override
  String get wholeYear => 'Visi metai';

  @override
  String get yearWorkingDays => 'Darbo dienos per metus';

  @override
  String get monthWorkingDays => 'Darbo dienos per mėnesį';

  @override
  String get share => 'Bendrinti';

  @override
  String get openWebsite => 'Atverti svetainę';

  @override
  String get copy => 'Kopijuoti';

  @override
  String get copied => 'Nukopijuota';

  @override
  String get printPdf => 'Spausdinti / įrašyti PDF';

  @override
  String get exportCsv => 'Eksportuoti CSV';

  @override
  String get exportCalendar => 'Eksportuoti kalendorių (.ics)';

  @override
  String get exportFailed => 'Eksportuoti nepavyko. Bandykite dar kartą.';

  @override
  String get openFailed => 'Nepavyko atverti nuorodos.';

  @override
  String get language => 'Kalba';

  @override
  String get finnish => 'Suomių';

  @override
  String get english => 'Anglų';

  @override
  String get theme => 'Išvaizda';

  @override
  String get system => 'Sistemos';

  @override
  String get light => 'Šviesi';

  @override
  String get dark => 'Tamsi';

  @override
  String get firstScreen => 'Pradinis rodinys';

  @override
  String get privacyNote =>
      'Veikia be interneto. Paskyros nereikia. Programėlė naudoja strigčių ataskaitas, analitiką ir privatumo valdomus skelbimus.';

  @override
  String get dataCoverage =>
      'Kalendoriaus duomenys: 2020–2035. Mokinių atostogos pasiekiamos tik paskelbtiems metams.';

  @override
  String get about => 'Apie programėlę';

  @override
  String get licenses => 'Atvirojo kodo licencijos';

  @override
  String get info => 'Apie savaičių numerius';

  @override
  String get faq => 'Dažniausi klausimai';

  @override
  String get methodology => 'Metodika';

  @override
  String get sources => 'Duomenų šaltiniai';

  @override
  String get editorial => 'Redakciniai principai';

  @override
  String get usComparison => 'Suomija ir JAV';

  @override
  String get isoWeek => 'ISO savaitė';

  @override
  String get usWeek => 'JAV savaitė';

  @override
  String get isoExplanation =>
      'Savaitė prasideda pirmadienį. Pirmoje metų ISO savaitėje yra sausio 4 d. ISO savaičių metai gali skirtis nuo kalendorinių.';

  @override
  String get openData => 'Atvirieji duomenys';

  @override
  String get dataExplorer => 'Naršyti kalendoriaus duomenis';

  @override
  String get bundledData => 'Pridėtas duomenų rinkinys';

  @override
  String get dataCopyNote => 'Nukopijuokite pasirinktus metus JSON formatu.';

  @override
  String get websiteResources => 'Daugiau svetainėje';

  @override
  String get websiteResourcesNote =>
      'Kitos svetainės paslaugos atveriamos naršyklėje ir reikalauja interneto ryšio.';

  @override
  String get contact => 'Kontaktai';

  @override
  String get privacy => 'Privatumas';

  @override
  String get terms => 'Sąlygos';

  @override
  String get timeManagement => 'Laiko planavimas';

  @override
  String get sun => 'Saulė Helsinkyje';

  @override
  String get sunrise => 'Saulėtekis';

  @override
  String get sunset => 'Saulėlydis';

  @override
  String get daylight => 'Dienos ilgumas';

  @override
  String get polarDay => 'Baltosios naktys';

  @override
  String get polarNight => 'Poliarinė naktis';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours val. $minutes min.';
  }

  @override
  String get weekNotes => 'Savaitės užrašas';

  @override
  String get noteHint => 'Parašykite užrašą šiai savaitei…';

  @override
  String get saved => 'Įrašyta šiame įrenginyje';

  @override
  String get save => 'Įrašyti';

  @override
  String get cancel => 'Atšaukti';

  @override
  String get notFound => 'Puslapis nerastas';

  @override
  String get outOfRange => 'Pasirinkite metus nuo 2020 iki 2035.';

  @override
  String get backHome => 'Grįžti į pradžią';

  @override
  String get loadingError => 'Nepavyko įkelti kalendoriaus duomenų.';

  @override
  String get retry => 'Bandyti dar kartą';

  @override
  String get menu => 'Atverti meniu';

  @override
  String get dayDetails => 'Dienos informacija';

  @override
  String get close => 'Užverti';

  @override
  String get holidayRule => 'Datos taisyklė';

  @override
  String get fiContent => 'Svetainės šaltinio medžiaga yra suomių kalba.';

  @override
  String get nameDaysUnavailable =>
      'Vardadieniai bus pridėti patvirtinus licenciją.';

  @override
  String get weekList => 'Savaičių sąrašas';
}
