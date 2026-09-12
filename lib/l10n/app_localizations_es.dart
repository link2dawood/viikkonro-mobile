// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Viikkonro';

  @override
  String get wordmark => 'Viikko nyt';

  @override
  String get home => 'Inicio';

  @override
  String get weeks => 'Semanas';

  @override
  String get calendar => 'Calendario';

  @override
  String get tools => 'Calculadoras';

  @override
  String get more => 'Más';

  @override
  String get settings => 'Ajustes';

  @override
  String get eyebrow => 'HERRAMIENTA DE NÚMERO DE SEMANA';

  @override
  String get homeTitle => '¿En qué semana estamos?';

  @override
  String get homeLead => 'Números de semana, fechas y días señalados del calendario en un solo lugar.';

  @override
  String get rightNow => 'AHORA MISMO';

  @override
  String get week => 'Semana';

  @override
  String weekLabel(int number) {
    return 'Semana $number';
  }

  @override
  String weekShort(int number) {
    return 'Sem. $number';
  }

  @override
  String yearLabel(int number) {
    return 'Año $number';
  }

  @override
  String weekOf(int current, int total) {
    return 'Semana $current / $total';
  }

  @override
  String yearProgress(int percent) {
    return '$percent % del año transcurrido';
  }

  @override
  String get weeksTotal => '52/53 semanas';

  @override
  String get previous => 'Anterior';

  @override
  String get next => 'Siguiente';

  @override
  String get today => 'Hoy';

  @override
  String get thisWeek => 'Esta semana';

  @override
  String get thisMonth => 'Este mes';

  @override
  String get thisYear => 'Este año';

  @override
  String get lookupTitle => 'Consulta el número de semana de cualquier fecha';

  @override
  String get chooseDate => 'Elegir fecha';

  @override
  String get dateToWeek => 'Fecha a semana';

  @override
  String get weekToDate => 'Semana a fechas';

  @override
  String get weekdayCalculator => 'Día de la semana';

  @override
  String get openWeek => 'Abrir detalles de la semana';

  @override
  String get year => 'Año';

  @override
  String get month => 'Mes';

  @override
  String get weekNumber => 'Número de semana';

  @override
  String get dayOfYear => 'Día del año';

  @override
  String get daysRemaining => 'Días restantes';

  @override
  String get quarter => 'Trimestre';

  @override
  String quarterLabel(int number) {
    return 'Trimestre $number';
  }

  @override
  String get weekRange => 'De lunes a domingo';

  @override
  String dayCount(int count) {
    return '$count días';
  }

  @override
  String weekDaysResult(int weeks, int days) {
    return '$weeks semanas y $days días';
  }

  @override
  String get holidays => 'Días festivos';

  @override
  String get flagDays => 'Días de bandera';

  @override
  String get schoolHolidays => 'Vacaciones escolares';

  @override
  String get nextHoliday => 'Próximo día festivo';

  @override
  String get noEvents => 'Sin efemérides';

  @override
  String get official => 'Festivo oficial';

  @override
  String get observance => 'Efeméride';

  @override
  String get all => 'Todos';

  @override
  String get confirmed => 'Confirmado';

  @override
  String get estimated => 'estimado';

  @override
  String get unknown => 'Aún no publicado';

  @override
  String get noSchoolData => 'No hay datos publicados de vacaciones escolares para este año.';

  @override
  String get schoolCoverage => 'Las fechas de tu centro pueden diferir del calendario municipal.';

  @override
  String get winterBreak => 'Vacaciones de invierno';

  @override
  String get autumnBreak => 'Vacaciones de otoño';

  @override
  String get city => 'Ciudad';

  @override
  String get source => 'Fuente';

  @override
  String verifiedAt(String date) {
    return 'Verificado el $date';
  }

  @override
  String get daysBetween => 'Días entre fechas';

  @override
  String get workingDaysBetween => 'Calculadora de días laborables';

  @override
  String get workingDays => 'Días laborables';

  @override
  String get weekends => 'Fines de semana';

  @override
  String get weekdayHolidays => 'Festivos entre semana';

  @override
  String get totalDays => 'Días en total';

  @override
  String get firstDate => 'Fecha inicial';

  @override
  String get lastDate => 'Fecha final';

  @override
  String get invalidRange => 'La fecha final debe ser igual o posterior a la inicial.';

  @override
  String get distanceNote => 'El resultado es la distancia entre las fechas. El orden no importa.';

  @override
  String get workingNote => 'Se cuentan ambas fechas. Los días laborables son de lunes a viernes, excluidos los festivos oficiales. Nochebuena y la víspera de San Juan cuentan como laborables.';

  @override
  String get yearWeeks => 'Todas las semanas del año';

  @override
  String get yearCalendar => 'Calendario anual';

  @override
  String get firstHalf => 'Primer semestre';

  @override
  String get secondHalf => 'Segundo semestre';

  @override
  String get wholeYear => 'Año completo';

  @override
  String get yearWorkingDays => 'Días laborables por año';

  @override
  String get monthWorkingDays => 'Días laborables por mes';

  @override
  String get share => 'Compartir';

  @override
  String get openWebsite => 'Abrir el sitio web';

  @override
  String get copy => 'Copiar';

  @override
  String get copied => 'Copiado';

  @override
  String get printPdf => 'Imprimir / guardar PDF';

  @override
  String get exportCsv => 'Exportar CSV';

  @override
  String get exportCalendar => 'Exportar calendario (.ics)';

  @override
  String get exportFailed => 'La exportación ha fallado. Inténtalo de nuevo.';

  @override
  String get openFailed => 'No se ha podido abrir el enlace.';

  @override
  String get language => 'Idioma';

  @override
  String get finnish => 'Finés';

  @override
  String get english => 'Inglés';

  @override
  String get theme => 'Apariencia';

  @override
  String get system => 'Sistema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get firstScreen => 'Pantalla inicial';

  @override
  String get privacyNote => 'Funciona sin conexión. Sin cuenta, sin analítica, sin anuncios.';

  @override
  String get dataCoverage => 'Datos del calendario: 2020–2035. Las vacaciones escolares solo están disponibles para los años publicados.';

  @override
  String get about => 'Acerca de la aplicación';

  @override
  String get licenses => 'Licencias de código abierto';

  @override
  String get info => 'Sobre los números de semana';

  @override
  String get faq => 'Preguntas frecuentes';

  @override
  String get methodology => 'Metodología';

  @override
  String get sources => 'Fuentes de datos';

  @override
  String get editorial => 'Principios editoriales';

  @override
  String get usComparison => 'Finlandia y EE. UU.';

  @override
  String get isoWeek => 'Semana ISO';

  @override
  String get usWeek => 'Semana estadounidense';

  @override
  String get isoExplanation => 'La semana empieza el lunes. La primera semana ISO del año contiene el 4 de enero. El año ISO puede diferir del año natural.';

  @override
  String get openData => 'Datos abiertos';

  @override
  String get dataExplorer => 'Explorar los datos del calendario';

  @override
  String get bundledData => 'Conjunto de datos incluido';

  @override
  String get dataCopyNote => 'Copia el año seleccionado en formato JSON.';

  @override
  String get websiteResources => 'Más en el sitio web';

  @override
  String get websiteResourcesNote => 'Los demás servicios del sitio se abren en el navegador y necesitan conexión a internet.';

  @override
  String get contact => 'Contacto';

  @override
  String get privacy => 'Privacidad';

  @override
  String get terms => 'Condiciones';

  @override
  String get timeManagement => 'Gestión del tiempo';

  @override
  String get sun => 'El sol en Helsinki';

  @override
  String get sunrise => 'Amanecer';

  @override
  String get sunset => 'Atardecer';

  @override
  String get daylight => 'Duración del día';

  @override
  String get polarDay => 'Sol de medianoche';

  @override
  String get polarNight => 'Noche polar';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get weekNotes => 'Nota de la semana';

  @override
  String get noteHint => 'Escribe una nota para esta semana…';

  @override
  String get saved => 'Guardado en este dispositivo';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get notFound => 'Página no encontrada';

  @override
  String get outOfRange => 'Elige un año entre 2020 y 2035.';

  @override
  String get backHome => 'Volver al inicio';

  @override
  String get loadingError => 'No se han podido cargar los datos del calendario.';

  @override
  String get retry => 'Reintentar';

  @override
  String get menu => 'Abrir el menú';

  @override
  String get dayDetails => 'Detalles del día';

  @override
  String get close => 'Cerrar';

  @override
  String get holidayRule => 'Regla de la fecha';

  @override
  String get fiContent => 'El material original del sitio está en finés.';

  @override
  String get nameDaysUnavailable => 'Los onomásticos se añadirán cuando se verifique la licencia.';

  @override
  String get weekList => 'Lista de semanas';
}
