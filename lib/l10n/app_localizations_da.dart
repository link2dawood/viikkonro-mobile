// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get appName => 'Viikkonro';

  @override
  String get wordmark => 'Viikko nyt';

  @override
  String get home => 'Hjem';

  @override
  String get weeks => 'Uger';

  @override
  String get calendar => 'Kalender';

  @override
  String get tools => 'Beregnere';

  @override
  String get more => 'Mere';

  @override
  String get settings => 'Indstillinger';

  @override
  String get eyebrow => 'UGENUMMERVÆRKTØJ';

  @override
  String get homeTitle => 'Hvilken uge er det?';

  @override
  String get homeLead => 'Ugenumre, datoer og vigtige kalenderdage ét sted.';

  @override
  String get rightNow => 'LIGE NU';

  @override
  String get week => 'Uge';

  @override
  String weekLabel(int number) {
    return 'Uge $number';
  }

  @override
  String weekShort(int number) {
    return 'Uge $number';
  }

  @override
  String yearLabel(int number) {
    return 'År $number';
  }

  @override
  String weekOf(int current, int total) {
    return 'Uge $current / $total';
  }

  @override
  String yearProgress(int percent) {
    return '$percent % af året er gået';
  }

  @override
  String get weeksTotal => '52/53 uger';

  @override
  String get previous => 'Forrige';

  @override
  String get next => 'Næste';

  @override
  String get today => 'I dag';

  @override
  String get thisWeek => 'Denne uge';

  @override
  String get thisMonth => 'Denne måned';

  @override
  String get thisYear => 'I år';

  @override
  String get lookupTitle => 'Find ugenummeret for enhver dato';

  @override
  String get chooseDate => 'Vælg dato';

  @override
  String get dateToWeek => 'Dato til uge';

  @override
  String get weekToDate => 'Uge til datoer';

  @override
  String get weekdayCalculator => 'Ugedag';

  @override
  String get openWeek => 'Åbn ugens detaljer';

  @override
  String get year => 'År';

  @override
  String get month => 'Måned';

  @override
  String get weekNumber => 'Ugenummer';

  @override
  String get dayOfYear => 'Dag i året';

  @override
  String get daysRemaining => 'Dage tilbage';

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
    return '$count dage';
  }

  @override
  String weekDaysResult(int weeks, int days) {
    return '$weeks uger og $days dage';
  }

  @override
  String get holidays => 'Helligdage';

  @override
  String get flagDays => 'Flagdage';

  @override
  String get schoolHolidays => 'Skoleferier';

  @override
  String get nextHoliday => 'Næste helligdag';

  @override
  String get noEvents => 'Ingen mærkedage';

  @override
  String get official => 'Officiel helligdag';

  @override
  String get observance => 'Mærkedag';

  @override
  String get all => 'Alle';

  @override
  String get confirmed => 'Bekræftet';

  @override
  String get estimated => 'anslået';

  @override
  String get unknown => 'Endnu ikke offentliggjort';

  @override
  String get noSchoolData =>
      'Der er ingen offentliggjorte skoleferiedata for dette år.';

  @override
  String get schoolCoverage =>
      'Din skoles datoer kan afvige fra kommunens kalender.';

  @override
  String get winterBreak => 'Vinterferie';

  @override
  String get autumnBreak => 'Efterårsferie';

  @override
  String get city => 'By';

  @override
  String get source => 'Kilde';

  @override
  String verifiedAt(String date) {
    return 'Kontrolleret $date';
  }

  @override
  String get daysBetween => 'Dage mellem datoer';

  @override
  String get workingDaysBetween => 'Arbejdsdagsberegner';

  @override
  String get workingDays => 'Arbejdsdage';

  @override
  String get weekends => 'Weekender';

  @override
  String get weekdayHolidays => 'Helligdage på hverdage';

  @override
  String get totalDays => 'Dage i alt';

  @override
  String get firstDate => 'Startdato';

  @override
  String get lastDate => 'Slutdato';

  @override
  String get invalidRange =>
      'Slutdatoen skal være samme dag som eller efter startdatoen.';

  @override
  String get distanceNote =>
      'Resultatet er afstanden mellem datoerne. Rækkefølgen betyder ikke noget.';

  @override
  String get workingNote =>
      'Begge datoer tælles med. Arbejdsdage er mandag–fredag undtagen officielle helligdage. Juleaften og midsommeraften tæller som arbejdsdage.';

  @override
  String get yearWeeks => 'Alle årets uger';

  @override
  String get yearCalendar => 'Årskalender';

  @override
  String get firstHalf => 'Første halvår';

  @override
  String get secondHalf => 'Andet halvår';

  @override
  String get wholeYear => 'Hele året';

  @override
  String get yearWorkingDays => 'Arbejdsdage pr. år';

  @override
  String get monthWorkingDays => 'Arbejdsdage pr. måned';

  @override
  String get share => 'Del';

  @override
  String get openWebsite => 'Åbn webstedet';

  @override
  String get copy => 'Kopiér';

  @override
  String get copied => 'Kopieret';

  @override
  String get printPdf => 'Udskriv / gem PDF';

  @override
  String get exportCsv => 'Eksportér CSV';

  @override
  String get exportCalendar => 'Eksportér kalender (.ics)';

  @override
  String get exportFailed => 'Eksporten mislykkedes. Prøv igen.';

  @override
  String get openFailed => 'Linket kunne ikke åbnes.';

  @override
  String get language => 'Sprog';

  @override
  String get finnish => 'Finsk';

  @override
  String get english => 'Engelsk';

  @override
  String get theme => 'Udseende';

  @override
  String get system => 'System';

  @override
  String get light => 'Lyst';

  @override
  String get dark => 'Mørkt';

  @override
  String get firstScreen => 'Startskærm';

  @override
  String get privacyNote =>
      'Virker offline. Ingen konto. Appen bruger nedbrudsrapportering, analyse og annoncer med privatlivskontrol.';

  @override
  String get dataCoverage =>
      'Kalenderdata: 2020–2035. Skoleferier findes kun for offentliggjorte år.';

  @override
  String get about => 'Om appen';

  @override
  String get licenses => 'Open source-licenser';

  @override
  String get info => 'Om ugenumre';

  @override
  String get faq => 'Ofte stillede spørgsmål';

  @override
  String get methodology => 'Metode';

  @override
  String get sources => 'Datakilder';

  @override
  String get editorial => 'Redaktionelle principper';

  @override
  String get usComparison => 'Finland og USA';

  @override
  String get isoWeek => 'ISO-uge';

  @override
  String get usWeek => 'Amerikansk uge';

  @override
  String get isoExplanation =>
      'Ugen begynder mandag. Årets første ISO-uge indeholder den 4. januar. ISO-ugeåret kan afvige fra kalenderåret.';

  @override
  String get openData => 'Åbne data';

  @override
  String get dataExplorer => 'Udforsk kalenderdata';

  @override
  String get bundledData => 'Medfølgende datasæt';

  @override
  String get dataCopyNote => 'Kopiér det valgte år som JSON.';

  @override
  String get websiteResources => 'Mere på webstedet';

  @override
  String get websiteResourcesNote =>
      'Webstedets øvrige tjenester åbnes i browseren og kræver internetforbindelse.';

  @override
  String get contact => 'Kontakt';

  @override
  String get privacy => 'Privatliv';

  @override
  String get terms => 'Vilkår';

  @override
  String get timeManagement => 'Tidsstyring';

  @override
  String get sun => 'Solen i Helsinki';

  @override
  String get sunrise => 'Solopgang';

  @override
  String get sunset => 'Solnedgang';

  @override
  String get daylight => 'Dagens længde';

  @override
  String get polarDay => 'Midnatssol';

  @override
  String get polarNight => 'Polarnat';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours t $minutes min';
  }

  @override
  String get weekNotes => 'Ugenotat';

  @override
  String get noteHint => 'Skriv et notat for denne uge…';

  @override
  String get saved => 'Gemt på denne enhed';

  @override
  String get save => 'Gem';

  @override
  String get cancel => 'Annullér';

  @override
  String get notFound => 'Siden blev ikke fundet';

  @override
  String get outOfRange => 'Vælg et år mellem 2020 og 2035.';

  @override
  String get backHome => 'Tilbage til forsiden';

  @override
  String get loadingError => 'Kalenderdata kunne ikke indlæses.';

  @override
  String get retry => 'Prøv igen';

  @override
  String get menu => 'Åbn menuen';

  @override
  String get dayDetails => 'Dagens detaljer';

  @override
  String get close => 'Luk';

  @override
  String get holidayRule => 'Datoregel';

  @override
  String get fiContent => 'Webstedets kildemateriale er på finsk.';

  @override
  String get nameDaysUnavailable =>
      'Navnedage tilføjes, når licensen er bekræftet.';

  @override
  String get weekList => 'Ugeliste';
}
