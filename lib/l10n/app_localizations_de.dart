// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Viikkonro';

  @override
  String get wordmark => 'Viikko nyt';

  @override
  String get home => 'Start';

  @override
  String get weeks => 'Wochen';

  @override
  String get calendar => 'Kalender';

  @override
  String get tools => 'Rechner';

  @override
  String get more => 'Mehr';

  @override
  String get settings => 'Einstellungen';

  @override
  String get eyebrow => 'KALENDERWOCHEN-TOOL';

  @override
  String get homeTitle => 'Welche Kalenderwoche ist heute?';

  @override
  String get homeLead =>
      'Kalenderwochen, Datumsangaben und wichtige Kalendertage an einem Ort.';

  @override
  String get rightNow => 'GERADE JETZT';

  @override
  String get week => 'Woche';

  @override
  String weekLabel(int number) {
    return 'Woche $number';
  }

  @override
  String weekShort(int number) {
    return 'KW $number';
  }

  @override
  String yearLabel(int number) {
    return 'Jahr $number';
  }

  @override
  String weekOf(int current, int total) {
    return 'Woche $current / $total';
  }

  @override
  String yearProgress(int percent) {
    return '$percent % des Jahres vergangen';
  }

  @override
  String get weeksTotal => '52/53 Wochen';

  @override
  String get previous => 'Zurück';

  @override
  String get next => 'Weiter';

  @override
  String get today => 'Heute';

  @override
  String get thisWeek => 'Diese Woche';

  @override
  String get thisMonth => 'Dieser Monat';

  @override
  String get thisYear => 'Dieses Jahr';

  @override
  String get lookupTitle => 'Kalenderwoche zu einem beliebigen Datum finden';

  @override
  String get chooseDate => 'Datum wählen';

  @override
  String get dateToWeek => 'Datum zu Woche';

  @override
  String get weekToDate => 'Woche zu Datum';

  @override
  String get weekdayCalculator => 'Wochentag';

  @override
  String get openWeek => 'Wochendetails öffnen';

  @override
  String get year => 'Jahr';

  @override
  String get month => 'Monat';

  @override
  String get weekNumber => 'Kalenderwoche';

  @override
  String get dayOfYear => 'Tag des Jahres';

  @override
  String get daysRemaining => 'Verbleibende Tage';

  @override
  String get quarter => 'Quartal';

  @override
  String quarterLabel(int number) {
    return 'Quartal $number';
  }

  @override
  String get weekRange => 'Montag bis Sonntag';

  @override
  String dayCount(int count) {
    return '$count Tage';
  }

  @override
  String weekDaysResult(int weeks, int days) {
    return '$weeks Wochen und $days Tage';
  }

  @override
  String get holidays => 'Feiertage';

  @override
  String get flagDays => 'Beflaggungstage';

  @override
  String get schoolHolidays => 'Schulferien';

  @override
  String get nextHoliday => 'Nächster Feiertag';

  @override
  String get noEvents => 'Keine Gedenktage';

  @override
  String get official => 'Gesetzlicher Feiertag';

  @override
  String get observance => 'Gedenktag';

  @override
  String get all => 'Alle';

  @override
  String get confirmed => 'Bestätigt';

  @override
  String get estimated => 'geschätzt';

  @override
  String get unknown => 'Noch nicht veröffentlicht';

  @override
  String get noSchoolData =>
      'Für dieses Jahr liegen keine veröffentlichten Schulferiendaten vor.';

  @override
  String get schoolCoverage =>
      'Die Termine Ihrer Schule können vom kommunalen Kalender abweichen.';

  @override
  String get winterBreak => 'Winterferien';

  @override
  String get autumnBreak => 'Herbstferien';

  @override
  String get city => 'Stadt';

  @override
  String get source => 'Quelle';

  @override
  String verifiedAt(String date) {
    return 'Geprüft am $date';
  }

  @override
  String get daysBetween => 'Tage zwischen Daten';

  @override
  String get workingDaysBetween => 'Arbeitstagerechner';

  @override
  String get workingDays => 'Arbeitstage';

  @override
  String get weekends => 'Wochenenden';

  @override
  String get weekdayHolidays => 'Feiertage an Werktagen';

  @override
  String get totalDays => 'Tage insgesamt';

  @override
  String get firstDate => 'Startdatum';

  @override
  String get lastDate => 'Enddatum';

  @override
  String get invalidRange =>
      'Das Enddatum muss am oder nach dem Startdatum liegen.';

  @override
  String get distanceNote =>
      'Das Ergebnis ist der Abstand zwischen den Daten. Die Reihenfolge spielt keine Rolle.';

  @override
  String get workingNote =>
      'Beide Daten werden mitgezählt. Arbeitstage sind Montag bis Freitag ohne gesetzliche Feiertage. Heiligabend und Mittsommerabend gelten als Arbeitstage.';

  @override
  String get yearWeeks => 'Alle Wochen des Jahres';

  @override
  String get yearCalendar => 'Jahreskalender';

  @override
  String get firstHalf => 'Erstes Halbjahr';

  @override
  String get secondHalf => 'Zweites Halbjahr';

  @override
  String get wholeYear => 'Ganzes Jahr';

  @override
  String get yearWorkingDays => 'Arbeitstage pro Jahr';

  @override
  String get monthWorkingDays => 'Arbeitstage pro Monat';

  @override
  String get share => 'Teilen';

  @override
  String get openWebsite => 'Website öffnen';

  @override
  String get copy => 'Kopieren';

  @override
  String get copied => 'Kopiert';

  @override
  String get printPdf => 'Drucken / als PDF speichern';

  @override
  String get exportCsv => 'CSV exportieren';

  @override
  String get exportCalendar => 'Kalender exportieren (.ics)';

  @override
  String get exportFailed => 'Export fehlgeschlagen. Bitte erneut versuchen.';

  @override
  String get openFailed => 'Der Link konnte nicht geöffnet werden.';

  @override
  String get language => 'Sprache';

  @override
  String get finnish => 'Finnisch';

  @override
  String get english => 'Englisch';

  @override
  String get theme => 'Erscheinungsbild';

  @override
  String get system => 'System';

  @override
  String get light => 'Hell';

  @override
  String get dark => 'Dunkel';

  @override
  String get firstScreen => 'Startansicht';

  @override
  String get privacyNote =>
      'Funktioniert offline. Kein Konto. Die App nutzt Absturzberichte, Analysen und datenschutzgesteuerte Anzeigen.';

  @override
  String get dataCoverage =>
      'Kalenderdaten: 2020–2035. Schulferien nur für veröffentlichte Jahre verfügbar.';

  @override
  String get about => 'Über die App';

  @override
  String get licenses => 'Open-Source-Lizenzen';

  @override
  String get info => 'Über Kalenderwochen';

  @override
  String get faq => 'Häufige Fragen';

  @override
  String get methodology => 'Methodik';

  @override
  String get sources => 'Datenquellen';

  @override
  String get editorial => 'Redaktionelle Grundsätze';

  @override
  String get usComparison => 'Finnland und USA';

  @override
  String get isoWeek => 'ISO-Woche';

  @override
  String get usWeek => 'US-Woche';

  @override
  String get isoExplanation =>
      'Die Woche beginnt am Montag. Die erste ISO-Woche des Jahres enthält den 4. Januar. Das ISO-Wochenjahr kann vom Kalenderjahr abweichen.';

  @override
  String get openData => 'Offene Daten';

  @override
  String get dataExplorer => 'Kalenderdaten erkunden';

  @override
  String get bundledData => 'Mitgelieferter Datensatz';

  @override
  String get dataCopyNote => 'Das gewählte Jahr als JSON kopieren.';

  @override
  String get websiteResources => 'Mehr auf der Website';

  @override
  String get websiteResourcesNote =>
      'Weitere Dienste der Website öffnen sich im Browser und benötigen eine Internetverbindung.';

  @override
  String get contact => 'Kontakt';

  @override
  String get privacy => 'Datenschutz';

  @override
  String get terms => 'Nutzungsbedingungen';

  @override
  String get timeManagement => 'Zeitmanagement';

  @override
  String get sun => 'Sonne in Helsinki';

  @override
  String get sunrise => 'Sonnenaufgang';

  @override
  String get sunset => 'Sonnenuntergang';

  @override
  String get daylight => 'Tageslänge';

  @override
  String get polarDay => 'Mitternachtssonne';

  @override
  String get polarNight => 'Polarnacht';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours Std. $minutes Min.';
  }

  @override
  String get weekNotes => 'Wochennotiz';

  @override
  String get noteHint => 'Notiz für diese Woche schreiben…';

  @override
  String get saved => 'Auf diesem Gerät gespeichert';

  @override
  String get save => 'Speichern';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get notFound => 'Seite nicht gefunden';

  @override
  String get outOfRange => 'Wählen Sie ein Jahr zwischen 2020 und 2035.';

  @override
  String get backHome => 'Zurück zur Startseite';

  @override
  String get loadingError => 'Kalenderdaten konnten nicht geladen werden.';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get menu => 'Menü öffnen';

  @override
  String get dayDetails => 'Tagesdetails';

  @override
  String get close => 'Schließen';

  @override
  String get holidayRule => 'Datumsregel';

  @override
  String get fiContent => 'Das Quellmaterial der Website ist auf Finnisch.';

  @override
  String get nameDaysUnavailable =>
      'Namenstage werden ergänzt, sobald die Lizenzierung geklärt ist.';

  @override
  String get weekList => 'Wochenliste';
}
