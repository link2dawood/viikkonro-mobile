// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get appName => 'Viikkonro';

  @override
  String get wordmark => 'Viikko nyt';

  @override
  String get home => 'Hjem';

  @override
  String get weeks => 'Uker';

  @override
  String get calendar => 'Kalender';

  @override
  String get tools => 'Kalkulatorer';

  @override
  String get more => 'Mer';

  @override
  String get settings => 'Innstillinger';

  @override
  String get eyebrow => 'UKENUMMERVERKTØY';

  @override
  String get homeTitle => 'Hvilken uke er det?';

  @override
  String get homeLead =>
      'Ukenumre, datoer og viktige kalenderdager på ett sted.';

  @override
  String get rightNow => 'AKKURAT NÅ';

  @override
  String get week => 'Uke';

  @override
  String weekLabel(int number) {
    return 'Uke $number';
  }

  @override
  String weekShort(int number) {
    return 'Uke $number';
  }

  @override
  String yearLabel(int number) {
    return 'År $number';
  }

  @override
  String weekOf(int current, int total) {
    return 'Uke $current / $total';
  }

  @override
  String yearProgress(int percent) {
    return '$percent % av året har gått';
  }

  @override
  String get weeksTotal => '52/53 uker';

  @override
  String get previous => 'Forrige';

  @override
  String get next => 'Neste';

  @override
  String get today => 'I dag';

  @override
  String get thisWeek => 'Denne uken';

  @override
  String get thisMonth => 'Denne måneden';

  @override
  String get thisYear => 'I år';

  @override
  String get lookupTitle => 'Finn ukenummeret for en hvilken som helst dato';

  @override
  String get chooseDate => 'Velg dato';

  @override
  String get dateToWeek => 'Dato til uke';

  @override
  String get weekToDate => 'Uke til datoer';

  @override
  String get weekdayCalculator => 'Ukedag';

  @override
  String get openWeek => 'Åpne ukens detaljer';

  @override
  String get year => 'År';

  @override
  String get month => 'Måned';

  @override
  String get weekNumber => 'Ukenummer';

  @override
  String get dayOfYear => 'Dag i året';

  @override
  String get daysRemaining => 'Dager igjen';

  @override
  String get quarter => 'Kvartal';

  @override
  String quarterLabel(int number) {
    return 'Kvartal $number';
  }

  @override
  String get weekRange => 'Mandag til søndag';

  @override
  String dayCount(int count) {
    return '$count dager';
  }

  @override
  String weekDaysResult(int weeks, int days) {
    return '$weeks uker og $days dager';
  }

  @override
  String get holidays => 'Helligdager';

  @override
  String get flagDays => 'Flaggdager';

  @override
  String get schoolHolidays => 'Skoleferier';

  @override
  String get nextHoliday => 'Neste helligdag';

  @override
  String get noEvents => 'Ingen merkedager';

  @override
  String get official => 'Offisiell helligdag';

  @override
  String get observance => 'Merkedag';

  @override
  String get all => 'Alle';

  @override
  String get confirmed => 'Bekreftet';

  @override
  String get estimated => 'anslått';

  @override
  String get unknown => 'Ikke publisert ennå';

  @override
  String get noSchoolData =>
      'Det finnes ingen publiserte skoleferiedata for dette året.';

  @override
  String get schoolCoverage =>
      'Skolens datoer kan avvike fra kommunens kalender.';

  @override
  String get winterBreak => 'Vinterferie';

  @override
  String get autumnBreak => 'Høstferie';

  @override
  String get city => 'By';

  @override
  String get source => 'Kilde';

  @override
  String verifiedAt(String date) {
    return 'Kontrollert $date';
  }

  @override
  String get daysBetween => 'Dager mellom datoer';

  @override
  String get workingDaysBetween => 'Virkedagskalkulator';

  @override
  String get workingDays => 'Virkedager';

  @override
  String get weekends => 'Helger';

  @override
  String get weekdayHolidays => 'Helligdager på hverdager';

  @override
  String get totalDays => 'Dager totalt';

  @override
  String get firstDate => 'Startdato';

  @override
  String get lastDate => 'Sluttdato';

  @override
  String get invalidRange =>
      'Sluttdatoen må være samme dag som eller etter startdatoen.';

  @override
  String get distanceNote =>
      'Resultatet er avstanden mellom datoene. Rekkefølgen spiller ingen rolle.';

  @override
  String get workingNote =>
      'Begge datoene telles med. Virkedager er mandag–fredag utenom offisielle helligdager. Julaften og midtsommeraften telles som virkedager.';

  @override
  String get yearWeeks => 'Alle årets uker';

  @override
  String get yearCalendar => 'Årskalender';

  @override
  String get firstHalf => 'Første halvår';

  @override
  String get secondHalf => 'Andre halvår';

  @override
  String get wholeYear => 'Hele året';

  @override
  String get yearWorkingDays => 'Virkedager per år';

  @override
  String get monthWorkingDays => 'Virkedager per måned';

  @override
  String get share => 'Del';

  @override
  String get openWebsite => 'Åpne nettstedet';

  @override
  String get copy => 'Kopier';

  @override
  String get copied => 'Kopiert';

  @override
  String get printPdf => 'Skriv ut / lagre PDF';

  @override
  String get exportCsv => 'Eksporter CSV';

  @override
  String get exportCalendar => 'Eksporter kalender (.ics)';

  @override
  String get exportFailed => 'Eksporten mislyktes. Prøv igjen.';

  @override
  String get openFailed => 'Kunne ikke åpne lenken.';

  @override
  String get language => 'Språk';

  @override
  String get finnish => 'Finsk';

  @override
  String get english => 'Engelsk';

  @override
  String get theme => 'Utseende';

  @override
  String get system => 'System';

  @override
  String get light => 'Lyst';

  @override
  String get dark => 'Mørkt';

  @override
  String get firstScreen => 'Startskjerm';

  @override
  String get privacyNote =>
      'Fungerer uten nett. Ingen konto. Appen bruker krasjrapportering, analyse og annonser med personvernkontroller.';

  @override
  String get dataCoverage =>
      'Kalenderdata: 2020–2035. Skoleferier finnes kun for publiserte år.';

  @override
  String get about => 'Om appen';

  @override
  String get licenses => 'Åpen kildekode-lisenser';

  @override
  String get info => 'Om ukenumre';

  @override
  String get faq => 'Ofte stilte spørsmål';

  @override
  String get methodology => 'Metode';

  @override
  String get sources => 'Datakilder';

  @override
  String get editorial => 'Redaksjonelle prinsipper';

  @override
  String get usComparison => 'Finland og USA';

  @override
  String get isoWeek => 'ISO-uke';

  @override
  String get usWeek => 'Amerikansk uke';

  @override
  String get isoExplanation =>
      'Uken begynner på mandag. Årets første ISO-uke inneholder 4. januar. ISO-ukeåret kan avvike fra kalenderåret.';

  @override
  String get openData => 'Åpne data';

  @override
  String get dataExplorer => 'Utforsk kalenderdata';

  @override
  String get bundledData => 'Medfølgende datasett';

  @override
  String get dataCopyNote => 'Kopier det valgte året som JSON.';

  @override
  String get websiteResources => 'Mer på nettstedet';

  @override
  String get websiteResourcesNote =>
      'Nettstedets øvrige tjenester åpnes i nettleseren og krever internettforbindelse.';

  @override
  String get contact => 'Kontakt';

  @override
  String get privacy => 'Personvern';

  @override
  String get terms => 'Vilkår';

  @override
  String get timeManagement => 'Tidsstyring';

  @override
  String get sun => 'Solen i Helsingfors';

  @override
  String get sunrise => 'Soloppgang';

  @override
  String get sunset => 'Solnedgang';

  @override
  String get daylight => 'Dagens lengde';

  @override
  String get polarDay => 'Midnattssol';

  @override
  String get polarNight => 'Mørketid';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours t $minutes min';
  }

  @override
  String get weekNotes => 'Ukenotat';

  @override
  String get noteHint => 'Skriv et notat for denne uken…';

  @override
  String get saved => 'Lagret på denne enheten';

  @override
  String get save => 'Lagre';

  @override
  String get cancel => 'Avbryt';

  @override
  String get notFound => 'Siden ble ikke funnet';

  @override
  String get outOfRange => 'Velg et år mellom 2020 og 2035.';

  @override
  String get backHome => 'Tilbake til startsiden';

  @override
  String get loadingError => 'Kalenderdata kunne ikke lastes inn.';

  @override
  String get retry => 'Prøv igjen';

  @override
  String get menu => 'Åpne menyen';

  @override
  String get dayDetails => 'Dagens detaljer';

  @override
  String get close => 'Lukk';

  @override
  String get holidayRule => 'Datoregel';

  @override
  String get fiContent => 'Nettstedets kildemateriale er på finsk.';

  @override
  String get nameDaysUnavailable =>
      'Navnedager legges til når lisensieringen er bekreftet.';

  @override
  String get weekList => 'Ukeliste';
}
