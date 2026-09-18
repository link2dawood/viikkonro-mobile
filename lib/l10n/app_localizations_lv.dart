// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Latvian (`lv`).
class AppLocalizationsLv extends AppLocalizations {
  AppLocalizationsLv([String locale = 'lv']) : super(locale);

  @override
  String get appName => 'Viikkonro';

  @override
  String get wordmark => 'Viikko nyt';

  @override
  String get home => 'Sākums';

  @override
  String get weeks => 'Nedēļas';

  @override
  String get calendar => 'Kalendārs';

  @override
  String get tools => 'Kalkulatori';

  @override
  String get more => 'Vairāk';

  @override
  String get settings => 'Iestatījumi';

  @override
  String get eyebrow => 'NEDĒĻAS NUMURA RĪKS';

  @override
  String get homeTitle => 'Kura nedēļa ir tagad?';

  @override
  String get homeLead =>
      'Nedēļu numuri, datumi un svarīgas kalendāra dienas vienuviet.';

  @override
  String get rightNow => 'TIEŠI TAGAD';

  @override
  String get week => 'Nedēļa';

  @override
  String weekLabel(int number) {
    return 'Nedēļa $number';
  }

  @override
  String weekShort(int number) {
    return 'Ned. $number';
  }

  @override
  String yearLabel(int number) {
    return 'Gads $number';
  }

  @override
  String weekOf(int current, int total) {
    return 'Nedēļa $current / $total';
  }

  @override
  String yearProgress(int percent) {
    return 'Pagājuši $percent % no gada';
  }

  @override
  String get weeksTotal => '52/53 nedēļas';

  @override
  String get previous => 'Iepriekšējā';

  @override
  String get next => 'Nākamā';

  @override
  String get today => 'Šodien';

  @override
  String get thisWeek => 'Šī nedēļa';

  @override
  String get thisMonth => 'Šis mēnesis';

  @override
  String get thisYear => 'Šis gads';

  @override
  String get lookupTitle => 'Uzzini jebkura datuma nedēļas numuru';

  @override
  String get chooseDate => 'Izvēlies datumu';

  @override
  String get dateToWeek => 'Datums uz nedēļu';

  @override
  String get weekToDate => 'Nedēļa uz datumiem';

  @override
  String get weekdayCalculator => 'Nedēļas diena';

  @override
  String get openWeek => 'Atvērt nedēļas informāciju';

  @override
  String get year => 'Gads';

  @override
  String get month => 'Mēnesis';

  @override
  String get weekNumber => 'Nedēļas numurs';

  @override
  String get dayOfYear => 'Gada diena';

  @override
  String get daysRemaining => 'Atlikušās dienas';

  @override
  String get quarter => 'Ceturksnis';

  @override
  String quarterLabel(int number) {
    return '$number. ceturksnis';
  }

  @override
  String get weekRange => 'No pirmdienas līdz svētdienai';

  @override
  String dayCount(int count) {
    return '$count dienas';
  }

  @override
  String weekDaysResult(int weeks, int days) {
    return '$weeks nedēļas un $days dienas';
  }

  @override
  String get holidays => 'Svētku dienas';

  @override
  String get flagDays => 'Karoga dienas';

  @override
  String get schoolHolidays => 'Skolēnu brīvdienas';

  @override
  String get nextHoliday => 'Nākamā svētku diena';

  @override
  String get noEvents => 'Nav atzīmējamu dienu';

  @override
  String get official => 'Oficiāla svētku diena';

  @override
  String get observance => 'Atzīmējama diena';

  @override
  String get all => 'Visas';

  @override
  String get confirmed => 'Apstiprināts';

  @override
  String get estimated => 'aptuvens';

  @override
  String get unknown => 'Vēl nav publicēts';

  @override
  String get noSchoolData =>
      'Par šo gadu nav publicētu datu par skolēnu brīvdienām.';

  @override
  String get schoolCoverage =>
      'Tavas skolas datumi var atšķirties no pašvaldības kalendāra.';

  @override
  String get winterBreak => 'Ziemas brīvlaiks';

  @override
  String get autumnBreak => 'Rudens brīvlaiks';

  @override
  String get city => 'Pilsēta';

  @override
  String get source => 'Avots';

  @override
  String verifiedAt(String date) {
    return 'Pārbaudīts $date';
  }

  @override
  String get daysBetween => 'Dienas starp datumiem';

  @override
  String get workingDaysBetween => 'Darbdienu kalkulators';

  @override
  String get workingDays => 'Darbdienas';

  @override
  String get weekends => 'Nedēļas nogales';

  @override
  String get weekdayHolidays => 'Svētku dienas darbdienās';

  @override
  String get totalDays => 'Dienas kopā';

  @override
  String get firstDate => 'Sākuma datums';

  @override
  String get lastDate => 'Beigu datums';

  @override
  String get invalidRange =>
      'Beigu datumam jābūt tādam pašam vai vēlākam par sākuma datumu.';

  @override
  String get distanceNote =>
      'Rezultāts ir attālums starp datumiem. Secībai nav nozīmes.';

  @override
  String get workingNote =>
      'Abi datumi tiek ieskaitīti. Darbdienas ir no pirmdienas līdz piektdienai, izņemot oficiālās svētku dienas. Ziemassvētku vakars un Jāņu vakars skaitās darbdienas.';

  @override
  String get yearWeeks => 'Visas gada nedēļas';

  @override
  String get yearCalendar => 'Gada kalendārs';

  @override
  String get firstHalf => 'Pirmais pusgads';

  @override
  String get secondHalf => 'Otrais pusgads';

  @override
  String get wholeYear => 'Viss gads';

  @override
  String get yearWorkingDays => 'Darbdienas gadā';

  @override
  String get monthWorkingDays => 'Darbdienas mēnesī';

  @override
  String get share => 'Kopīgot';

  @override
  String get openWebsite => 'Atvērt vietni';

  @override
  String get copy => 'Kopēt';

  @override
  String get copied => 'Nokopēts';

  @override
  String get printPdf => 'Drukāt / saglabāt PDF';

  @override
  String get exportCsv => 'Eksportēt CSV';

  @override
  String get exportCalendar => 'Eksportēt kalendāru (.ics)';

  @override
  String get exportFailed => 'Eksportēšana neizdevās. Mēģini vēlreiz.';

  @override
  String get openFailed => 'Saiti neizdevās atvērt.';

  @override
  String get language => 'Valoda';

  @override
  String get finnish => 'Somu';

  @override
  String get english => 'Angļu';

  @override
  String get theme => 'Izskats';

  @override
  String get system => 'Sistēmas';

  @override
  String get light => 'Gaišs';

  @override
  String get dark => 'Tumšs';

  @override
  String get firstScreen => 'Sākuma skats';

  @override
  String get privacyNote =>
      'Darbojas bezsaistē. Konts nav vajadzīgs. Lietotne izmanto avāriju pārskatus, analītiku un reklāmas ar privātuma vadību.';

  @override
  String get dataCoverage =>
      'Kalendāra dati: 2020–2035. Skolēnu brīvdienas pieejamas tikai publicētajiem gadiem.';

  @override
  String get about => 'Par lietotni';

  @override
  String get licenses => 'Atvērtā koda licences';

  @override
  String get info => 'Par nedēļu numuriem';

  @override
  String get faq => 'Biežāk uzdotie jautājumi';

  @override
  String get methodology => 'Metodika';

  @override
  String get sources => 'Datu avoti';

  @override
  String get editorial => 'Redakcionālie principi';

  @override
  String get usComparison => 'Somija un ASV';

  @override
  String get isoWeek => 'ISO nedēļa';

  @override
  String get usWeek => 'ASV nedēļa';

  @override
  String get isoExplanation =>
      'Nedēļa sākas pirmdienā. Gada pirmajā ISO nedēļā ir 4. janvāris. ISO nedēļas gads var atšķirties no kalendārā gada.';

  @override
  String get openData => 'Atvērtie dati';

  @override
  String get dataExplorer => 'Aplūkot kalendāra datus';

  @override
  String get bundledData => 'Iekļautā datu kopa';

  @override
  String get dataCopyNote => 'Kopē izvēlēto gadu JSON formātā.';

  @override
  String get websiteResources => 'Vairāk vietnē';

  @override
  String get websiteResourcesNote =>
      'Pārējie vietnes pakalpojumi atveras pārlūkā un prasa interneta savienojumu.';

  @override
  String get contact => 'Kontakti';

  @override
  String get privacy => 'Privātums';

  @override
  String get terms => 'Noteikumi';

  @override
  String get timeManagement => 'Laika plānošana';

  @override
  String get sun => 'Saule Helsinkos';

  @override
  String get sunrise => 'Saullēkts';

  @override
  String get sunset => 'Saulriets';

  @override
  String get daylight => 'Dienas garums';

  @override
  String get polarDay => 'Baltās naktis';

  @override
  String get polarNight => 'Polārā nakts';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours st $minutes min';
  }

  @override
  String get weekNotes => 'Nedēļas piezīme';

  @override
  String get noteHint => 'Uzraksti piezīmi par šo nedēļu…';

  @override
  String get saved => 'Saglabāts šajā ierīcē';

  @override
  String get save => 'Saglabāt';

  @override
  String get cancel => 'Atcelt';

  @override
  String get notFound => 'Lapa nav atrasta';

  @override
  String get outOfRange => 'Izvēlies gadu no 2020 līdz 2035.';

  @override
  String get backHome => 'Atpakaļ uz sākumu';

  @override
  String get loadingError => 'Kalendāra datus neizdevās ielādēt.';

  @override
  String get retry => 'Mēģināt vēlreiz';

  @override
  String get menu => 'Atvērt izvēlni';

  @override
  String get dayDetails => 'Dienas informācija';

  @override
  String get close => 'Aizvērt';

  @override
  String get holidayRule => 'Datuma noteikums';

  @override
  String get fiContent => 'Vietnes pirmavots ir somu valodā.';

  @override
  String get nameDaysUnavailable =>
      'Vārda dienas tiks pievienotas pēc licences apstiprināšanas.';

  @override
  String get weekList => 'Nedēļu saraksts';
}
