import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ca.dart';
import 'app_localizations_cs.dart';
import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_et.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_is.dart';
import 'app_localizations_it.dart';
import 'app_localizations_lt.dart';
import 'app_localizations_lv.dart';
import 'app_localizations_nb.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_sl.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ca'),
    Locale('cs'),
    Locale('da'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('et'),
    Locale('fi'),
    Locale('fr'),
    Locale('is'),
    Locale('it'),
    Locale('lt'),
    Locale('lv'),
    Locale('nb'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('ro'),
    Locale('sl'),
    Locale('sv'),
    Locale('tr'),
    Locale('uk'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Viikkonro'**
  String get appName;

  /// No description provided for @wordmark.
  ///
  /// In en, this message translates to:
  /// **'Viikko nyt'**
  String get wordmark;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @weeks.
  ///
  /// In en, this message translates to:
  /// **'Weeks'**
  String get weeks;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @tools.
  ///
  /// In en, this message translates to:
  /// **'Calculators'**
  String get tools;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @eyebrow.
  ///
  /// In en, this message translates to:
  /// **'WEEK NUMBER TOOL'**
  String get eyebrow;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'What week is it?'**
  String get homeTitle;

  /// No description provided for @homeLead.
  ///
  /// In en, this message translates to:
  /// **'Week numbers, dates and important calendar days in one place.'**
  String get homeLead;

  /// No description provided for @rightNow.
  ///
  /// In en, this message translates to:
  /// **'RIGHT NOW'**
  String get rightNow;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @weekLabel.
  ///
  /// In en, this message translates to:
  /// **'Week {number}'**
  String weekLabel(int number);

  /// No description provided for @weekShort.
  ///
  /// In en, this message translates to:
  /// **'Wk {number}'**
  String weekShort(int number);

  /// No description provided for @yearLabel.
  ///
  /// In en, this message translates to:
  /// **'Year {number}'**
  String yearLabel(int number);

  /// No description provided for @weekOf.
  ///
  /// In en, this message translates to:
  /// **'Week {current} / {total}'**
  String weekOf(int current, int total);

  /// No description provided for @yearProgress.
  ///
  /// In en, this message translates to:
  /// **'{percent}% through the year'**
  String yearProgress(int percent);

  /// No description provided for @weeksTotal.
  ///
  /// In en, this message translates to:
  /// **'52/53 weeks'**
  String get weeksTotal;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @thisWeek.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get thisWeek;

  /// No description provided for @thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get thisMonth;

  /// No description provided for @thisYear.
  ///
  /// In en, this message translates to:
  /// **'This year'**
  String get thisYear;

  /// No description provided for @lookupTitle.
  ///
  /// In en, this message translates to:
  /// **'Find the week number of any date'**
  String get lookupTitle;

  /// No description provided for @chooseDate.
  ///
  /// In en, this message translates to:
  /// **'Choose a date'**
  String get chooseDate;

  /// No description provided for @dateToWeek.
  ///
  /// In en, this message translates to:
  /// **'Date to week'**
  String get dateToWeek;

  /// No description provided for @weekToDate.
  ///
  /// In en, this message translates to:
  /// **'Week to dates'**
  String get weekToDate;

  /// No description provided for @weekdayCalculator.
  ///
  /// In en, this message translates to:
  /// **'Day of the week'**
  String get weekdayCalculator;

  /// No description provided for @openWeek.
  ///
  /// In en, this message translates to:
  /// **'Open week details'**
  String get openWeek;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @weekNumber.
  ///
  /// In en, this message translates to:
  /// **'Week number'**
  String get weekNumber;

  /// No description provided for @dayOfYear.
  ///
  /// In en, this message translates to:
  /// **'Day of year'**
  String get dayOfYear;

  /// No description provided for @daysRemaining.
  ///
  /// In en, this message translates to:
  /// **'Days remaining'**
  String get daysRemaining;

  /// No description provided for @quarter.
  ///
  /// In en, this message translates to:
  /// **'Quarter'**
  String get quarter;

  /// No description provided for @quarterLabel.
  ///
  /// In en, this message translates to:
  /// **'Quarter {number}'**
  String quarterLabel(int number);

  /// No description provided for @weekRange.
  ///
  /// In en, this message translates to:
  /// **'Monday to Sunday'**
  String get weekRange;

  /// No description provided for @dayCount.
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String dayCount(int count);

  /// No description provided for @weekDaysResult.
  ///
  /// In en, this message translates to:
  /// **'{weeks} weeks and {days} days'**
  String weekDaysResult(int weeks, int days);

  /// No description provided for @holidays.
  ///
  /// In en, this message translates to:
  /// **'Public holidays'**
  String get holidays;

  /// No description provided for @flagDays.
  ///
  /// In en, this message translates to:
  /// **'Flag days'**
  String get flagDays;

  /// No description provided for @schoolHolidays.
  ///
  /// In en, this message translates to:
  /// **'School holidays'**
  String get schoolHolidays;

  /// No description provided for @nextHoliday.
  ///
  /// In en, this message translates to:
  /// **'Next public holiday'**
  String get nextHoliday;

  /// No description provided for @noEvents.
  ///
  /// In en, this message translates to:
  /// **'No observances'**
  String get noEvents;

  /// No description provided for @official.
  ///
  /// In en, this message translates to:
  /// **'Official public holiday'**
  String get official;

  /// No description provided for @observance.
  ///
  /// In en, this message translates to:
  /// **'Observance'**
  String get observance;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @confirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get confirmed;

  /// No description provided for @estimated.
  ///
  /// In en, this message translates to:
  /// **'estimated'**
  String get estimated;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Not yet published'**
  String get unknown;

  /// No description provided for @noSchoolData.
  ///
  /// In en, this message translates to:
  /// **'No published school holiday data for this year.'**
  String get noSchoolData;

  /// No description provided for @schoolCoverage.
  ///
  /// In en, this message translates to:
  /// **'Your school dates may differ from the municipal calendar.'**
  String get schoolCoverage;

  /// No description provided for @winterBreak.
  ///
  /// In en, this message translates to:
  /// **'Winter break'**
  String get winterBreak;

  /// No description provided for @autumnBreak.
  ///
  /// In en, this message translates to:
  /// **'Autumn break'**
  String get autumnBreak;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @source.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get source;

  /// No description provided for @verifiedAt.
  ///
  /// In en, this message translates to:
  /// **'Verified {date}'**
  String verifiedAt(String date);

  /// No description provided for @daysBetween.
  ///
  /// In en, this message translates to:
  /// **'Days between dates'**
  String get daysBetween;

  /// No description provided for @workingDaysBetween.
  ///
  /// In en, this message translates to:
  /// **'Working day calculator'**
  String get workingDaysBetween;

  /// No description provided for @workingDays.
  ///
  /// In en, this message translates to:
  /// **'Working days'**
  String get workingDays;

  /// No description provided for @weekends.
  ///
  /// In en, this message translates to:
  /// **'Weekends'**
  String get weekends;

  /// No description provided for @weekdayHolidays.
  ///
  /// In en, this message translates to:
  /// **'Weekday public holidays'**
  String get weekdayHolidays;

  /// No description provided for @totalDays.
  ///
  /// In en, this message translates to:
  /// **'Total days'**
  String get totalDays;

  /// No description provided for @firstDate.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get firstDate;

  /// No description provided for @lastDate.
  ///
  /// In en, this message translates to:
  /// **'End date'**
  String get lastDate;

  /// No description provided for @invalidRange.
  ///
  /// In en, this message translates to:
  /// **'End date must be on or after the start date.'**
  String get invalidRange;

  /// No description provided for @distanceNote.
  ///
  /// In en, this message translates to:
  /// **'The result is the distance between dates. Either order is accepted.'**
  String get distanceNote;

  /// No description provided for @workingNote.
  ///
  /// In en, this message translates to:
  /// **'Both dates are included. Working days are Monday–Friday excluding official public holidays. Christmas Eve and Midsummer Eve count as working days.'**
  String get workingNote;

  /// No description provided for @yearWeeks.
  ///
  /// In en, this message translates to:
  /// **'All weeks of the year'**
  String get yearWeeks;

  /// No description provided for @yearCalendar.
  ///
  /// In en, this message translates to:
  /// **'Year calendar'**
  String get yearCalendar;

  /// No description provided for @firstHalf.
  ///
  /// In en, this message translates to:
  /// **'First half'**
  String get firstHalf;

  /// No description provided for @secondHalf.
  ///
  /// In en, this message translates to:
  /// **'Second half'**
  String get secondHalf;

  /// No description provided for @wholeYear.
  ///
  /// In en, this message translates to:
  /// **'Whole year'**
  String get wholeYear;

  /// No description provided for @yearWorkingDays.
  ///
  /// In en, this message translates to:
  /// **'Working days by year'**
  String get yearWorkingDays;

  /// No description provided for @monthWorkingDays.
  ///
  /// In en, this message translates to:
  /// **'Monthly working days'**
  String get monthWorkingDays;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @openWebsite.
  ///
  /// In en, this message translates to:
  /// **'Open website'**
  String get openWebsite;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @printPdf.
  ///
  /// In en, this message translates to:
  /// **'Print / save PDF'**
  String get printPdf;

  /// No description provided for @exportCsv.
  ///
  /// In en, this message translates to:
  /// **'Export CSV'**
  String get exportCsv;

  /// No description provided for @exportCalendar.
  ///
  /// In en, this message translates to:
  /// **'Export calendar (.ics)'**
  String get exportCalendar;

  /// No description provided for @exportFailed.
  ///
  /// In en, this message translates to:
  /// **'Export failed. Please try again.'**
  String get exportFailed;

  /// No description provided for @openFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open the link.'**
  String get openFailed;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @finnish.
  ///
  /// In en, this message translates to:
  /// **'Finnish'**
  String get finnish;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get theme;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @firstScreen.
  ///
  /// In en, this message translates to:
  /// **'First screen'**
  String get firstScreen;

  /// No description provided for @privacyNote.
  ///
  /// In en, this message translates to:
  /// **'Works offline. No account, analytics or advertising.'**
  String get privacyNote;

  /// No description provided for @dataCoverage.
  ///
  /// In en, this message translates to:
  /// **'Calendar data: 2020–2035. School holidays are available for published years only.'**
  String get dataCoverage;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About the app'**
  String get about;

  /// No description provided for @licenses.
  ///
  /// In en, this message translates to:
  /// **'Open source licenses'**
  String get licenses;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'About week numbers'**
  String get info;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'Frequently asked questions'**
  String get faq;

  /// No description provided for @methodology.
  ///
  /// In en, this message translates to:
  /// **'Methodology'**
  String get methodology;

  /// No description provided for @sources.
  ///
  /// In en, this message translates to:
  /// **'Data sources'**
  String get sources;

  /// No description provided for @editorial.
  ///
  /// In en, this message translates to:
  /// **'Editorial policy'**
  String get editorial;

  /// No description provided for @usComparison.
  ///
  /// In en, this message translates to:
  /// **'Finland and USA'**
  String get usComparison;

  /// No description provided for @isoWeek.
  ///
  /// In en, this message translates to:
  /// **'ISO week'**
  String get isoWeek;

  /// No description provided for @usWeek.
  ///
  /// In en, this message translates to:
  /// **'US week'**
  String get usWeek;

  /// No description provided for @isoExplanation.
  ///
  /// In en, this message translates to:
  /// **'Weeks start on Monday. The first ISO week contains 4 January. The ISO week year may differ from the calendar year.'**
  String get isoExplanation;

  /// No description provided for @openData.
  ///
  /// In en, this message translates to:
  /// **'Open data'**
  String get openData;

  /// No description provided for @dataExplorer.
  ///
  /// In en, this message translates to:
  /// **'Explore calendar data'**
  String get dataExplorer;

  /// No description provided for @bundledData.
  ///
  /// In en, this message translates to:
  /// **'Bundled data snapshot'**
  String get bundledData;

  /// No description provided for @dataCopyNote.
  ///
  /// In en, this message translates to:
  /// **'Copy the selected year as JSON.'**
  String get dataCopyNote;

  /// No description provided for @websiteResources.
  ///
  /// In en, this message translates to:
  /// **'More on the website'**
  String get websiteResources;

  /// No description provided for @websiteResourcesNote.
  ///
  /// In en, this message translates to:
  /// **'Additional website services open in your browser and need an internet connection.'**
  String get websiteResourcesNote;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get terms;

  /// No description provided for @timeManagement.
  ///
  /// In en, this message translates to:
  /// **'Time management'**
  String get timeManagement;

  /// No description provided for @sun.
  ///
  /// In en, this message translates to:
  /// **'Sun in Helsinki'**
  String get sun;

  /// No description provided for @sunrise.
  ///
  /// In en, this message translates to:
  /// **'Sunrise'**
  String get sunrise;

  /// No description provided for @sunset.
  ///
  /// In en, this message translates to:
  /// **'Sunset'**
  String get sunset;

  /// No description provided for @daylight.
  ///
  /// In en, this message translates to:
  /// **'Daylight'**
  String get daylight;

  /// No description provided for @polarDay.
  ///
  /// In en, this message translates to:
  /// **'Midnight sun'**
  String get polarDay;

  /// No description provided for @polarNight.
  ///
  /// In en, this message translates to:
  /// **'Polar night'**
  String get polarNight;

  /// No description provided for @hoursMinutes.
  ///
  /// In en, this message translates to:
  /// **'{hours} h {minutes} min'**
  String hoursMinutes(int hours, int minutes);

  /// No description provided for @weekNotes.
  ///
  /// In en, this message translates to:
  /// **'Week note'**
  String get weekNotes;

  /// No description provided for @noteHint.
  ///
  /// In en, this message translates to:
  /// **'Write a note for this week…'**
  String get noteHint;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved on this device'**
  String get saved;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @notFound.
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get notFound;

  /// No description provided for @outOfRange.
  ///
  /// In en, this message translates to:
  /// **'Choose a year between 2020 and 2035.'**
  String get outOfRange;

  /// No description provided for @backHome.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get backHome;

  /// No description provided for @loadingError.
  ///
  /// In en, this message translates to:
  /// **'Calendar data could not be loaded.'**
  String get loadingError;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Open menu'**
  String get menu;

  /// No description provided for @dayDetails.
  ///
  /// In en, this message translates to:
  /// **'Day details'**
  String get dayDetails;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @holidayRule.
  ///
  /// In en, this message translates to:
  /// **'Date rule'**
  String get holidayRule;

  /// No description provided for @fiContent.
  ///
  /// In en, this message translates to:
  /// **'The website source material is in Finnish.'**
  String get fiContent;

  /// No description provided for @nameDaysUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Name days will be added after licensing is verified.'**
  String get nameDaysUnavailable;

  /// No description provided for @weekList.
  ///
  /// In en, this message translates to:
  /// **'Week list'**
  String get weekList;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ca', 'cs', 'da', 'de', 'en', 'es', 'et', 'fi', 'fr', 'is', 'it', 'lt', 'lv', 'nb', 'nl', 'pl', 'pt', 'ro', 'sl', 'sv', 'tr', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ca':
      return AppLocalizationsCa();
    case 'cs':
      return AppLocalizationsCs();
    case 'da':
      return AppLocalizationsDa();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'et':
      return AppLocalizationsEt();
    case 'fi':
      return AppLocalizationsFi();
    case 'fr':
      return AppLocalizationsFr();
    case 'is':
      return AppLocalizationsIs();
    case 'it':
      return AppLocalizationsIt();
    case 'lt':
      return AppLocalizationsLt();
    case 'lv':
      return AppLocalizationsLv();
    case 'nb':
      return AppLocalizationsNb();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ro':
      return AppLocalizationsRo();
    case 'sl':
      return AppLocalizationsSl();
    case 'sv':
      return AppLocalizationsSv();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
