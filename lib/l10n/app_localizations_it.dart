// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appName => 'Viikkonro';

  @override
  String get wordmark => 'Viikko nyt';

  @override
  String get home => 'Home';

  @override
  String get weeks => 'Settimane';

  @override
  String get calendar => 'Calendario';

  @override
  String get tools => 'Calcolatori';

  @override
  String get more => 'Altro';

  @override
  String get settings => 'Impostazioni';

  @override
  String get eyebrow => 'STRUMENTO NUMERO DELLA SETTIMANA';

  @override
  String get homeTitle => 'In che settimana siamo?';

  @override
  String get homeLead =>
      'Numeri di settimana, date e giorni importanti del calendario in un unico posto.';

  @override
  String get rightNow => 'PROPRIO ORA';

  @override
  String get week => 'Settimana';

  @override
  String weekLabel(int number) {
    return 'Settimana $number';
  }

  @override
  String weekShort(int number) {
    return 'Sett. $number';
  }

  @override
  String yearLabel(int number) {
    return 'Anno $number';
  }

  @override
  String weekOf(int current, int total) {
    return 'Settimana $current / $total';
  }

  @override
  String yearProgress(int percent) {
    return '$percent % dell’anno trascorso';
  }

  @override
  String get weeksTotal => '52/53 settimane';

  @override
  String get previous => 'Precedente';

  @override
  String get next => 'Successivo';

  @override
  String get today => 'Oggi';

  @override
  String get thisWeek => 'Questa settimana';

  @override
  String get thisMonth => 'Questo mese';

  @override
  String get thisYear => 'Quest’anno';

  @override
  String get lookupTitle => 'Trova il numero della settimana di qualsiasi data';

  @override
  String get chooseDate => 'Scegli una data';

  @override
  String get dateToWeek => 'Data in settimana';

  @override
  String get weekToDate => 'Settimana in date';

  @override
  String get weekdayCalculator => 'Giorno della settimana';

  @override
  String get openWeek => 'Apri i dettagli della settimana';

  @override
  String get year => 'Anno';

  @override
  String get month => 'Mese';

  @override
  String get weekNumber => 'Numero della settimana';

  @override
  String get dayOfYear => 'Giorno dell’anno';

  @override
  String get daysRemaining => 'Giorni rimanenti';

  @override
  String get quarter => 'Trimestre';

  @override
  String quarterLabel(int number) {
    return 'Trimestre $number';
  }

  @override
  String get weekRange => 'Da lunedì a domenica';

  @override
  String dayCount(int count) {
    return '$count giorni';
  }

  @override
  String weekDaysResult(int weeks, int days) {
    return '$weeks settimane e $days giorni';
  }

  @override
  String get holidays => 'Giorni festivi';

  @override
  String get flagDays => 'Giorni di bandiera';

  @override
  String get schoolHolidays => 'Vacanze scolastiche';

  @override
  String get nextHoliday => 'Prossimo giorno festivo';

  @override
  String get noEvents => 'Nessuna ricorrenza';

  @override
  String get official => 'Festività ufficiale';

  @override
  String get observance => 'Ricorrenza';

  @override
  String get all => 'Tutti';

  @override
  String get confirmed => 'Confermato';

  @override
  String get estimated => 'stimato';

  @override
  String get unknown => 'Non ancora pubblicato';

  @override
  String get noSchoolData =>
      'Non ci sono dati pubblicati sulle vacanze scolastiche per quest’anno.';

  @override
  String get schoolCoverage =>
      'Le date della tua scuola possono differire dal calendario comunale.';

  @override
  String get winterBreak => 'Vacanze invernali';

  @override
  String get autumnBreak => 'Vacanze autunnali';

  @override
  String get city => 'Città';

  @override
  String get source => 'Fonte';

  @override
  String verifiedAt(String date) {
    return 'Verificato il $date';
  }

  @override
  String get daysBetween => 'Giorni tra due date';

  @override
  String get workingDaysBetween => 'Calcolatore di giorni lavorativi';

  @override
  String get workingDays => 'Giorni lavorativi';

  @override
  String get weekends => 'Fine settimana';

  @override
  String get weekdayHolidays => 'Festività infrasettimanali';

  @override
  String get totalDays => 'Giorni totali';

  @override
  String get firstDate => 'Data iniziale';

  @override
  String get lastDate => 'Data finale';

  @override
  String get invalidRange =>
      'La data finale deve essere uguale o successiva a quella iniziale.';

  @override
  String get distanceNote =>
      'Il risultato è la distanza tra le date. L’ordine non conta.';

  @override
  String get workingNote =>
      'Entrambe le date sono incluse. I giorni lavorativi vanno dal lunedì al venerdì, escluse le festività ufficiali. La vigilia di Natale e quella di mezza estate contano come lavorative.';

  @override
  String get yearWeeks => 'Tutte le settimane dell’anno';

  @override
  String get yearCalendar => 'Calendario annuale';

  @override
  String get firstHalf => 'Primo semestre';

  @override
  String get secondHalf => 'Secondo semestre';

  @override
  String get wholeYear => 'Anno intero';

  @override
  String get yearWorkingDays => 'Giorni lavorativi all’anno';

  @override
  String get monthWorkingDays => 'Giorni lavorativi al mese';

  @override
  String get share => 'Condividi';

  @override
  String get openWebsite => 'Apri il sito';

  @override
  String get copy => 'Copia';

  @override
  String get copied => 'Copiato';

  @override
  String get printPdf => 'Stampa / salva in PDF';

  @override
  String get exportCsv => 'Esporta CSV';

  @override
  String get exportCalendar => 'Esporta calendario (.ics)';

  @override
  String get exportFailed => 'Esportazione non riuscita. Riprova.';

  @override
  String get openFailed => 'Impossibile aprire il link.';

  @override
  String get language => 'Lingua';

  @override
  String get finnish => 'Finlandese';

  @override
  String get english => 'Inglese';

  @override
  String get theme => 'Aspetto';

  @override
  String get system => 'Sistema';

  @override
  String get light => 'Chiaro';

  @override
  String get dark => 'Scuro';

  @override
  String get firstScreen => 'Schermata iniziale';

  @override
  String get privacyNote =>
      'Funziona offline. Nessun account. L’app usa segnalazioni di arresti anomali, analisi e annunci con controlli sulla privacy.';

  @override
  String get dataCoverage =>
      'Dati del calendario: 2020–2035. Le vacanze scolastiche sono disponibili solo per gli anni pubblicati.';

  @override
  String get about => 'Informazioni sull’app';

  @override
  String get licenses => 'Licenze open source';

  @override
  String get info => 'Informazioni sui numeri di settimana';

  @override
  String get faq => 'Domande frequenti';

  @override
  String get methodology => 'Metodologia';

  @override
  String get sources => 'Fonti dei dati';

  @override
  String get editorial => 'Principi editoriali';

  @override
  String get usComparison => 'Finlandia e USA';

  @override
  String get isoWeek => 'Settimana ISO';

  @override
  String get usWeek => 'Settimana statunitense';

  @override
  String get isoExplanation =>
      'La settimana inizia di lunedì. La prima settimana ISO dell’anno contiene il 4 gennaio. L’anno ISO può differire dall’anno solare.';

  @override
  String get openData => 'Dati aperti';

  @override
  String get dataExplorer => 'Esplora i dati del calendario';

  @override
  String get bundledData => 'Set di dati incluso';

  @override
  String get dataCopyNote => 'Copia l’anno selezionato in formato JSON.';

  @override
  String get websiteResources => 'Altro sul sito';

  @override
  String get websiteResourcesNote =>
      'Gli altri servizi del sito si aprono nel browser e richiedono una connessione a internet.';

  @override
  String get contact => 'Contatti';

  @override
  String get privacy => 'Privacy';

  @override
  String get terms => 'Termini';

  @override
  String get timeManagement => 'Gestione del tempo';

  @override
  String get sun => 'Il sole a Helsinki';

  @override
  String get sunrise => 'Alba';

  @override
  String get sunset => 'Tramonto';

  @override
  String get daylight => 'Durata del giorno';

  @override
  String get polarDay => 'Sole di mezzanotte';

  @override
  String get polarNight => 'Notte polare';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get weekNotes => 'Nota della settimana';

  @override
  String get noteHint => 'Scrivi una nota per questa settimana…';

  @override
  String get saved => 'Salvato su questo dispositivo';

  @override
  String get save => 'Salva';

  @override
  String get cancel => 'Annulla';

  @override
  String get notFound => 'Pagina non trovata';

  @override
  String get outOfRange => 'Scegli un anno tra il 2020 e il 2035.';

  @override
  String get backHome => 'Torna alla home';

  @override
  String get loadingError => 'Impossibile caricare i dati del calendario.';

  @override
  String get retry => 'Riprova';

  @override
  String get menu => 'Apri il menu';

  @override
  String get dayDetails => 'Dettagli del giorno';

  @override
  String get close => 'Chiudi';

  @override
  String get holidayRule => 'Regola della data';

  @override
  String get fiContent => 'Il materiale originale del sito è in finlandese.';

  @override
  String get nameDaysUnavailable =>
      'Gli onomastici saranno aggiunti una volta verificata la licenza.';

  @override
  String get weekList => 'Elenco delle settimane';
}
