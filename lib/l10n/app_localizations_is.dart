// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Icelandic (`is`).
class AppLocalizationsIs extends AppLocalizations {
  AppLocalizationsIs([String locale = 'is']) : super(locale);

  @override
  String get appName => 'Viikkonro';

  @override
  String get wordmark => 'Viikko nyt';

  @override
  String get home => 'Heim';

  @override
  String get weeks => 'Vikur';

  @override
  String get calendar => 'Dagatal';

  @override
  String get tools => 'Reiknivélar';

  @override
  String get more => 'Meira';

  @override
  String get settings => 'Stillingar';

  @override
  String get eyebrow => 'VIKUNÚMERATÓL';

  @override
  String get homeTitle => 'Hvaða vika er núna?';

  @override
  String get homeLead =>
      'Vikunúmer, dagsetningar og mikilvægir dagar á einum stað.';

  @override
  String get rightNow => 'AKKÚRAT NÚNA';

  @override
  String get week => 'Vika';

  @override
  String weekLabel(int number) {
    return 'Vika $number';
  }

  @override
  String weekShort(int number) {
    return 'V $number';
  }

  @override
  String yearLabel(int number) {
    return 'Ár $number';
  }

  @override
  String weekOf(int current, int total) {
    return 'Vika $current / $total';
  }

  @override
  String yearProgress(int percent) {
    return '$percent % ársins liðin';
  }

  @override
  String get weeksTotal => '52/53 vikur';

  @override
  String get previous => 'Fyrri';

  @override
  String get next => 'Næsta';

  @override
  String get today => 'Í dag';

  @override
  String get thisWeek => 'Þessi vika';

  @override
  String get thisMonth => 'Þessi mánuður';

  @override
  String get thisYear => 'Í ár';

  @override
  String get lookupTitle => 'Finndu vikunúmer hvaða dags sem er';

  @override
  String get chooseDate => 'Veldu dagsetningu';

  @override
  String get dateToWeek => 'Dagsetning í viku';

  @override
  String get weekToDate => 'Vika í dagsetningar';

  @override
  String get weekdayCalculator => 'Vikudagur';

  @override
  String get openWeek => 'Opna upplýsingar vikunnar';

  @override
  String get year => 'Ár';

  @override
  String get month => 'Mánuður';

  @override
  String get weekNumber => 'Vikunúmer';

  @override
  String get dayOfYear => 'Dagur ársins';

  @override
  String get daysRemaining => 'Dagar eftir';

  @override
  String get quarter => 'Ársfjórðungur';

  @override
  String quarterLabel(int number) {
    return 'Ársfjórðungur $number';
  }

  @override
  String get weekRange => 'Mánudagur til sunnudags';

  @override
  String dayCount(int count) {
    return '$count dagar';
  }

  @override
  String weekDaysResult(int weeks, int days) {
    return '$weeks vikur og $days dagar';
  }

  @override
  String get holidays => 'Frídagar';

  @override
  String get flagDays => 'Fánadagar';

  @override
  String get schoolHolidays => 'Skólafrí';

  @override
  String get nextHoliday => 'Næsti frídagur';

  @override
  String get noEvents => 'Engir merkisdagar';

  @override
  String get official => 'Opinber frídagur';

  @override
  String get observance => 'Merkisdagur';

  @override
  String get all => 'Allt';

  @override
  String get confirmed => 'Staðfest';

  @override
  String get estimated => 'áætlað';

  @override
  String get unknown => 'Ekki enn birt';

  @override
  String get noSchoolData =>
      'Engar birtar upplýsingar um skólafrí fyrir þetta ár.';

  @override
  String get schoolCoverage =>
      'Dagsetningar skólans geta verið aðrar en dagatal sveitarfélagsins.';

  @override
  String get winterBreak => 'Vetrarfrí';

  @override
  String get autumnBreak => 'Haustfrí';

  @override
  String get city => 'Borg';

  @override
  String get source => 'Heimild';

  @override
  String verifiedAt(String date) {
    return 'Staðfest $date';
  }

  @override
  String get daysBetween => 'Dagar milli dagsetninga';

  @override
  String get workingDaysBetween => 'Virkra daga reiknivél';

  @override
  String get workingDays => 'Virkir dagar';

  @override
  String get weekends => 'Helgar';

  @override
  String get weekdayHolidays => 'Frídagar á virkum dögum';

  @override
  String get totalDays => 'Dagar alls';

  @override
  String get firstDate => 'Upphafsdagur';

  @override
  String get lastDate => 'Lokadagur';

  @override
  String get invalidRange =>
      'Lokadagur verður að vera sami dagur eða síðar en upphafsdagur.';

  @override
  String get distanceNote =>
      'Niðurstaðan er fjarlægðin milli dagsetninganna. Röðin skiptir ekki máli.';

  @override
  String get workingNote =>
      'Báðar dagsetningar teljast með. Virkir dagar eru mánudagur–föstudagur að frátöldum opinberum frídögum. Aðfangadagur og Jónsmessuaðfangadagur teljast virkir dagar.';

  @override
  String get yearWeeks => 'Allar vikur ársins';

  @override
  String get yearCalendar => 'Ársdagatal';

  @override
  String get firstHalf => 'Fyrri hluti árs';

  @override
  String get secondHalf => 'Seinni hluti árs';

  @override
  String get wholeYear => 'Allt árið';

  @override
  String get yearWorkingDays => 'Virkir dagar á ári';

  @override
  String get monthWorkingDays => 'Virkir dagar í mánuði';

  @override
  String get share => 'Deila';

  @override
  String get openWebsite => 'Opna vefsíðuna';

  @override
  String get copy => 'Afrita';

  @override
  String get copied => 'Afritað';

  @override
  String get printPdf => 'Prenta / vista PDF';

  @override
  String get exportCsv => 'Flytja út CSV';

  @override
  String get exportCalendar => 'Flytja út dagatal (.ics)';

  @override
  String get exportFailed => 'Útflutningur mistókst. Reyndu aftur.';

  @override
  String get openFailed => 'Ekki tókst að opna tengilinn.';

  @override
  String get language => 'Tungumál';

  @override
  String get finnish => 'Finnska';

  @override
  String get english => 'Enska';

  @override
  String get theme => 'Útlit';

  @override
  String get system => 'Kerfi';

  @override
  String get light => 'Ljóst';

  @override
  String get dark => 'Dökkt';

  @override
  String get firstScreen => 'Upphafsskjár';

  @override
  String get privacyNote =>
      'Virkar án nettengingar. Enginn reikningur þarf. Forritið notar hrunskýrslur, greiningu og auglýsingar með persónuverndarstýringu.';

  @override
  String get dataCoverage =>
      'Dagatalsgögn: 2020–2035. Skólafrí eru aðeins til fyrir birt ár.';

  @override
  String get about => 'Um forritið';

  @override
  String get licenses => 'Opinn hugbúnaður – leyfi';

  @override
  String get info => 'Um vikunúmer';

  @override
  String get faq => 'Algengar spurningar';

  @override
  String get methodology => 'Aðferðafræði';

  @override
  String get sources => 'Heimildir';

  @override
  String get editorial => 'Ritstjórnarstefna';

  @override
  String get usComparison => 'Finnland og Bandaríkin';

  @override
  String get isoWeek => 'ISO-vika';

  @override
  String get usWeek => 'Bandarísk vika';

  @override
  String get isoExplanation =>
      'Vikan hefst á mánudegi. Fyrsta ISO-vika ársins inniheldur 4. janúar. ISO-vikuárið getur verið annað en almanaksárið.';

  @override
  String get openData => 'Opin gögn';

  @override
  String get dataExplorer => 'Skoða dagatalsgögn';

  @override
  String get bundledData => 'Meðfylgjandi gagnasafn';

  @override
  String get dataCopyNote => 'Afritaðu valið ár sem JSON.';

  @override
  String get websiteResources => 'Meira á vefsíðunni';

  @override
  String get websiteResourcesNote =>
      'Aðrar þjónustur vefsíðunnar opnast í vafra og krefjast nettengingar.';

  @override
  String get contact => 'Hafa samband';

  @override
  String get privacy => 'Persónuvernd';

  @override
  String get terms => 'Skilmálar';

  @override
  String get timeManagement => 'Tímastjórnun';

  @override
  String get sun => 'Sólin í Helsinki';

  @override
  String get sunrise => 'Sólarupprás';

  @override
  String get sunset => 'Sólsetur';

  @override
  String get daylight => 'Lengd dags';

  @override
  String get polarDay => 'Miðnætursól';

  @override
  String get polarNight => 'Skammdegi';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours klst $minutes mín';
  }

  @override
  String get weekNotes => 'Vikuminnispunktur';

  @override
  String get noteHint => 'Skrifaðu minnispunkt fyrir þessa viku…';

  @override
  String get saved => 'Vistað í þessu tæki';

  @override
  String get save => 'Vista';

  @override
  String get cancel => 'Hætta við';

  @override
  String get notFound => 'Síðan fannst ekki';

  @override
  String get outOfRange => 'Veldu ár á bilinu 2020 til 2035.';

  @override
  String get backHome => 'Aftur á forsíðu';

  @override
  String get loadingError => 'Ekki tókst að hlaða dagatalsgögnum.';

  @override
  String get retry => 'Reyna aftur';

  @override
  String get menu => 'Opna valmynd';

  @override
  String get dayDetails => 'Upplýsingar dagsins';

  @override
  String get close => 'Loka';

  @override
  String get holidayRule => 'Dagsetningarregla';

  @override
  String get fiContent => 'Frumefni vefsíðunnar er á finnsku.';

  @override
  String get nameDaysUnavailable =>
      'Nafnadögum verður bætt við þegar leyfi hefur verið staðfest.';

  @override
  String get weekList => 'Vikulisti';
}
