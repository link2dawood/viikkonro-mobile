// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appName => 'Viikkonro';

  @override
  String get wordmark => 'Viikko nyt';

  @override
  String get home => 'Start';

  @override
  String get weeks => 'Weken';

  @override
  String get calendar => 'Kalender';

  @override
  String get tools => 'Rekenhulpen';

  @override
  String get more => 'Meer';

  @override
  String get settings => 'Instellingen';

  @override
  String get eyebrow => 'WEEKNUMMERTOOL';

  @override
  String get homeTitle => 'Welke week is het?';

  @override
  String get homeLead =>
      'Weeknummers, datums en belangrijke kalenderdagen op één plek.';

  @override
  String get rightNow => 'OP DIT MOMENT';

  @override
  String get week => 'Week';

  @override
  String weekLabel(int number) {
    return 'Week $number';
  }

  @override
  String weekShort(int number) {
    return 'Wk $number';
  }

  @override
  String yearLabel(int number) {
    return 'Jaar $number';
  }

  @override
  String weekOf(int current, int total) {
    return 'Week $current / $total';
  }

  @override
  String yearProgress(int percent) {
    return '$percent % van het jaar voorbij';
  }

  @override
  String get weeksTotal => '52/53 weken';

  @override
  String get previous => 'Vorige';

  @override
  String get next => 'Volgende';

  @override
  String get today => 'Vandaag';

  @override
  String get thisWeek => 'Deze week';

  @override
  String get thisMonth => 'Deze maand';

  @override
  String get thisYear => 'Dit jaar';

  @override
  String get lookupTitle => 'Zoek het weeknummer van elke datum';

  @override
  String get chooseDate => 'Kies een datum';

  @override
  String get dateToWeek => 'Datum naar week';

  @override
  String get weekToDate => 'Week naar datums';

  @override
  String get weekdayCalculator => 'Dag van de week';

  @override
  String get openWeek => 'Weekdetails openen';

  @override
  String get year => 'Jaar';

  @override
  String get month => 'Maand';

  @override
  String get weekNumber => 'Weeknummer';

  @override
  String get dayOfYear => 'Dag van het jaar';

  @override
  String get daysRemaining => 'Resterende dagen';

  @override
  String get quarter => 'Kwartaal';

  @override
  String quarterLabel(int number) {
    return 'Kwartaal $number';
  }

  @override
  String get weekRange => 'Maandag tot en met zondag';

  @override
  String dayCount(int count) {
    return '$count dagen';
  }

  @override
  String weekDaysResult(int weeks, int days) {
    return '$weeks weken en $days dagen';
  }

  @override
  String get holidays => 'Feestdagen';

  @override
  String get flagDays => 'Vlaggendagen';

  @override
  String get schoolHolidays => 'Schoolvakanties';

  @override
  String get nextHoliday => 'Volgende feestdag';

  @override
  String get noEvents => 'Geen gedenkdagen';

  @override
  String get official => 'Officiële feestdag';

  @override
  String get observance => 'Gedenkdag';

  @override
  String get all => 'Alle';

  @override
  String get confirmed => 'Bevestigd';

  @override
  String get estimated => 'geschat';

  @override
  String get unknown => 'Nog niet gepubliceerd';

  @override
  String get noSchoolData =>
      'Er zijn geen gepubliceerde schoolvakantiegegevens voor dit jaar.';

  @override
  String get schoolCoverage =>
      'De data van je school kunnen afwijken van de gemeentelijke kalender.';

  @override
  String get winterBreak => 'Voorjaarsvakantie';

  @override
  String get autumnBreak => 'Herfstvakantie';

  @override
  String get city => 'Stad';

  @override
  String get source => 'Bron';

  @override
  String verifiedAt(String date) {
    return 'Gecontroleerd op $date';
  }

  @override
  String get daysBetween => 'Dagen tussen datums';

  @override
  String get workingDaysBetween => 'Werkdagenrekenmachine';

  @override
  String get workingDays => 'Werkdagen';

  @override
  String get weekends => 'Weekenden';

  @override
  String get weekdayHolidays => 'Feestdagen op werkdagen';

  @override
  String get totalDays => 'Dagen in totaal';

  @override
  String get firstDate => 'Begindatum';

  @override
  String get lastDate => 'Einddatum';

  @override
  String get invalidRange =>
      'De einddatum moet gelijk zijn aan of na de begindatum liggen.';

  @override
  String get distanceNote =>
      'Het resultaat is de afstand tussen de datums. De volgorde maakt niet uit.';

  @override
  String get workingNote =>
      'Beide datums tellen mee. Werkdagen zijn maandag tot en met vrijdag, zonder officiële feestdagen. Kerstavond en midzomeravond tellen als werkdag.';

  @override
  String get yearWeeks => 'Alle weken van het jaar';

  @override
  String get yearCalendar => 'Jaarkalender';

  @override
  String get firstHalf => 'Eerste halfjaar';

  @override
  String get secondHalf => 'Tweede halfjaar';

  @override
  String get wholeYear => 'Heel het jaar';

  @override
  String get yearWorkingDays => 'Werkdagen per jaar';

  @override
  String get monthWorkingDays => 'Werkdagen per maand';

  @override
  String get share => 'Delen';

  @override
  String get openWebsite => 'Website openen';

  @override
  String get copy => 'Kopiëren';

  @override
  String get copied => 'Gekopieerd';

  @override
  String get printPdf => 'Afdrukken / opslaan als pdf';

  @override
  String get exportCsv => 'CSV exporteren';

  @override
  String get exportCalendar => 'Kalender exporteren (.ics)';

  @override
  String get exportFailed => 'Exporteren is mislukt. Probeer het opnieuw.';

  @override
  String get openFailed => 'De link kon niet worden geopend.';

  @override
  String get language => 'Taal';

  @override
  String get finnish => 'Fins';

  @override
  String get english => 'Engels';

  @override
  String get theme => 'Weergave';

  @override
  String get system => 'Systeem';

  @override
  String get light => 'Licht';

  @override
  String get dark => 'Donker';

  @override
  String get firstScreen => 'Startscherm';

  @override
  String get privacyNote =>
      'Werkt offline. Geen account. De app gebruikt crashrapporten, analyses en advertenties met privacyinstellingen.';

  @override
  String get dataCoverage =>
      'Kalendergegevens: 2020–2035. Schoolvakanties zijn alleen beschikbaar voor gepubliceerde jaren.';

  @override
  String get about => 'Over de app';

  @override
  String get licenses => 'Opensourcelicenties';

  @override
  String get info => 'Over weeknummers';

  @override
  String get faq => 'Veelgestelde vragen';

  @override
  String get methodology => 'Methode';

  @override
  String get sources => 'Gegevensbronnen';

  @override
  String get editorial => 'Redactionele uitgangspunten';

  @override
  String get usComparison => 'Finland en de VS';

  @override
  String get isoWeek => 'ISO-week';

  @override
  String get usWeek => 'Amerikaanse week';

  @override
  String get isoExplanation =>
      'De week begint op maandag. De eerste ISO-week van het jaar bevat 4 januari. Het ISO-weekjaar kan afwijken van het kalenderjaar.';

  @override
  String get openData => 'Open data';

  @override
  String get dataExplorer => 'Kalendergegevens verkennen';

  @override
  String get bundledData => 'Meegeleverde dataset';

  @override
  String get dataCopyNote => 'Kopieer het gekozen jaar als JSON.';

  @override
  String get websiteResources => 'Meer op de website';

  @override
  String get websiteResourcesNote =>
      'De overige diensten van de website openen in de browser en hebben internet nodig.';

  @override
  String get contact => 'Contact';

  @override
  String get privacy => 'Privacy';

  @override
  String get terms => 'Voorwaarden';

  @override
  String get timeManagement => 'Timemanagement';

  @override
  String get sun => 'De zon in Helsinki';

  @override
  String get sunrise => 'Zonsopkomst';

  @override
  String get sunset => 'Zonsondergang';

  @override
  String get daylight => 'Daglengte';

  @override
  String get polarDay => 'Middernachtzon';

  @override
  String get polarNight => 'Poolnacht';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours u $minutes min';
  }

  @override
  String get weekNotes => 'Weeknotitie';

  @override
  String get noteHint => 'Schrijf een notitie voor deze week…';

  @override
  String get saved => 'Opgeslagen op dit apparaat';

  @override
  String get save => 'Opslaan';

  @override
  String get cancel => 'Annuleren';

  @override
  String get notFound => 'Pagina niet gevonden';

  @override
  String get outOfRange => 'Kies een jaar tussen 2020 en 2035.';

  @override
  String get backHome => 'Terug naar start';

  @override
  String get loadingError => 'De kalendergegevens konden niet worden geladen.';

  @override
  String get retry => 'Opnieuw proberen';

  @override
  String get menu => 'Menu openen';

  @override
  String get dayDetails => 'Dagdetails';

  @override
  String get close => 'Sluiten';

  @override
  String get holidayRule => 'Datumregel';

  @override
  String get fiContent => 'Het bronmateriaal van de website is in het Fins.';

  @override
  String get nameDaysUnavailable =>
      'Naamdagen worden toegevoegd zodra de licentie is bevestigd.';

  @override
  String get weekList => 'Weeklijst';
}
