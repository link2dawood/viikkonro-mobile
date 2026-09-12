// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get appName => 'Viikkonro';

  @override
  String get wordmark => 'Viikko nyt';

  @override
  String get home => 'Domů';

  @override
  String get weeks => 'Týdny';

  @override
  String get calendar => 'Kalendář';

  @override
  String get tools => 'Kalkulačky';

  @override
  String get more => 'Více';

  @override
  String get settings => 'Nastavení';

  @override
  String get eyebrow => 'NÁSTROJ ČÍSLA TÝDNE';

  @override
  String get homeTitle => 'Který je týden?';

  @override
  String get homeLead => 'Čísla týdnů, data a významné dny kalendáře na jednom místě.';

  @override
  String get rightNow => 'PRÁVĚ TEĎ';

  @override
  String get week => 'Týden';

  @override
  String weekLabel(int number) {
    return 'Týden $number';
  }

  @override
  String weekShort(int number) {
    return 'Týd. $number';
  }

  @override
  String yearLabel(int number) {
    return 'Rok $number';
  }

  @override
  String weekOf(int current, int total) {
    return 'Týden $current / $total';
  }

  @override
  String yearProgress(int percent) {
    return 'Uplynulo $percent % roku';
  }

  @override
  String get weeksTotal => '52/53 týdnů';

  @override
  String get previous => 'Předchozí';

  @override
  String get next => 'Další';

  @override
  String get today => 'Dnes';

  @override
  String get thisWeek => 'Tento týden';

  @override
  String get thisMonth => 'Tento měsíc';

  @override
  String get thisYear => 'Letos';

  @override
  String get lookupTitle => 'Zjistěte číslo týdne libovolného data';

  @override
  String get chooseDate => 'Vyberte datum';

  @override
  String get dateToWeek => 'Datum na týden';

  @override
  String get weekToDate => 'Týden na data';

  @override
  String get weekdayCalculator => 'Den v týdnu';

  @override
  String get openWeek => 'Otevřít podrobnosti týdne';

  @override
  String get year => 'Rok';

  @override
  String get month => 'Měsíc';

  @override
  String get weekNumber => 'Číslo týdne';

  @override
  String get dayOfYear => 'Den v roce';

  @override
  String get daysRemaining => 'Zbývá dní';

  @override
  String get quarter => 'Čtvrtletí';

  @override
  String quarterLabel(int number) {
    return 'Čtvrtletí $number';
  }

  @override
  String get weekRange => 'Od pondělí do neděle';

  @override
  String dayCount(int count) {
    return '$count dní';
  }

  @override
  String weekDaysResult(int weeks, int days) {
    return '$weeks týdnů a $days dní';
  }

  @override
  String get holidays => 'Svátky';

  @override
  String get flagDays => 'Vlajkové dny';

  @override
  String get schoolHolidays => 'Školní prázdniny';

  @override
  String get nextHoliday => 'Nejbližší svátek';

  @override
  String get noEvents => 'Žádné významné dny';

  @override
  String get official => 'Státní svátek';

  @override
  String get observance => 'Významný den';

  @override
  String get all => 'Vše';

  @override
  String get confirmed => 'Potvrzeno';

  @override
  String get estimated => 'odhad';

  @override
  String get unknown => 'Zatím nezveřejněno';

  @override
  String get noSchoolData => 'Pro tento rok nejsou zveřejněna žádná data o školních prázdninách.';

  @override
  String get schoolCoverage => 'Termíny vaší školy se mohou lišit od obecního kalendáře.';

  @override
  String get winterBreak => 'Jarní prázdniny';

  @override
  String get autumnBreak => 'Podzimní prázdniny';

  @override
  String get city => 'Město';

  @override
  String get source => 'Zdroj';

  @override
  String verifiedAt(String date) {
    return 'Ověřeno $date';
  }

  @override
  String get daysBetween => 'Dny mezi daty';

  @override
  String get workingDaysBetween => 'Kalkulačka pracovních dní';

  @override
  String get workingDays => 'Pracovní dny';

  @override
  String get weekends => 'Víkendy';

  @override
  String get weekdayHolidays => 'Svátky ve všední dny';

  @override
  String get totalDays => 'Dní celkem';

  @override
  String get firstDate => 'Počáteční datum';

  @override
  String get lastDate => 'Koncové datum';

  @override
  String get invalidRange => 'Koncové datum musí být stejné nebo pozdější než počáteční.';

  @override
  String get distanceNote => 'Výsledkem je vzdálenost mezi daty. Na pořadí nezáleží.';

  @override
  String get workingNote => 'Obě data se počítají. Pracovní dny jsou pondělí až pátek bez státních svátků. Štědrý den a předvečer svatojánské noci se počítají jako pracovní.';

  @override
  String get yearWeeks => 'Všechny týdny roku';

  @override
  String get yearCalendar => 'Roční kalendář';

  @override
  String get firstHalf => 'První pololetí';

  @override
  String get secondHalf => 'Druhé pololetí';

  @override
  String get wholeYear => 'Celý rok';

  @override
  String get yearWorkingDays => 'Pracovní dny za rok';

  @override
  String get monthWorkingDays => 'Pracovní dny za měsíc';

  @override
  String get share => 'Sdílet';

  @override
  String get openWebsite => 'Otevřít web';

  @override
  String get copy => 'Kopírovat';

  @override
  String get copied => 'Zkopírováno';

  @override
  String get printPdf => 'Tisk / uložit PDF';

  @override
  String get exportCsv => 'Exportovat CSV';

  @override
  String get exportCalendar => 'Exportovat kalendář (.ics)';

  @override
  String get exportFailed => 'Export se nezdařil. Zkuste to znovu.';

  @override
  String get openFailed => 'Odkaz se nepodařilo otevřít.';

  @override
  String get language => 'Jazyk';

  @override
  String get finnish => 'Finština';

  @override
  String get english => 'Angličtina';

  @override
  String get theme => 'Vzhled';

  @override
  String get system => 'Systém';

  @override
  String get light => 'Světlý';

  @override
  String get dark => 'Tmavý';

  @override
  String get firstScreen => 'Úvodní obrazovka';

  @override
  String get privacyNote => 'Funguje offline. Žádný účet, žádná analytika, žádné reklamy.';

  @override
  String get dataCoverage => 'Kalendářní data: 2020–2035. Školní prázdniny jsou k dispozici jen pro zveřejněné roky.';

  @override
  String get about => 'O aplikaci';

  @override
  String get licenses => 'Licence open source';

  @override
  String get info => 'O číslech týdnů';

  @override
  String get faq => 'Časté dotazy';

  @override
  String get methodology => 'Metodika';

  @override
  String get sources => 'Zdroje dat';

  @override
  String get editorial => 'Redakční zásady';

  @override
  String get usComparison => 'Finsko a USA';

  @override
  String get isoWeek => 'Týden ISO';

  @override
  String get usWeek => 'Americký týden';

  @override
  String get isoExplanation => 'Týden začíná v pondělí. První týden ISO v roce obsahuje 4. leden. Rok podle ISO se může lišit od kalendářního roku.';

  @override
  String get openData => 'Otevřená data';

  @override
  String get dataExplorer => 'Prozkoumat kalendářní data';

  @override
  String get bundledData => 'Přiložená datová sada';

  @override
  String get dataCopyNote => 'Zkopírujte vybraný rok ve formátu JSON.';

  @override
  String get websiteResources => 'Více na webu';

  @override
  String get websiteResourcesNote => 'Ostatní služby webu se otevírají v prohlížeči a vyžadují připojení k internetu.';

  @override
  String get contact => 'Kontakt';

  @override
  String get privacy => 'Soukromí';

  @override
  String get terms => 'Podmínky';

  @override
  String get timeManagement => 'Řízení času';

  @override
  String get sun => 'Slunce v Helsinkách';

  @override
  String get sunrise => 'Východ slunce';

  @override
  String get sunset => 'Západ slunce';

  @override
  String get daylight => 'Délka dne';

  @override
  String get polarDay => 'Půlnoční slunce';

  @override
  String get polarNight => 'Polární noc';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get weekNotes => 'Poznámka k týdnu';

  @override
  String get noteHint => 'Napište poznámku k tomuto týdnu…';

  @override
  String get saved => 'Uloženo v tomto zařízení';

  @override
  String get save => 'Uložit';

  @override
  String get cancel => 'Zrušit';

  @override
  String get notFound => 'Stránka nenalezena';

  @override
  String get outOfRange => 'Zvolte rok mezi 2020 a 2035.';

  @override
  String get backHome => 'Zpět na úvod';

  @override
  String get loadingError => 'Kalendářní data se nepodařilo načíst.';

  @override
  String get retry => 'Zkusit znovu';

  @override
  String get menu => 'Otevřít nabídku';

  @override
  String get dayDetails => 'Podrobnosti dne';

  @override
  String get close => 'Zavřít';

  @override
  String get holidayRule => 'Pravidlo data';

  @override
  String get fiContent => 'Zdrojový materiál webu je ve finštině.';

  @override
  String get nameDaysUnavailable => 'Jmeniny budou doplněny po ověření licence.';

  @override
  String get weekList => 'Seznam týdnů';
}
