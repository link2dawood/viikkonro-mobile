// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class AppLocalizationsSl extends AppLocalizations {
  AppLocalizationsSl([String locale = 'sl']) : super(locale);

  @override
  String get appName => 'Viikkonro';

  @override
  String get wordmark => 'Viikko nyt';

  @override
  String get home => 'Domov';

  @override
  String get weeks => 'Tedni';

  @override
  String get calendar => 'Koledar';

  @override
  String get tools => 'Računala';

  @override
  String get more => 'Več';

  @override
  String get settings => 'Nastavitve';

  @override
  String get eyebrow => 'ORODJE ZA ŠTEVILKO TEDNA';

  @override
  String get homeTitle => 'Kateri teden je?';

  @override
  String get homeLead => 'Številke tednov, datumi in pomembni koledarski dnevi na enem mestu.';

  @override
  String get rightNow => 'PRAV ZDAJ';

  @override
  String get week => 'Teden';

  @override
  String weekLabel(int number) {
    return 'Teden $number';
  }

  @override
  String weekShort(int number) {
    return 'T $number';
  }

  @override
  String yearLabel(int number) {
    return 'Leto $number';
  }

  @override
  String weekOf(int current, int total) {
    return 'Teden $current / $total';
  }

  @override
  String yearProgress(int percent) {
    return 'Minilo je $percent % leta';
  }

  @override
  String get weeksTotal => '52/53 tednov';

  @override
  String get previous => 'Prejšnji';

  @override
  String get next => 'Naslednji';

  @override
  String get today => 'Danes';

  @override
  String get thisWeek => 'Ta teden';

  @override
  String get thisMonth => 'Ta mesec';

  @override
  String get thisYear => 'Letos';

  @override
  String get lookupTitle => 'Poiščite številko tedna za poljuben datum';

  @override
  String get chooseDate => 'Izberite datum';

  @override
  String get dateToWeek => 'Datum v teden';

  @override
  String get weekToDate => 'Teden v datume';

  @override
  String get weekdayCalculator => 'Dan v tednu';

  @override
  String get openWeek => 'Odpri podrobnosti tedna';

  @override
  String get year => 'Leto';

  @override
  String get month => 'Mesec';

  @override
  String get weekNumber => 'Številka tedna';

  @override
  String get dayOfYear => 'Dan v letu';

  @override
  String get daysRemaining => 'Preostali dnevi';

  @override
  String get quarter => 'Četrtletje';

  @override
  String quarterLabel(int number) {
    return 'Četrtletje $number';
  }

  @override
  String get weekRange => 'Od ponedeljka do nedelje';

  @override
  String dayCount(int count) {
    return '$count dni';
  }

  @override
  String weekDaysResult(int weeks, int days) {
    return '$weeks tednov in $days dni';
  }

  @override
  String get holidays => 'Prazniki';

  @override
  String get flagDays => 'Dnevi zastav';

  @override
  String get schoolHolidays => 'Šolske počitnice';

  @override
  String get nextHoliday => 'Naslednji praznik';

  @override
  String get noEvents => 'Ni spominskih dni';

  @override
  String get official => 'Uradni praznik';

  @override
  String get observance => 'Spominski dan';

  @override
  String get all => 'Vse';

  @override
  String get confirmed => 'Potrjeno';

  @override
  String get estimated => 'ocena';

  @override
  String get unknown => 'Še ni objavljeno';

  @override
  String get noSchoolData => 'Za to leto ni objavljenih podatkov o šolskih počitnicah.';

  @override
  String get schoolCoverage => 'Datumi vaše šole se lahko razlikujejo od občinskega koledarja.';

  @override
  String get winterBreak => 'Zimske počitnice';

  @override
  String get autumnBreak => 'Jesenske počitnice';

  @override
  String get city => 'Mesto';

  @override
  String get source => 'Vir';

  @override
  String verifiedAt(String date) {
    return 'Preverjeno $date';
  }

  @override
  String get daysBetween => 'Dnevi med datumoma';

  @override
  String get workingDaysBetween => 'Računalo delovnih dni';

  @override
  String get workingDays => 'Delovni dnevi';

  @override
  String get weekends => 'Vikendi';

  @override
  String get weekdayHolidays => 'Prazniki na delovne dni';

  @override
  String get totalDays => 'Skupaj dni';

  @override
  String get firstDate => 'Začetni datum';

  @override
  String get lastDate => 'Končni datum';

  @override
  String get invalidRange => 'Končni datum mora biti enak začetnemu ali poznejši.';

  @override
  String get distanceNote => 'Rezultat je razdalja med datumoma. Vrstni red ni pomemben.';

  @override
  String get workingNote => 'Oba datuma se štejeta. Delovni dnevi so od ponedeljka do petka brez uradnih praznikov. Božični večer in kres se štejeta kot delovna dneva.';

  @override
  String get yearWeeks => 'Vsi tedni v letu';

  @override
  String get yearCalendar => 'Letni koledar';

  @override
  String get firstHalf => 'Prvo polletje';

  @override
  String get secondHalf => 'Drugo polletje';

  @override
  String get wholeYear => 'Celo leto';

  @override
  String get yearWorkingDays => 'Delovni dnevi na leto';

  @override
  String get monthWorkingDays => 'Delovni dnevi na mesec';

  @override
  String get share => 'Deli';

  @override
  String get openWebsite => 'Odpri spletno mesto';

  @override
  String get copy => 'Kopiraj';

  @override
  String get copied => 'Kopirano';

  @override
  String get printPdf => 'Natisni / shrani PDF';

  @override
  String get exportCsv => 'Izvozi CSV';

  @override
  String get exportCalendar => 'Izvozi koledar (.ics)';

  @override
  String get exportFailed => 'Izvoz ni uspel. Poskusite znova.';

  @override
  String get openFailed => 'Povezave ni bilo mogoče odpreti.';

  @override
  String get language => 'Jezik';

  @override
  String get finnish => 'Finščina';

  @override
  String get english => 'Angleščina';

  @override
  String get theme => 'Videz';

  @override
  String get system => 'Sistem';

  @override
  String get light => 'Svetlo';

  @override
  String get dark => 'Temno';

  @override
  String get firstScreen => 'Začetni zaslon';

  @override
  String get privacyNote => 'Deluje brez povezave. Brez računa, brez analitike, brez oglasov.';

  @override
  String get dataCoverage => 'Koledarski podatki: 2020–2035. Šolske počitnice so na voljo le za objavljena leta.';

  @override
  String get about => 'O aplikaciji';

  @override
  String get licenses => 'Licence odprte kode';

  @override
  String get info => 'O številkah tednov';

  @override
  String get faq => 'Pogosta vprašanja';

  @override
  String get methodology => 'Metodologija';

  @override
  String get sources => 'Viri podatkov';

  @override
  String get editorial => 'Uredniška načela';

  @override
  String get usComparison => 'Finska in ZDA';

  @override
  String get isoWeek => 'Teden ISO';

  @override
  String get usWeek => 'Ameriški teden';

  @override
  String get isoExplanation => 'Teden se začne v ponedeljek. Prvi teden ISO v letu vsebuje 4. januar. Leto ISO se lahko razlikuje od koledarskega leta.';

  @override
  String get openData => 'Odprti podatki';

  @override
  String get dataExplorer => 'Razišči koledarske podatke';

  @override
  String get bundledData => 'Priložen nabor podatkov';

  @override
  String get dataCopyNote => 'Kopirajte izbrano leto v obliki JSON.';

  @override
  String get websiteResources => 'Več na spletnem mestu';

  @override
  String get websiteResourcesNote => 'Druge storitve spletnega mesta se odprejo v brskalniku in potrebujejo internetno povezavo.';

  @override
  String get contact => 'Stik';

  @override
  String get privacy => 'Zasebnost';

  @override
  String get terms => 'Pogoji';

  @override
  String get timeManagement => 'Upravljanje časa';

  @override
  String get sun => 'Sonce v Helsinkih';

  @override
  String get sunrise => 'Sončni vzhod';

  @override
  String get sunset => 'Sončni zahod';

  @override
  String get daylight => 'Dolžina dneva';

  @override
  String get polarDay => 'Polnočno sonce';

  @override
  String get polarNight => 'Polarna noč';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get weekNotes => 'Zapis tedna';

  @override
  String get noteHint => 'Napišite zapis za ta teden…';

  @override
  String get saved => 'Shranjeno v tej napravi';

  @override
  String get save => 'Shrani';

  @override
  String get cancel => 'Prekliči';

  @override
  String get notFound => 'Strani ni mogoče najti';

  @override
  String get outOfRange => 'Izberite leto med 2020 in 2035.';

  @override
  String get backHome => 'Nazaj na domov';

  @override
  String get loadingError => 'Koledarskih podatkov ni bilo mogoče naložiti.';

  @override
  String get retry => 'Poskusi znova';

  @override
  String get menu => 'Odpri meni';

  @override
  String get dayDetails => 'Podrobnosti dneva';

  @override
  String get close => 'Zapri';

  @override
  String get holidayRule => 'Pravilo datuma';

  @override
  String get fiContent => 'Izvorno gradivo spletnega mesta je v finščini.';

  @override
  String get nameDaysUnavailable => 'Godovi bodo dodani, ko bo licenca potrjena.';

  @override
  String get weekList => 'Seznam tednov';
}
