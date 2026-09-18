// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get appName => 'Viikkonro';

  @override
  String get wordmark => 'Viikko nyt';

  @override
  String get home => 'Hem';

  @override
  String get weeks => 'Veckor';

  @override
  String get calendar => 'Kalender';

  @override
  String get tools => 'Kalkylatorer';

  @override
  String get more => 'Mer';

  @override
  String get settings => 'Inställningar';

  @override
  String get eyebrow => 'VECKONUMMERVERKTYG';

  @override
  String get homeTitle => 'Vilken vecka är det?';

  @override
  String get homeLead =>
      'Veckonummer, datum och viktiga kalenderdagar på ett ställe.';

  @override
  String get rightNow => 'JUST NU';

  @override
  String get week => 'Vecka';

  @override
  String weekLabel(int number) {
    return 'Vecka $number';
  }

  @override
  String weekShort(int number) {
    return 'V $number';
  }

  @override
  String yearLabel(int number) {
    return 'År $number';
  }

  @override
  String weekOf(int current, int total) {
    return 'Vecka $current / $total';
  }

  @override
  String yearProgress(int percent) {
    return '$percent % av året har gått';
  }

  @override
  String get weeksTotal => '52/53 veckor';

  @override
  String get previous => 'Föregående';

  @override
  String get next => 'Nästa';

  @override
  String get today => 'I dag';

  @override
  String get thisWeek => 'Denna vecka';

  @override
  String get thisMonth => 'Denna månad';

  @override
  String get thisYear => 'I år';

  @override
  String get lookupTitle => 'Hitta veckonumret för valfritt datum';

  @override
  String get chooseDate => 'Välj datum';

  @override
  String get dateToWeek => 'Datum till vecka';

  @override
  String get weekToDate => 'Vecka till datum';

  @override
  String get weekdayCalculator => 'Veckodag';

  @override
  String get openWeek => 'Öppna veckans uppgifter';

  @override
  String get year => 'År';

  @override
  String get month => 'Månad';

  @override
  String get weekNumber => 'Veckonummer';

  @override
  String get dayOfYear => 'Dag på året';

  @override
  String get daysRemaining => 'Dagar kvar';

  @override
  String get quarter => 'Kvartal';

  @override
  String quarterLabel(int number) {
    return 'Kvartal $number';
  }

  @override
  String get weekRange => 'Måndag till söndag';

  @override
  String dayCount(int count) {
    return '$count dagar';
  }

  @override
  String weekDaysResult(int weeks, int days) {
    return '$weeks veckor och $days dagar';
  }

  @override
  String get holidays => 'Helgdagar';

  @override
  String get flagDays => 'Flaggdagar';

  @override
  String get schoolHolidays => 'Skollov';

  @override
  String get nextHoliday => 'Nästa helgdag';

  @override
  String get noEvents => 'Inga märkesdagar';

  @override
  String get official => 'Officiell helgdag';

  @override
  String get observance => 'Märkesdag';

  @override
  String get all => 'Alla';

  @override
  String get confirmed => 'Bekräftad';

  @override
  String get estimated => 'uppskattad';

  @override
  String get unknown => 'Ännu inte publicerad';

  @override
  String get noSchoolData =>
      'Det finns inga publicerade skollovsuppgifter för det här året.';

  @override
  String get schoolCoverage =>
      'Din skolas datum kan skilja sig från kommunens kalender.';

  @override
  String get winterBreak => 'Sportlov';

  @override
  String get autumnBreak => 'Höstlov';

  @override
  String get city => 'Stad';

  @override
  String get source => 'Källa';

  @override
  String verifiedAt(String date) {
    return 'Kontrollerad $date';
  }

  @override
  String get daysBetween => 'Dagar mellan datum';

  @override
  String get workingDaysBetween => 'Arbetsdagsräknare';

  @override
  String get workingDays => 'Arbetsdagar';

  @override
  String get weekends => 'Helger';

  @override
  String get weekdayHolidays => 'Helgdagar på vardagar';

  @override
  String get totalDays => 'Dagar totalt';

  @override
  String get firstDate => 'Startdatum';

  @override
  String get lastDate => 'Slutdatum';

  @override
  String get invalidRange =>
      'Slutdatumet måste vara samma dag som eller efter startdatumet.';

  @override
  String get distanceNote =>
      'Resultatet är avståndet mellan datumen. Ordningen spelar ingen roll.';

  @override
  String get workingNote =>
      'Båda datumen räknas med. Arbetsdagar är måndag–fredag utom officiella helgdagar. Julafton och midsommarafton räknas som arbetsdagar.';

  @override
  String get yearWeeks => 'Årets alla veckor';

  @override
  String get yearCalendar => 'Årskalender';

  @override
  String get firstHalf => 'Första halvåret';

  @override
  String get secondHalf => 'Andra halvåret';

  @override
  String get wholeYear => 'Hela året';

  @override
  String get yearWorkingDays => 'Arbetsdagar per år';

  @override
  String get monthWorkingDays => 'Arbetsdagar per månad';

  @override
  String get share => 'Dela';

  @override
  String get openWebsite => 'Öppna webbplatsen';

  @override
  String get copy => 'Kopiera';

  @override
  String get copied => 'Kopierat';

  @override
  String get printPdf => 'Skriv ut / spara PDF';

  @override
  String get exportCsv => 'Exportera CSV';

  @override
  String get exportCalendar => 'Exportera kalender (.ics)';

  @override
  String get exportFailed => 'Exporten misslyckades. Försök igen.';

  @override
  String get openFailed => 'Det gick inte att öppna länken.';

  @override
  String get language => 'Språk';

  @override
  String get finnish => 'Finska';

  @override
  String get english => 'Engelska';

  @override
  String get theme => 'Utseende';

  @override
  String get system => 'System';

  @override
  String get light => 'Ljust';

  @override
  String get dark => 'Mörkt';

  @override
  String get firstScreen => 'Startvy';

  @override
  String get privacyNote =>
      'Fungerar offline. Inget konto. Appen använder kraschrapportering, analys och annonser med integritetskontroller.';

  @override
  String get dataCoverage =>
      'Kalenderdata: 2020–2035. Skollov finns endast för publicerade år.';

  @override
  String get about => 'Om appen';

  @override
  String get licenses => 'Licenser för öppen källkod';

  @override
  String get info => 'Om veckonummer';

  @override
  String get faq => 'Vanliga frågor';

  @override
  String get methodology => 'Metod';

  @override
  String get sources => 'Datakällor';

  @override
  String get editorial => 'Redaktionella principer';

  @override
  String get usComparison => 'Finland och USA';

  @override
  String get isoWeek => 'ISO-vecka';

  @override
  String get usWeek => 'Amerikansk vecka';

  @override
  String get isoExplanation =>
      'Veckan börjar på måndag. Årets första ISO-vecka innehåller den 4 januari. ISO-veckoåret kan skilja sig från kalenderåret.';

  @override
  String get openData => 'Öppna data';

  @override
  String get dataExplorer => 'Utforska kalenderdata';

  @override
  String get bundledData => 'Medföljande datauppsättning';

  @override
  String get dataCopyNote => 'Kopiera det valda året som JSON.';

  @override
  String get websiteResources => 'Mer på webbplatsen';

  @override
  String get websiteResourcesNote =>
      'Webbplatsens övriga tjänster öppnas i webbläsaren och kräver internetanslutning.';

  @override
  String get contact => 'Kontakt';

  @override
  String get privacy => 'Integritet';

  @override
  String get terms => 'Villkor';

  @override
  String get timeManagement => 'Tidshantering';

  @override
  String get sun => 'Solen i Helsingfors';

  @override
  String get sunrise => 'Soluppgång';

  @override
  String get sunset => 'Solnedgång';

  @override
  String get daylight => 'Dagens längd';

  @override
  String get polarDay => 'Midnattssol';

  @override
  String get polarNight => 'Polarnatt';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get weekNotes => 'Veckoanteckning';

  @override
  String get noteHint => 'Skriv en anteckning för den här veckan…';

  @override
  String get saved => 'Sparat på den här enheten';

  @override
  String get save => 'Spara';

  @override
  String get cancel => 'Avbryt';

  @override
  String get notFound => 'Sidan hittades inte';

  @override
  String get outOfRange => 'Välj ett år mellan 2020 och 2035.';

  @override
  String get backHome => 'Tillbaka till startsidan';

  @override
  String get loadingError => 'Kalenderdata kunde inte läsas in.';

  @override
  String get retry => 'Försök igen';

  @override
  String get menu => 'Öppna menyn';

  @override
  String get dayDetails => 'Dagens uppgifter';

  @override
  String get close => 'Stäng';

  @override
  String get holidayRule => 'Datumregel';

  @override
  String get fiContent => 'Webbplatsens källmaterial är på finska.';

  @override
  String get nameDaysUnavailable =>
      'Namnsdagar läggs till när licensieringen är verifierad.';

  @override
  String get weekList => 'Veckolista';
}
