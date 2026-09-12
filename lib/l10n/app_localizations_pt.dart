// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'Viikkonro';

  @override
  String get wordmark => 'Viikko nyt';

  @override
  String get home => 'Início';

  @override
  String get weeks => 'Semanas';

  @override
  String get calendar => 'Calendário';

  @override
  String get tools => 'Calculadoras';

  @override
  String get more => 'Mais';

  @override
  String get settings => 'Definições';

  @override
  String get eyebrow => 'FERRAMENTA DE NÚMERO DA SEMANA';

  @override
  String get homeTitle => 'Em que semana estamos?';

  @override
  String get homeLead => 'Números da semana, datas e dias importantes do calendário num só lugar.';

  @override
  String get rightNow => 'NESTE MOMENTO';

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
    return 'Ano $number';
  }

  @override
  String weekOf(int current, int total) {
    return 'Semana $current / $total';
  }

  @override
  String yearProgress(int percent) {
    return '$percent % do ano decorrido';
  }

  @override
  String get weeksTotal => '52/53 semanas';

  @override
  String get previous => 'Anterior';

  @override
  String get next => 'Seguinte';

  @override
  String get today => 'Hoje';

  @override
  String get thisWeek => 'Esta semana';

  @override
  String get thisMonth => 'Este mês';

  @override
  String get thisYear => 'Este ano';

  @override
  String get lookupTitle => 'Descubra o número da semana de qualquer data';

  @override
  String get chooseDate => 'Escolher data';

  @override
  String get dateToWeek => 'Data para semana';

  @override
  String get weekToDate => 'Semana para datas';

  @override
  String get weekdayCalculator => 'Dia da semana';

  @override
  String get openWeek => 'Abrir detalhes da semana';

  @override
  String get year => 'Ano';

  @override
  String get month => 'Mês';

  @override
  String get weekNumber => 'Número da semana';

  @override
  String get dayOfYear => 'Dia do ano';

  @override
  String get daysRemaining => 'Dias restantes';

  @override
  String get quarter => 'Trimestre';

  @override
  String quarterLabel(int number) {
    return 'Trimestre $number';
  }

  @override
  String get weekRange => 'De segunda a domingo';

  @override
  String dayCount(int count) {
    return '$count dias';
  }

  @override
  String weekDaysResult(int weeks, int days) {
    return '$weeks semanas e $days dias';
  }

  @override
  String get holidays => 'Feriados';

  @override
  String get flagDays => 'Dias de bandeira';

  @override
  String get schoolHolidays => 'Férias escolares';

  @override
  String get nextHoliday => 'Próximo feriado';

  @override
  String get noEvents => 'Sem efemérides';

  @override
  String get official => 'Feriado oficial';

  @override
  String get observance => 'Efeméride';

  @override
  String get all => 'Todos';

  @override
  String get confirmed => 'Confirmado';

  @override
  String get estimated => 'estimado';

  @override
  String get unknown => 'Ainda não publicado';

  @override
  String get noSchoolData => 'Não há dados publicados de férias escolares para este ano.';

  @override
  String get schoolCoverage => 'As datas da sua escola podem diferir do calendário municipal.';

  @override
  String get winterBreak => 'Férias de inverno';

  @override
  String get autumnBreak => 'Férias de outono';

  @override
  String get city => 'Cidade';

  @override
  String get source => 'Fonte';

  @override
  String verifiedAt(String date) {
    return 'Verificado a $date';
  }

  @override
  String get daysBetween => 'Dias entre datas';

  @override
  String get workingDaysBetween => 'Calculadora de dias úteis';

  @override
  String get workingDays => 'Dias úteis';

  @override
  String get weekends => 'Fins de semana';

  @override
  String get weekdayHolidays => 'Feriados em dias úteis';

  @override
  String get totalDays => 'Dias no total';

  @override
  String get firstDate => 'Data inicial';

  @override
  String get lastDate => 'Data final';

  @override
  String get invalidRange => 'A data final tem de ser igual ou posterior à data inicial.';

  @override
  String get distanceNote => 'O resultado é a distância entre as datas. A ordem não importa.';

  @override
  String get workingNote => 'Ambas as datas são contadas. Os dias úteis são de segunda a sexta, excluindo feriados oficiais. A véspera de Natal e a véspera de São João contam como dias úteis.';

  @override
  String get yearWeeks => 'Todas as semanas do ano';

  @override
  String get yearCalendar => 'Calendário anual';

  @override
  String get firstHalf => 'Primeiro semestre';

  @override
  String get secondHalf => 'Segundo semestre';

  @override
  String get wholeYear => 'Ano inteiro';

  @override
  String get yearWorkingDays => 'Dias úteis por ano';

  @override
  String get monthWorkingDays => 'Dias úteis por mês';

  @override
  String get share => 'Partilhar';

  @override
  String get openWebsite => 'Abrir o site';

  @override
  String get copy => 'Copiar';

  @override
  String get copied => 'Copiado';

  @override
  String get printPdf => 'Imprimir / guardar PDF';

  @override
  String get exportCsv => 'Exportar CSV';

  @override
  String get exportCalendar => 'Exportar calendário (.ics)';

  @override
  String get exportFailed => 'A exportação falhou. Tente novamente.';

  @override
  String get openFailed => 'Não foi possível abrir a ligação.';

  @override
  String get language => 'Idioma';

  @override
  String get finnish => 'Finlandês';

  @override
  String get english => 'Inglês';

  @override
  String get theme => 'Aspeto';

  @override
  String get system => 'Sistema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Escuro';

  @override
  String get firstScreen => 'Ecrã inicial';

  @override
  String get privacyNote => 'Funciona offline. Sem conta, sem análise, sem publicidade.';

  @override
  String get dataCoverage => 'Dados do calendário: 2020–2035. As férias escolares só estão disponíveis para os anos publicados.';

  @override
  String get about => 'Acerca da aplicação';

  @override
  String get licenses => 'Licenças de código aberto';

  @override
  String get info => 'Sobre os números da semana';

  @override
  String get faq => 'Perguntas frequentes';

  @override
  String get methodology => 'Metodologia';

  @override
  String get sources => 'Fontes de dados';

  @override
  String get editorial => 'Princípios editoriais';

  @override
  String get usComparison => 'Finlândia e EUA';

  @override
  String get isoWeek => 'Semana ISO';

  @override
  String get usWeek => 'Semana norte-americana';

  @override
  String get isoExplanation => 'A semana começa à segunda-feira. A primeira semana ISO do ano contém o dia 4 de janeiro. O ano ISO pode diferir do ano civil.';

  @override
  String get openData => 'Dados abertos';

  @override
  String get dataExplorer => 'Explorar os dados do calendário';

  @override
  String get bundledData => 'Conjunto de dados incluído';

  @override
  String get dataCopyNote => 'Copiar o ano selecionado em JSON.';

  @override
  String get websiteResources => 'Mais no site';

  @override
  String get websiteResourcesNote => 'Os restantes serviços do site abrem no navegador e requerem ligação à internet.';

  @override
  String get contact => 'Contacto';

  @override
  String get privacy => 'Privacidade';

  @override
  String get terms => 'Termos';

  @override
  String get timeManagement => 'Gestão do tempo';

  @override
  String get sun => 'O sol em Helsínquia';

  @override
  String get sunrise => 'Nascer do sol';

  @override
  String get sunset => 'Pôr do sol';

  @override
  String get daylight => 'Duração do dia';

  @override
  String get polarDay => 'Sol da meia-noite';

  @override
  String get polarNight => 'Noite polar';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get weekNotes => 'Nota da semana';

  @override
  String get noteHint => 'Escreva uma nota para esta semana…';

  @override
  String get saved => 'Guardado neste dispositivo';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get notFound => 'Página não encontrada';

  @override
  String get outOfRange => 'Escolha um ano entre 2020 e 2035.';

  @override
  String get backHome => 'Voltar ao início';

  @override
  String get loadingError => 'Não foi possível carregar os dados do calendário.';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get menu => 'Abrir o menu';

  @override
  String get dayDetails => 'Detalhes do dia';

  @override
  String get close => 'Fechar';

  @override
  String get holidayRule => 'Regra da data';

  @override
  String get fiContent => 'O material de origem do site está em finlandês.';

  @override
  String get nameDaysUnavailable => 'Os dias onomásticos serão acrescentados após a verificação da licença.';

  @override
  String get weekList => 'Lista de semanas';
}
