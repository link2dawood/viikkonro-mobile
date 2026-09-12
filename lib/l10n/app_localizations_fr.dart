// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Viikkonro';

  @override
  String get wordmark => 'Viikko nyt';

  @override
  String get home => 'Accueil';

  @override
  String get weeks => 'Semaines';

  @override
  String get calendar => 'Calendrier';

  @override
  String get tools => 'Calculatrices';

  @override
  String get more => 'Plus';

  @override
  String get settings => 'Paramètres';

  @override
  String get eyebrow => 'OUTIL DE NUMÉRO DE SEMAINE';

  @override
  String get homeTitle => 'Quelle semaine sommes-nous ?';

  @override
  String get homeLead => 'Numéros de semaine, dates et jours importants du calendrier au même endroit.';

  @override
  String get rightNow => 'EN CE MOMENT';

  @override
  String get week => 'Semaine';

  @override
  String weekLabel(int number) {
    return 'Semaine $number';
  }

  @override
  String weekShort(int number) {
    return 'S $number';
  }

  @override
  String yearLabel(int number) {
    return 'Année $number';
  }

  @override
  String weekOf(int current, int total) {
    return 'Semaine $current / $total';
  }

  @override
  String yearProgress(int percent) {
    return '$percent % de l’année écoulée';
  }

  @override
  String get weeksTotal => '52/53 semaines';

  @override
  String get previous => 'Précédent';

  @override
  String get next => 'Suivant';

  @override
  String get today => 'Aujourd’hui';

  @override
  String get thisWeek => 'Cette semaine';

  @override
  String get thisMonth => 'Ce mois-ci';

  @override
  String get thisYear => 'Cette année';

  @override
  String get lookupTitle => 'Trouver le numéro de semaine de n’importe quelle date';

  @override
  String get chooseDate => 'Choisir une date';

  @override
  String get dateToWeek => 'Date vers semaine';

  @override
  String get weekToDate => 'Semaine vers dates';

  @override
  String get weekdayCalculator => 'Jour de la semaine';

  @override
  String get openWeek => 'Ouvrir les détails de la semaine';

  @override
  String get year => 'Année';

  @override
  String get month => 'Mois';

  @override
  String get weekNumber => 'Numéro de semaine';

  @override
  String get dayOfYear => 'Jour de l’année';

  @override
  String get daysRemaining => 'Jours restants';

  @override
  String get quarter => 'Trimestre';

  @override
  String quarterLabel(int number) {
    return 'Trimestre $number';
  }

  @override
  String get weekRange => 'Du lundi au dimanche';

  @override
  String dayCount(int count) {
    return '$count jours';
  }

  @override
  String weekDaysResult(int weeks, int days) {
    return '$weeks semaines et $days jours';
  }

  @override
  String get holidays => 'Jours fériés';

  @override
  String get flagDays => 'Jours de pavoisement';

  @override
  String get schoolHolidays => 'Vacances scolaires';

  @override
  String get nextHoliday => 'Prochain jour férié';

  @override
  String get noEvents => 'Aucune date marquante';

  @override
  String get official => 'Jour férié officiel';

  @override
  String get observance => 'Date marquante';

  @override
  String get all => 'Tous';

  @override
  String get confirmed => 'Confirmé';

  @override
  String get estimated => 'estimé';

  @override
  String get unknown => 'Pas encore publié';

  @override
  String get noSchoolData => 'Aucune donnée de vacances scolaires publiée pour cette année.';

  @override
  String get schoolCoverage => 'Les dates de votre école peuvent différer du calendrier municipal.';

  @override
  String get winterBreak => 'Vacances d’hiver';

  @override
  String get autumnBreak => 'Vacances d’automne';

  @override
  String get city => 'Ville';

  @override
  String get source => 'Source';

  @override
  String verifiedAt(String date) {
    return 'Vérifié le $date';
  }

  @override
  String get daysBetween => 'Jours entre deux dates';

  @override
  String get workingDaysBetween => 'Calculateur de jours ouvrés';

  @override
  String get workingDays => 'Jours ouvrés';

  @override
  String get weekends => 'Week-ends';

  @override
  String get weekdayHolidays => 'Jours fériés en semaine';

  @override
  String get totalDays => 'Jours au total';

  @override
  String get firstDate => 'Date de début';

  @override
  String get lastDate => 'Date de fin';

  @override
  String get invalidRange => 'La date de fin doit être identique ou postérieure à la date de début.';

  @override
  String get distanceNote => 'Le résultat est la distance entre les dates. L’ordre n’a pas d’importance.';

  @override
  String get workingNote =>
      'Les deux dates sont incluses. Les jours ouvrés vont du lundi au vendredi, hors jours fériés officiels. La veille de Noël et la veille de la Saint-Jean comptent comme jours ouvrés.';

  @override
  String get yearWeeks => 'Toutes les semaines de l’année';

  @override
  String get yearCalendar => 'Calendrier annuel';

  @override
  String get firstHalf => 'Premier semestre';

  @override
  String get secondHalf => 'Second semestre';

  @override
  String get wholeYear => 'Année entière';

  @override
  String get yearWorkingDays => 'Jours ouvrés par an';

  @override
  String get monthWorkingDays => 'Jours ouvrés par mois';

  @override
  String get share => 'Partager';

  @override
  String get openWebsite => 'Ouvrir le site';

  @override
  String get copy => 'Copier';

  @override
  String get copied => 'Copié';

  @override
  String get printPdf => 'Imprimer / enregistrer en PDF';

  @override
  String get exportCsv => 'Exporter en CSV';

  @override
  String get exportCalendar => 'Exporter le calendrier (.ics)';

  @override
  String get exportFailed => 'L’export a échoué. Réessayez.';

  @override
  String get openFailed => 'Impossible d’ouvrir le lien.';

  @override
  String get language => 'Langue';

  @override
  String get finnish => 'Finnois';

  @override
  String get english => 'Anglais';

  @override
  String get theme => 'Apparence';

  @override
  String get system => 'Système';

  @override
  String get light => 'Clair';

  @override
  String get dark => 'Sombre';

  @override
  String get firstScreen => 'Écran de démarrage';

  @override
  String get privacyNote => 'Fonctionne hors ligne. Pas de compte, pas d’analyse, pas de publicité.';

  @override
  String get dataCoverage => 'Données du calendrier : 2020–2035. Vacances scolaires disponibles uniquement pour les années publiées.';

  @override
  String get about => 'À propos de l’application';

  @override
  String get licenses => 'Licences open source';

  @override
  String get info => 'À propos des numéros de semaine';

  @override
  String get faq => 'Questions fréquentes';

  @override
  String get methodology => 'Méthodologie';

  @override
  String get sources => 'Sources des données';

  @override
  String get editorial => 'Principes éditoriaux';

  @override
  String get usComparison => 'Finlande et États-Unis';

  @override
  String get isoWeek => 'Semaine ISO';

  @override
  String get usWeek => 'Semaine américaine';

  @override
  String get isoExplanation => 'La semaine commence le lundi. La première semaine ISO de l’année contient le 4 janvier. L’année ISO peut différer de l’année civile.';

  @override
  String get openData => 'Données ouvertes';

  @override
  String get dataExplorer => 'Explorer les données du calendrier';

  @override
  String get bundledData => 'Jeu de données fourni';

  @override
  String get dataCopyNote => 'Copier l’année sélectionnée au format JSON.';

  @override
  String get websiteResources => 'Plus sur le site';

  @override
  String get websiteResourcesNote => 'Les autres services du site s’ouvrent dans le navigateur et nécessitent une connexion Internet.';

  @override
  String get contact => 'Contact';

  @override
  String get privacy => 'Confidentialité';

  @override
  String get terms => 'Conditions';

  @override
  String get timeManagement => 'Gestion du temps';

  @override
  String get sun => 'Le soleil à Helsinki';

  @override
  String get sunrise => 'Lever du soleil';

  @override
  String get sunset => 'Coucher du soleil';

  @override
  String get daylight => 'Durée du jour';

  @override
  String get polarDay => 'Soleil de minuit';

  @override
  String get polarNight => 'Nuit polaire';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get weekNotes => 'Note de la semaine';

  @override
  String get noteHint => 'Écrire une note pour cette semaine…';

  @override
  String get saved => 'Enregistré sur cet appareil';

  @override
  String get save => 'Enregistrer';

  @override
  String get cancel => 'Annuler';

  @override
  String get notFound => 'Page introuvable';

  @override
  String get outOfRange => 'Choisissez une année entre 2020 et 2035.';

  @override
  String get backHome => 'Retour à l’accueil';

  @override
  String get loadingError => 'Impossible de charger les données du calendrier.';

  @override
  String get retry => 'Réessayer';

  @override
  String get menu => 'Ouvrir le menu';

  @override
  String get dayDetails => 'Détails du jour';

  @override
  String get close => 'Fermer';

  @override
  String get holidayRule => 'Règle de date';

  @override
  String get fiContent => 'Le matériel source du site est en finnois.';

  @override
  String get nameDaysUnavailable => 'Les fêtes du prénom seront ajoutées une fois la licence vérifiée.';

  @override
  String get weekList => 'Liste des semaines';
}
