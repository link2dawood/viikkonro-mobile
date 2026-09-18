// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class AppLocalizationsEt extends AppLocalizations {
  AppLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get appName => 'Viikkonro';

  @override
  String get wordmark => 'Viikko nyt';

  @override
  String get home => 'Avaleht';

  @override
  String get weeks => 'Nädalad';

  @override
  String get calendar => 'Kalender';

  @override
  String get tools => 'Kalkulaatorid';

  @override
  String get more => 'Rohkem';

  @override
  String get settings => 'Seaded';

  @override
  String get eyebrow => 'NÄDALANUMBRI TÖÖRIIST';

  @override
  String get homeTitle => 'Mitmes nädal praegu on?';

  @override
  String get homeLead =>
      'Nädalanumbrid, kuupäevad ja tähtsad kalendripäevad ühes kohas.';

  @override
  String get rightNow => 'PRAEGU ON';

  @override
  String get week => 'Nädal';

  @override
  String weekLabel(int number) {
    return 'Nädal $number';
  }

  @override
  String weekShort(int number) {
    return 'N $number';
  }

  @override
  String yearLabel(int number) {
    return 'Aasta $number';
  }

  @override
  String weekOf(int current, int total) {
    return 'Nädal $current / $total';
  }

  @override
  String yearProgress(int percent) {
    return '$percent % aastast möödas';
  }

  @override
  String get weeksTotal => '52/53 nädalat';

  @override
  String get previous => 'Eelmine';

  @override
  String get next => 'Järgmine';

  @override
  String get today => 'Täna';

  @override
  String get thisWeek => 'See nädal';

  @override
  String get thisMonth => 'See kuu';

  @override
  String get thisYear => 'See aasta';

  @override
  String get lookupTitle => 'Leia mis tahes kuupäeva nädalanumber';

  @override
  String get chooseDate => 'Vali kuupäev';

  @override
  String get dateToWeek => 'Kuupäev nädalaks';

  @override
  String get weekToDate => 'Nädal kuupäevadeks';

  @override
  String get weekdayCalculator => 'Nädalapäev';

  @override
  String get openWeek => 'Ava nädala üksikasjad';

  @override
  String get year => 'Aasta';

  @override
  String get month => 'Kuu';

  @override
  String get weekNumber => 'Nädalanumber';

  @override
  String get dayOfYear => 'Aasta päev';

  @override
  String get daysRemaining => 'Päevi jäänud';

  @override
  String get quarter => 'Kvartal';

  @override
  String quarterLabel(int number) {
    return 'Kvartal $number';
  }

  @override
  String get weekRange => 'Esmaspäevast pühapäevani';

  @override
  String dayCount(int count) {
    return '$count päeva';
  }

  @override
  String weekDaysResult(int weeks, int days) {
    return '$weeks nädalat ja $days päeva';
  }

  @override
  String get holidays => 'Riigipühad';

  @override
  String get flagDays => 'Lipupäevad';

  @override
  String get schoolHolidays => 'Koolivaheajad';

  @override
  String get nextHoliday => 'Järgmine riigipüha';

  @override
  String get noEvents => 'Tähtpäevi pole';

  @override
  String get official => 'Ametlik riigipüha';

  @override
  String get observance => 'Tähtpäev';

  @override
  String get all => 'Kõik';

  @override
  String get confirmed => 'Kinnitatud';

  @override
  String get estimated => 'hinnanguline';

  @override
  String get unknown => 'Veel avaldamata';

  @override
  String get noSchoolData =>
      'Selle aasta kohta pole avaldatud koolivaheaegade andmeid.';

  @override
  String get schoolCoverage =>
      'Sinu kooli kuupäevad võivad omavalitsuse kalendrist erineda.';

  @override
  String get winterBreak => 'Talvevaheaeg';

  @override
  String get autumnBreak => 'Sügisvaheaeg';

  @override
  String get city => 'Linn';

  @override
  String get source => 'Allikas';

  @override
  String verifiedAt(String date) {
    return 'Kontrollitud $date';
  }

  @override
  String get daysBetween => 'Päevi kuupäevade vahel';

  @override
  String get workingDaysBetween => 'Tööpäevade kalkulaator';

  @override
  String get workingDays => 'Tööpäevad';

  @override
  String get weekends => 'Nädalavahetused';

  @override
  String get weekdayHolidays => 'Riigipühad argipäevadel';

  @override
  String get totalDays => 'Päevi kokku';

  @override
  String get firstDate => 'Alguskuupäev';

  @override
  String get lastDate => 'Lõppkuupäev';

  @override
  String get invalidRange =>
      'Lõppkuupäev peab olema sama või hilisem kui alguskuupäev.';

  @override
  String get distanceNote =>
      'Tulemus on kuupäevade vaheline kaugus. Järjekord ei loe.';

  @override
  String get workingNote =>
      'Mõlemad kuupäevad lähevad arvesse. Tööpäevad on esmaspäevast reedeni, välja arvatud ametlikud riigipühad. Jõululaupäev ja jaanilaupäev loetakse tööpäevadeks.';

  @override
  String get yearWeeks => 'Aasta kõik nädalad';

  @override
  String get yearCalendar => 'Aastakalender';

  @override
  String get firstHalf => 'Esimene poolaasta';

  @override
  String get secondHalf => 'Teine poolaasta';

  @override
  String get wholeYear => 'Kogu aasta';

  @override
  String get yearWorkingDays => 'Tööpäevi aastas';

  @override
  String get monthWorkingDays => 'Tööpäevi kuus';

  @override
  String get share => 'Jaga';

  @override
  String get openWebsite => 'Ava veebisait';

  @override
  String get copy => 'Kopeeri';

  @override
  String get copied => 'Kopeeritud';

  @override
  String get printPdf => 'Prindi / salvesta PDF';

  @override
  String get exportCsv => 'Ekspordi CSV';

  @override
  String get exportCalendar => 'Ekspordi kalender (.ics)';

  @override
  String get exportFailed => 'Eksportimine ebaõnnestus. Proovi uuesti.';

  @override
  String get openFailed => 'Linki ei õnnestunud avada.';

  @override
  String get language => 'Keel';

  @override
  String get finnish => 'Soome';

  @override
  String get english => 'Inglise';

  @override
  String get theme => 'Välimus';

  @override
  String get system => 'Süsteem';

  @override
  String get light => 'Hele';

  @override
  String get dark => 'Tume';

  @override
  String get firstScreen => 'Avavaade';

  @override
  String get privacyNote =>
      'Töötab võrguühenduseta. Kontot pole vaja. Rakendus kasutab krahhiaruandeid, analüütikat ja privaatsusvalikutega reklaame.';

  @override
  String get dataCoverage =>
      'Kalendriandmed: 2020–2035. Koolivaheajad on saadaval ainult avaldatud aastate kohta.';

  @override
  String get about => 'Rakendusest';

  @override
  String get licenses => 'Avatud lähtekoodi litsentsid';

  @override
  String get info => 'Nädalanumbritest';

  @override
  String get faq => 'Korduma kippuvad küsimused';

  @override
  String get methodology => 'Metoodika';

  @override
  String get sources => 'Andmeallikad';

  @override
  String get editorial => 'Toimetuspõhimõtted';

  @override
  String get usComparison => 'Soome ja USA';

  @override
  String get isoWeek => 'ISO-nädal';

  @override
  String get usWeek => 'USA nädal';

  @override
  String get isoExplanation =>
      'Nädal algab esmaspäeval. Aasta esimene ISO-nädal sisaldab 4. jaanuari. ISO-nädala aasta võib kalendriaastast erineda.';

  @override
  String get openData => 'Avaandmed';

  @override
  String get dataExplorer => 'Uuri kalendriandmeid';

  @override
  String get bundledData => 'Kaasas olev andmestik';

  @override
  String get dataCopyNote => 'Kopeeri valitud aasta JSON-vormingus.';

  @override
  String get websiteResources => 'Rohkem veebisaidil';

  @override
  String get websiteResourcesNote =>
      'Veebisaidi muud teenused avanevad brauseris ja vajavad internetiühendust.';

  @override
  String get contact => 'Kontakt';

  @override
  String get privacy => 'Privaatsus';

  @override
  String get terms => 'Tingimused';

  @override
  String get timeManagement => 'Ajaplaneerimine';

  @override
  String get sun => 'Päike Helsingis';

  @override
  String get sunrise => 'Päikesetõus';

  @override
  String get sunset => 'Päikeseloojang';

  @override
  String get daylight => 'Päeva pikkus';

  @override
  String get polarDay => 'Valged ööd';

  @override
  String get polarNight => 'Polaaröö';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours t $minutes min';
  }

  @override
  String get weekNotes => 'Nädala märkus';

  @override
  String get noteHint => 'Kirjuta selle nädala kohta märkus…';

  @override
  String get saved => 'Salvestatud sellesse seadmesse';

  @override
  String get save => 'Salvesta';

  @override
  String get cancel => 'Loobu';

  @override
  String get notFound => 'Lehte ei leitud';

  @override
  String get outOfRange => 'Vali aasta vahemikus 2020–2035.';

  @override
  String get backHome => 'Tagasi avalehele';

  @override
  String get loadingError => 'Kalendriandmeid ei õnnestunud laadida.';

  @override
  String get retry => 'Proovi uuesti';

  @override
  String get menu => 'Ava menüü';

  @override
  String get dayDetails => 'Päeva üksikasjad';

  @override
  String get close => 'Sulge';

  @override
  String get holidayRule => 'Kuupäevareegel';

  @override
  String get fiContent => 'Veebisaidi lähtematerjal on soome keeles.';

  @override
  String get nameDaysUnavailable =>
      'Nimepäevad lisatakse pärast litsentsi kinnitamist.';

  @override
  String get weekList => 'Nädalate loend';
}
