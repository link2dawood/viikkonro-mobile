// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appName => 'Viikkonro';

  @override
  String get wordmark => 'Viikko nyt';

  @override
  String get home => 'Start';

  @override
  String get weeks => 'Tygodnie';

  @override
  String get calendar => 'Kalendarz';

  @override
  String get tools => 'Kalkulatory';

  @override
  String get more => 'Więcej';

  @override
  String get settings => 'Ustawienia';

  @override
  String get eyebrow => 'NARZĘDZIE NUMERU TYGODNIA';

  @override
  String get homeTitle => 'Który mamy tydzień?';

  @override
  String get homeLead =>
      'Numery tygodni, daty i ważne dni kalendarzowe w jednym miejscu.';

  @override
  String get rightNow => 'WŁAŚNIE TERAZ';

  @override
  String get week => 'Tydzień';

  @override
  String weekLabel(int number) {
    return 'Tydzień $number';
  }

  @override
  String weekShort(int number) {
    return 'Tydz. $number';
  }

  @override
  String yearLabel(int number) {
    return 'Rok $number';
  }

  @override
  String weekOf(int current, int total) {
    return 'Tydzień $current / $total';
  }

  @override
  String yearProgress(int percent) {
    return 'Minęło $percent % roku';
  }

  @override
  String get weeksTotal => '52/53 tygodnie';

  @override
  String get previous => 'Poprzedni';

  @override
  String get next => 'Następny';

  @override
  String get today => 'Dzisiaj';

  @override
  String get thisWeek => 'Ten tydzień';

  @override
  String get thisMonth => 'Ten miesiąc';

  @override
  String get thisYear => 'Ten rok';

  @override
  String get lookupTitle => 'Sprawdź numer tygodnia dowolnej daty';

  @override
  String get chooseDate => 'Wybierz datę';

  @override
  String get dateToWeek => 'Data na tydzień';

  @override
  String get weekToDate => 'Tydzień na daty';

  @override
  String get weekdayCalculator => 'Dzień tygodnia';

  @override
  String get openWeek => 'Otwórz szczegóły tygodnia';

  @override
  String get year => 'Rok';

  @override
  String get month => 'Miesiąc';

  @override
  String get weekNumber => 'Numer tygodnia';

  @override
  String get dayOfYear => 'Dzień roku';

  @override
  String get daysRemaining => 'Pozostało dni';

  @override
  String get quarter => 'Kwartał';

  @override
  String quarterLabel(int number) {
    return 'Kwartał $number';
  }

  @override
  String get weekRange => 'Od poniedziałku do niedzieli';

  @override
  String dayCount(int count) {
    return '$count dni';
  }

  @override
  String weekDaysResult(int weeks, int days) {
    return '$weeks tyg. i $days dni';
  }

  @override
  String get holidays => 'Dni świąteczne';

  @override
  String get flagDays => 'Dni flagowe';

  @override
  String get schoolHolidays => 'Ferie szkolne';

  @override
  String get nextHoliday => 'Następne święto';

  @override
  String get noEvents => 'Brak dni pamiętnych';

  @override
  String get official => 'Święto ustawowe';

  @override
  String get observance => 'Dzień pamiętny';

  @override
  String get all => 'Wszystko';

  @override
  String get confirmed => 'Potwierdzone';

  @override
  String get estimated => 'szacunkowe';

  @override
  String get unknown => 'Jeszcze nieopublikowane';

  @override
  String get noSchoolData =>
      'Brak opublikowanych danych o feriach szkolnych na ten rok.';

  @override
  String get schoolCoverage =>
      'Terminy twojej szkoły mogą różnić się od kalendarza gminnego.';

  @override
  String get winterBreak => 'Ferie zimowe';

  @override
  String get autumnBreak => 'Ferie jesienne';

  @override
  String get city => 'Miasto';

  @override
  String get source => 'Źródło';

  @override
  String verifiedAt(String date) {
    return 'Zweryfikowano $date';
  }

  @override
  String get daysBetween => 'Dni między datami';

  @override
  String get workingDaysBetween => 'Kalkulator dni roboczych';

  @override
  String get workingDays => 'Dni robocze';

  @override
  String get weekends => 'Weekendy';

  @override
  String get weekdayHolidays => 'Święta w dni powszednie';

  @override
  String get totalDays => 'Dni łącznie';

  @override
  String get firstDate => 'Data początkowa';

  @override
  String get lastDate => 'Data końcowa';

  @override
  String get invalidRange =>
      'Data końcowa musi być taka sama jak początkowa lub późniejsza.';

  @override
  String get distanceNote =>
      'Wynik to odległość między datami. Kolejność nie ma znaczenia.';

  @override
  String get workingNote =>
      'Obie daty są wliczane. Dni robocze to poniedziałek–piątek bez świąt ustawowych. Wigilia i wigilia nocy świętojańskiej liczą się jako dni robocze.';

  @override
  String get yearWeeks => 'Wszystkie tygodnie roku';

  @override
  String get yearCalendar => 'Kalendarz roczny';

  @override
  String get firstHalf => 'Pierwsze półrocze';

  @override
  String get secondHalf => 'Drugie półrocze';

  @override
  String get wholeYear => 'Cały rok';

  @override
  String get yearWorkingDays => 'Dni robocze w roku';

  @override
  String get monthWorkingDays => 'Dni robocze w miesiącu';

  @override
  String get share => 'Udostępnij';

  @override
  String get openWebsite => 'Otwórz stronę';

  @override
  String get copy => 'Kopiuj';

  @override
  String get copied => 'Skopiowano';

  @override
  String get printPdf => 'Drukuj / zapisz PDF';

  @override
  String get exportCsv => 'Eksportuj CSV';

  @override
  String get exportCalendar => 'Eksportuj kalendarz (.ics)';

  @override
  String get exportFailed => 'Eksport nie powiódł się. Spróbuj ponownie.';

  @override
  String get openFailed => 'Nie udało się otworzyć linku.';

  @override
  String get language => 'Język';

  @override
  String get finnish => 'Fiński';

  @override
  String get english => 'Angielski';

  @override
  String get theme => 'Wygląd';

  @override
  String get system => 'Systemowy';

  @override
  String get light => 'Jasny';

  @override
  String get dark => 'Ciemny';

  @override
  String get firstScreen => 'Ekran startowy';

  @override
  String get privacyNote =>
      'Działa offline. Konto nie jest wymagane. Aplikacja używa raportów o awariach, analityki i reklam z kontrolą prywatności.';

  @override
  String get dataCoverage =>
      'Dane kalendarzowe: 2020–2035. Ferie szkolne dostępne tylko dla opublikowanych lat.';

  @override
  String get about => 'O aplikacji';

  @override
  String get licenses => 'Licencje open source';

  @override
  String get info => 'O numerach tygodni';

  @override
  String get faq => 'Najczęstsze pytania';

  @override
  String get methodology => 'Metodologia';

  @override
  String get sources => 'Źródła danych';

  @override
  String get editorial => 'Zasady redakcyjne';

  @override
  String get usComparison => 'Finlandia i USA';

  @override
  String get isoWeek => 'Tydzień ISO';

  @override
  String get usWeek => 'Tydzień amerykański';

  @override
  String get isoExplanation =>
      'Tydzień zaczyna się w poniedziałek. Pierwszy tydzień ISO w roku zawiera 4 stycznia. Rok tygodniowy ISO może różnić się od roku kalendarzowego.';

  @override
  String get openData => 'Otwarte dane';

  @override
  String get dataExplorer => 'Przeglądaj dane kalendarzowe';

  @override
  String get bundledData => 'Dołączony zestaw danych';

  @override
  String get dataCopyNote => 'Skopiuj wybrany rok w formacie JSON.';

  @override
  String get websiteResources => 'Więcej na stronie';

  @override
  String get websiteResourcesNote =>
      'Pozostałe usługi strony otwierają się w przeglądarce i wymagają połączenia z internetem.';

  @override
  String get contact => 'Kontakt';

  @override
  String get privacy => 'Prywatność';

  @override
  String get terms => 'Regulamin';

  @override
  String get timeManagement => 'Zarządzanie czasem';

  @override
  String get sun => 'Słońce w Helsinkach';

  @override
  String get sunrise => 'Wschód słońca';

  @override
  String get sunset => 'Zachód słońca';

  @override
  String get daylight => 'Długość dnia';

  @override
  String get polarDay => 'Dzień polarny';

  @override
  String get polarNight => 'Noc polarna';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours godz. $minutes min';
  }

  @override
  String get weekNotes => 'Notatka tygodnia';

  @override
  String get noteHint => 'Zapisz notatkę na ten tydzień…';

  @override
  String get saved => 'Zapisano na tym urządzeniu';

  @override
  String get save => 'Zapisz';

  @override
  String get cancel => 'Anuluj';

  @override
  String get notFound => 'Nie znaleziono strony';

  @override
  String get outOfRange => 'Wybierz rok z zakresu 2020–2035.';

  @override
  String get backHome => 'Wróć na stronę główną';

  @override
  String get loadingError => 'Nie udało się wczytać danych kalendarzowych.';

  @override
  String get retry => 'Spróbuj ponownie';

  @override
  String get menu => 'Otwórz menu';

  @override
  String get dayDetails => 'Szczegóły dnia';

  @override
  String get close => 'Zamknij';

  @override
  String get holidayRule => 'Reguła daty';

  @override
  String get fiContent => 'Materiał źródłowy strony jest po fińsku.';

  @override
  String get nameDaysUnavailable =>
      'Imieniny zostaną dodane po potwierdzeniu licencji.';

  @override
  String get weekList => 'Lista tygodni';
}
