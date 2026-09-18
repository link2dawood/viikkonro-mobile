// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appName => 'Viikkonro';

  @override
  String get wordmark => 'Viikko nyt';

  @override
  String get home => 'Головна';

  @override
  String get weeks => 'Тижні';

  @override
  String get calendar => 'Календар';

  @override
  String get tools => 'Калькулятори';

  @override
  String get more => 'Ще';

  @override
  String get settings => 'Налаштування';

  @override
  String get eyebrow => 'ІНСТРУМЕНТ НОМЕРА ТИЖНЯ';

  @override
  String get homeTitle => 'Який зараз тиждень?';

  @override
  String get homeLead =>
      'Номери тижнів, дати та важливі дні календаря в одному місці.';

  @override
  String get rightNow => 'ПРЯМО ЗАРАЗ';

  @override
  String get week => 'Тиждень';

  @override
  String weekLabel(int number) {
    return 'Тиждень $number';
  }

  @override
  String weekShort(int number) {
    return 'Тиж. $number';
  }

  @override
  String yearLabel(int number) {
    return 'Рік $number';
  }

  @override
  String weekOf(int current, int total) {
    return 'Тиждень $current / $total';
  }

  @override
  String yearProgress(int percent) {
    return 'Минуло $percent % року';
  }

  @override
  String get weeksTotal => '52/53 тижні';

  @override
  String get previous => 'Попередній';

  @override
  String get next => 'Наступний';

  @override
  String get today => 'Сьогодні';

  @override
  String get thisWeek => 'Цей тиждень';

  @override
  String get thisMonth => 'Цей місяць';

  @override
  String get thisYear => 'Цей рік';

  @override
  String get lookupTitle => 'Дізнайтеся номер тижня будь-якої дати';

  @override
  String get chooseDate => 'Оберіть дату';

  @override
  String get dateToWeek => 'Дата в тиждень';

  @override
  String get weekToDate => 'Тиждень у дати';

  @override
  String get weekdayCalculator => 'День тижня';

  @override
  String get openWeek => 'Відкрити подробиці тижня';

  @override
  String get year => 'Рік';

  @override
  String get month => 'Місяць';

  @override
  String get weekNumber => 'Номер тижня';

  @override
  String get dayOfYear => 'День року';

  @override
  String get daysRemaining => 'Залишилося днів';

  @override
  String get quarter => 'Квартал';

  @override
  String quarterLabel(int number) {
    return 'Квартал $number';
  }

  @override
  String get weekRange => 'З понеділка по неділю';

  @override
  String dayCount(int count) {
    return '$count днів';
  }

  @override
  String weekDaysResult(int weeks, int days) {
    return '$weeks тижнів і $days днів';
  }

  @override
  String get holidays => 'Святкові дні';

  @override
  String get flagDays => 'Дні підняття прапора';

  @override
  String get schoolHolidays => 'Шкільні канікули';

  @override
  String get nextHoliday => 'Найближче свято';

  @override
  String get noEvents => 'Немає пам’ятних днів';

  @override
  String get official => 'Офіційне свято';

  @override
  String get observance => 'Пам’ятний день';

  @override
  String get all => 'Усі';

  @override
  String get confirmed => 'Підтверджено';

  @override
  String get estimated => 'орієнтовно';

  @override
  String get unknown => 'Ще не оприлюднено';

  @override
  String get noSchoolData =>
      'Для цього року немає оприлюднених даних про шкільні канікули.';

  @override
  String get schoolCoverage =>
      'Дати вашої школи можуть відрізнятися від календаря громади.';

  @override
  String get winterBreak => 'Зимові канікули';

  @override
  String get autumnBreak => 'Осінні канікули';

  @override
  String get city => 'Місто';

  @override
  String get source => 'Джерело';

  @override
  String verifiedAt(String date) {
    return 'Перевірено $date';
  }

  @override
  String get daysBetween => 'Днів між датами';

  @override
  String get workingDaysBetween => 'Калькулятор робочих днів';

  @override
  String get workingDays => 'Робочі дні';

  @override
  String get weekends => 'Вихідні';

  @override
  String get weekdayHolidays => 'Свята в будні';

  @override
  String get totalDays => 'Усього днів';

  @override
  String get firstDate => 'Початкова дата';

  @override
  String get lastDate => 'Кінцева дата';

  @override
  String get invalidRange =>
      'Кінцева дата має бути тією самою або пізнішою за початкову.';

  @override
  String get distanceNote =>
      'Результат — це відстань між датами. Порядок не має значення.';

  @override
  String get workingNote =>
      'Обидві дати враховуються. Робочі дні — з понеділка по п’ятницю, крім офіційних свят. Святвечір і переддень Івана Купала вважаються робочими.';

  @override
  String get yearWeeks => 'Усі тижні року';

  @override
  String get yearCalendar => 'Річний календар';

  @override
  String get firstHalf => 'Перше півріччя';

  @override
  String get secondHalf => 'Друге півріччя';

  @override
  String get wholeYear => 'Увесь рік';

  @override
  String get yearWorkingDays => 'Робочі дні за рік';

  @override
  String get monthWorkingDays => 'Робочі дні за місяць';

  @override
  String get share => 'Поділитися';

  @override
  String get openWebsite => 'Відкрити сайт';

  @override
  String get copy => 'Копіювати';

  @override
  String get copied => 'Скопійовано';

  @override
  String get printPdf => 'Друк / зберегти PDF';

  @override
  String get exportCsv => 'Експорт CSV';

  @override
  String get exportCalendar => 'Експорт календаря (.ics)';

  @override
  String get exportFailed => 'Не вдалося експортувати. Спробуйте ще раз.';

  @override
  String get openFailed => 'Не вдалося відкрити посилання.';

  @override
  String get language => 'Мова';

  @override
  String get finnish => 'Фінська';

  @override
  String get english => 'Англійська';

  @override
  String get theme => 'Оформлення';

  @override
  String get system => 'Системне';

  @override
  String get light => 'Світле';

  @override
  String get dark => 'Темне';

  @override
  String get firstScreen => 'Початковий екран';

  @override
  String get privacyNote =>
      'Працює без інтернету. Обліковий запис не потрібен. Застосунок використовує звіти про збої, аналітику та рекламу з налаштуваннями приватності.';

  @override
  String get dataCoverage =>
      'Дані календаря: 2020–2035. Шкільні канікули доступні лише для оприлюднених років.';

  @override
  String get about => 'Про застосунок';

  @override
  String get licenses => 'Ліцензії відкритого коду';

  @override
  String get info => 'Про номери тижнів';

  @override
  String get faq => 'Поширені запитання';

  @override
  String get methodology => 'Методика';

  @override
  String get sources => 'Джерела даних';

  @override
  String get editorial => 'Редакційні принципи';

  @override
  String get usComparison => 'Фінляндія і США';

  @override
  String get isoWeek => 'Тиждень ISO';

  @override
  String get usWeek => 'Американський тиждень';

  @override
  String get isoExplanation =>
      'Тиждень починається в понеділок. Перший тиждень ISO містить 4 січня. Рік за ISO може відрізнятися від календарного.';

  @override
  String get openData => 'Відкриті дані';

  @override
  String get dataExplorer => 'Переглянути дані календаря';

  @override
  String get bundledData => 'Вбудований набір даних';

  @override
  String get dataCopyNote => 'Скопіюйте вибраний рік у форматі JSON.';

  @override
  String get websiteResources => 'Більше на сайті';

  @override
  String get websiteResourcesNote =>
      'Інші послуги сайту відкриваються у браузері й потребують інтернету.';

  @override
  String get contact => 'Контакти';

  @override
  String get privacy => 'Конфіденційність';

  @override
  String get terms => 'Умови';

  @override
  String get timeManagement => 'Керування часом';

  @override
  String get sun => 'Сонце в Гельсінкі';

  @override
  String get sunrise => 'Схід сонця';

  @override
  String get sunset => 'Захід сонця';

  @override
  String get daylight => 'Тривалість дня';

  @override
  String get polarDay => 'Полярний день';

  @override
  String get polarNight => 'Полярна ніч';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours год $minutes хв';
  }

  @override
  String get weekNotes => 'Нотатка тижня';

  @override
  String get noteHint => 'Напишіть нотатку на цей тиждень…';

  @override
  String get saved => 'Збережено на цьому пристрої';

  @override
  String get save => 'Зберегти';

  @override
  String get cancel => 'Скасувати';

  @override
  String get notFound => 'Сторінку не знайдено';

  @override
  String get outOfRange => 'Оберіть рік від 2020 до 2035.';

  @override
  String get backHome => 'На головну';

  @override
  String get loadingError => 'Не вдалося завантажити дані календаря.';

  @override
  String get retry => 'Повторити';

  @override
  String get menu => 'Відкрити меню';

  @override
  String get dayDetails => 'Подробиці дня';

  @override
  String get close => 'Закрити';

  @override
  String get holidayRule => 'Правило дати';

  @override
  String get fiContent => 'Першоджерела сайту — фінською мовою.';

  @override
  String get nameDaysUnavailable =>
      'Іменини буде додано після підтвердження ліцензії.';

  @override
  String get weekList => 'Список тижнів';
}
