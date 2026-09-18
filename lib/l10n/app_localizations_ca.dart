// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get appName => 'Viikkonro';

  @override
  String get wordmark => 'Viikko nyt';

  @override
  String get home => 'Inici';

  @override
  String get weeks => 'Setmanes';

  @override
  String get calendar => 'Calendari';

  @override
  String get tools => 'Calculadores';

  @override
  String get more => 'Més';

  @override
  String get settings => 'Configuració';

  @override
  String get eyebrow => 'EINA DE NÚMERO DE SETMANA';

  @override
  String get homeTitle => 'En quina setmana som?';

  @override
  String get homeLead =>
      'Números de setmana, dates i dies assenyalats del calendari en un sol lloc.';

  @override
  String get rightNow => 'ARA MATEIX';

  @override
  String get week => 'Setmana';

  @override
  String weekLabel(int number) {
    return 'Setmana $number';
  }

  @override
  String weekShort(int number) {
    return 'Set. $number';
  }

  @override
  String yearLabel(int number) {
    return 'Any $number';
  }

  @override
  String weekOf(int current, int total) {
    return 'Setmana $current / $total';
  }

  @override
  String yearProgress(int percent) {
    return '$percent % de l’any transcorregut';
  }

  @override
  String get weeksTotal => '52/53 setmanes';

  @override
  String get previous => 'Anterior';

  @override
  String get next => 'Següent';

  @override
  String get today => 'Avui';

  @override
  String get thisWeek => 'Aquesta setmana';

  @override
  String get thisMonth => 'Aquest mes';

  @override
  String get thisYear => 'Enguany';

  @override
  String get lookupTitle => 'Consulta el número de setmana de qualsevol data';

  @override
  String get chooseDate => 'Tria una data';

  @override
  String get dateToWeek => 'Data a setmana';

  @override
  String get weekToDate => 'Setmana a dates';

  @override
  String get weekdayCalculator => 'Dia de la setmana';

  @override
  String get openWeek => 'Obre els detalls de la setmana';

  @override
  String get year => 'Any';

  @override
  String get month => 'Mes';

  @override
  String get weekNumber => 'Número de setmana';

  @override
  String get dayOfYear => 'Dia de l’any';

  @override
  String get daysRemaining => 'Dies restants';

  @override
  String get quarter => 'Trimestre';

  @override
  String quarterLabel(int number) {
    return 'Trimestre $number';
  }

  @override
  String get weekRange => 'De dilluns a diumenge';

  @override
  String dayCount(int count) {
    return '$count dies';
  }

  @override
  String weekDaysResult(int weeks, int days) {
    return '$weeks setmanes i $days dies';
  }

  @override
  String get holidays => 'Dies festius';

  @override
  String get flagDays => 'Dies de bandera';

  @override
  String get schoolHolidays => 'Vacances escolars';

  @override
  String get nextHoliday => 'Proper dia festiu';

  @override
  String get noEvents => 'Cap efemèride';

  @override
  String get official => 'Festiu oficial';

  @override
  String get observance => 'Efemèride';

  @override
  String get all => 'Tots';

  @override
  String get confirmed => 'Confirmat';

  @override
  String get estimated => 'estimat';

  @override
  String get unknown => 'Encara no publicat';

  @override
  String get noSchoolData =>
      'No hi ha dades publicades de vacances escolars per a aquest any.';

  @override
  String get schoolCoverage =>
      'Les dates del teu centre poden diferir del calendari municipal.';

  @override
  String get winterBreak => 'Vacances d’hivern';

  @override
  String get autumnBreak => 'Vacances de tardor';

  @override
  String get city => 'Ciutat';

  @override
  String get source => 'Font';

  @override
  String verifiedAt(String date) {
    return 'Verificat el $date';
  }

  @override
  String get daysBetween => 'Dies entre dates';

  @override
  String get workingDaysBetween => 'Calculadora de dies feiners';

  @override
  String get workingDays => 'Dies feiners';

  @override
  String get weekends => 'Caps de setmana';

  @override
  String get weekdayHolidays => 'Festius entre setmana';

  @override
  String get totalDays => 'Dies en total';

  @override
  String get firstDate => 'Data d’inici';

  @override
  String get lastDate => 'Data final';

  @override
  String get invalidRange =>
      'La data final ha de ser igual o posterior a la d’inici.';

  @override
  String get distanceNote =>
      'El resultat és la distància entre les dates. L’ordre no importa.';

  @override
  String get workingNote =>
      'Es compten totes dues dates. Els dies feiners van de dilluns a divendres, sense els festius oficials. La nit de Nadal i la revetlla de Sant Joan compten com a feiners.';

  @override
  String get yearWeeks => 'Totes les setmanes de l’any';

  @override
  String get yearCalendar => 'Calendari anual';

  @override
  String get firstHalf => 'Primer semestre';

  @override
  String get secondHalf => 'Segon semestre';

  @override
  String get wholeYear => 'Tot l’any';

  @override
  String get yearWorkingDays => 'Dies feiners per any';

  @override
  String get monthWorkingDays => 'Dies feiners per mes';

  @override
  String get share => 'Comparteix';

  @override
  String get openWebsite => 'Obre el lloc web';

  @override
  String get copy => 'Copia';

  @override
  String get copied => 'Copiat';

  @override
  String get printPdf => 'Imprimeix / desa en PDF';

  @override
  String get exportCsv => 'Exporta CSV';

  @override
  String get exportCalendar => 'Exporta el calendari (.ics)';

  @override
  String get exportFailed => 'L’exportació ha fallat. Torna-ho a provar.';

  @override
  String get openFailed => 'No s’ha pogut obrir l’enllaç.';

  @override
  String get language => 'Idioma';

  @override
  String get finnish => 'Finès';

  @override
  String get english => 'Anglès';

  @override
  String get theme => 'Aparença';

  @override
  String get system => 'Sistema';

  @override
  String get light => 'Clar';

  @override
  String get dark => 'Fosc';

  @override
  String get firstScreen => 'Pantalla d’inici';

  @override
  String get privacyNote =>
      'Funciona sense connexió. No cal cap compte. Inclou informes d’errors, analítica i anuncis amb controls de privadesa.';

  @override
  String get dataCoverage =>
      'Dades del calendari: 2020–2035. Les vacances escolars només estan disponibles per als anys publicats.';

  @override
  String get about => 'Quant a l’aplicació';

  @override
  String get licenses => 'Llicències de codi obert';

  @override
  String get info => 'Sobre els números de setmana';

  @override
  String get faq => 'Preguntes freqüents';

  @override
  String get methodology => 'Metodologia';

  @override
  String get sources => 'Fonts de dades';

  @override
  String get editorial => 'Principis editorials';

  @override
  String get usComparison => 'Finlàndia i els EUA';

  @override
  String get isoWeek => 'Setmana ISO';

  @override
  String get usWeek => 'Setmana nord-americana';

  @override
  String get isoExplanation =>
      'La setmana comença dilluns. La primera setmana ISO de l’any conté el 4 de gener. L’any ISO pot diferir de l’any natural.';

  @override
  String get openData => 'Dades obertes';

  @override
  String get dataExplorer => 'Explora les dades del calendari';

  @override
  String get bundledData => 'Conjunt de dades inclòs';

  @override
  String get dataCopyNote => 'Copia l’any seleccionat en format JSON.';

  @override
  String get websiteResources => 'Més al lloc web';

  @override
  String get websiteResourcesNote =>
      'La resta de serveis del lloc s’obren al navegador i necessiten connexió a internet.';

  @override
  String get contact => 'Contacte';

  @override
  String get privacy => 'Privadesa';

  @override
  String get terms => 'Condicions';

  @override
  String get timeManagement => 'Gestió del temps';

  @override
  String get sun => 'El sol a Hèlsinki';

  @override
  String get sunrise => 'Sortida del sol';

  @override
  String get sunset => 'Posta del sol';

  @override
  String get daylight => 'Durada del dia';

  @override
  String get polarDay => 'Sol de mitjanit';

  @override
  String get polarNight => 'Nit polar';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get weekNotes => 'Nota de la setmana';

  @override
  String get noteHint => 'Escriu una nota per a aquesta setmana…';

  @override
  String get saved => 'Desat en aquest dispositiu';

  @override
  String get save => 'Desa';

  @override
  String get cancel => 'Cancel·la';

  @override
  String get notFound => 'No s’ha trobat la pàgina';

  @override
  String get outOfRange => 'Tria un any entre el 2020 i el 2035.';

  @override
  String get backHome => 'Torna a l’inici';

  @override
  String get loadingError => 'No s’han pogut carregar les dades del calendari.';

  @override
  String get retry => 'Torna-ho a provar';

  @override
  String get menu => 'Obre el menú';

  @override
  String get dayDetails => 'Detalls del dia';

  @override
  String get close => 'Tanca';

  @override
  String get holidayRule => 'Regla de la data';

  @override
  String get fiContent => 'El material original del lloc és en finès.';

  @override
  String get nameDaysUnavailable =>
      'Les onomàstiques s’afegiran quan es verifiqui la llicència.';

  @override
  String get weekList => 'Llista de setmanes';
}
