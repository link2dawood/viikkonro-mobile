// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Viikkonro';

  @override
  String get wordmark => 'Viikko nyt';

  @override
  String get home => 'Home';

  @override
  String get weeks => 'Weeks';

  @override
  String get calendar => 'Calendar';

  @override
  String get tools => 'Calculators';

  @override
  String get more => 'More';

  @override
  String get settings => 'Settings';

  @override
  String get eyebrow => 'WEEK NUMBER TOOL';

  @override
  String get homeTitle => 'What week is it?';

  @override
  String get homeLead => 'Week numbers, dates and important calendar days in one place.';

  @override
  String get rightNow => 'RIGHT NOW';

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
    return 'Year $number';
  }

  @override
  String weekOf(int current, int total) {
    return 'Week $current / $total';
  }

  @override
  String yearProgress(int percent) {
    return '$percent% through the year';
  }

  @override
  String get weeksTotal => '52/53 weeks';

  @override
  String get previous => 'Previous';

  @override
  String get next => 'Next';

  @override
  String get today => 'Today';

  @override
  String get thisWeek => 'This week';

  @override
  String get thisMonth => 'This month';

  @override
  String get thisYear => 'This year';

  @override
  String get lookupTitle => 'Find the week number of any date';

  @override
  String get chooseDate => 'Choose a date';

  @override
  String get dateToWeek => 'Date to week';

  @override
  String get weekToDate => 'Week to dates';

  @override
  String get weekdayCalculator => 'Day of the week';

  @override
  String get openWeek => 'Open week details';

  @override
  String get year => 'Year';

  @override
  String get month => 'Month';

  @override
  String get weekNumber => 'Week number';

  @override
  String get dayOfYear => 'Day of year';

  @override
  String get daysRemaining => 'Days remaining';

  @override
  String get quarter => 'Quarter';

  @override
  String quarterLabel(int number) {
    return 'Quarter $number';
  }

  @override
  String get weekRange => 'Monday to Sunday';

  @override
  String dayCount(int count) {
    return '$count days';
  }

  @override
  String weekDaysResult(int weeks, int days) {
    return '$weeks weeks and $days days';
  }

  @override
  String get holidays => 'Public holidays';

  @override
  String get flagDays => 'Flag days';

  @override
  String get schoolHolidays => 'School holidays';

  @override
  String get nextHoliday => 'Next public holiday';

  @override
  String get noEvents => 'No observances';

  @override
  String get official => 'Official public holiday';

  @override
  String get observance => 'Observance';

  @override
  String get all => 'All';

  @override
  String get confirmed => 'Confirmed';

  @override
  String get estimated => 'estimated';

  @override
  String get unknown => 'Not yet published';

  @override
  String get noSchoolData => 'No published school holiday data for this year.';

  @override
  String get schoolCoverage => 'Your school dates may differ from the municipal calendar.';

  @override
  String get winterBreak => 'Winter break';

  @override
  String get autumnBreak => 'Autumn break';

  @override
  String get city => 'City';

  @override
  String get source => 'Source';

  @override
  String verifiedAt(String date) {
    return 'Verified $date';
  }

  @override
  String get daysBetween => 'Days between dates';

  @override
  String get workingDaysBetween => 'Working day calculator';

  @override
  String get workingDays => 'Working days';

  @override
  String get weekends => 'Weekends';

  @override
  String get weekdayHolidays => 'Weekday public holidays';

  @override
  String get totalDays => 'Total days';

  @override
  String get firstDate => 'Start date';

  @override
  String get lastDate => 'End date';

  @override
  String get invalidRange => 'End date must be on or after the start date.';

  @override
  String get distanceNote => 'The result is the distance between dates. Either order is accepted.';

  @override
  String get workingNote => 'Both dates are included. Working days are Monday–Friday excluding official public holidays. Christmas Eve and Midsummer Eve count as working days.';

  @override
  String get yearWeeks => 'All weeks of the year';

  @override
  String get yearCalendar => 'Year calendar';

  @override
  String get firstHalf => 'First half';

  @override
  String get secondHalf => 'Second half';

  @override
  String get wholeYear => 'Whole year';

  @override
  String get yearWorkingDays => 'Working days by year';

  @override
  String get monthWorkingDays => 'Monthly working days';

  @override
  String get share => 'Share';

  @override
  String get openWebsite => 'Open website';

  @override
  String get copy => 'Copy';

  @override
  String get copied => 'Copied';

  @override
  String get printPdf => 'Print / save PDF';

  @override
  String get exportCsv => 'Export CSV';

  @override
  String get exportCalendar => 'Export calendar (.ics)';

  @override
  String get exportFailed => 'Export failed. Please try again.';

  @override
  String get openFailed => 'Could not open the link.';

  @override
  String get language => 'Language';

  @override
  String get finnish => 'Finnish';

  @override
  String get english => 'English';

  @override
  String get theme => 'Appearance';

  @override
  String get system => 'System';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get firstScreen => 'First screen';

  @override
  String get privacyNote => 'Works offline. No account, analytics or advertising.';

  @override
  String get dataCoverage => 'Calendar data: 2020–2035. School holidays are available for published years only.';

  @override
  String get about => 'About the app';

  @override
  String get licenses => 'Open source licenses';

  @override
  String get info => 'About week numbers';

  @override
  String get faq => 'Frequently asked questions';

  @override
  String get methodology => 'Methodology';

  @override
  String get sources => 'Data sources';

  @override
  String get editorial => 'Editorial policy';

  @override
  String get usComparison => 'Finland and USA';

  @override
  String get isoWeek => 'ISO week';

  @override
  String get usWeek => 'US week';

  @override
  String get isoExplanation => 'Weeks start on Monday. The first ISO week contains 4 January. The ISO week year may differ from the calendar year.';

  @override
  String get openData => 'Open data';

  @override
  String get dataExplorer => 'Explore calendar data';

  @override
  String get bundledData => 'Bundled data snapshot';

  @override
  String get dataCopyNote => 'Copy the selected year as JSON.';

  @override
  String get websiteResources => 'More on the website';

  @override
  String get websiteResourcesNote => 'Additional website services open in your browser and need an internet connection.';

  @override
  String get contact => 'Contact';

  @override
  String get privacy => 'Privacy';

  @override
  String get terms => 'Terms';

  @override
  String get timeManagement => 'Time management';

  @override
  String get sun => 'Sun in Helsinki';

  @override
  String get sunrise => 'Sunrise';

  @override
  String get sunset => 'Sunset';

  @override
  String get daylight => 'Daylight';

  @override
  String get polarDay => 'Midnight sun';

  @override
  String get polarNight => 'Polar night';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get weekNotes => 'Week note';

  @override
  String get noteHint => 'Write a note for this week…';

  @override
  String get saved => 'Saved on this device';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get notFound => 'Page not found';

  @override
  String get outOfRange => 'Choose a year between 2020 and 2035.';

  @override
  String get backHome => 'Back to home';

  @override
  String get loadingError => 'Calendar data could not be loaded.';

  @override
  String get retry => 'Retry';

  @override
  String get menu => 'Open menu';

  @override
  String get dayDetails => 'Day details';

  @override
  String get close => 'Close';

  @override
  String get holidayRule => 'Date rule';

  @override
  String get fiContent => 'The website source material is in Finnish.';

  @override
  String get nameDaysUnavailable => 'Name days will be added after licensing is verified.';

  @override
  String get weekList => 'Week list';
}
