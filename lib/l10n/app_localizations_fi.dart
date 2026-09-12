// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get appName => 'Viikkonro';

  @override
  String get wordmark => 'Viikko nyt';

  @override
  String get home => 'Etusivu';

  @override
  String get weeks => 'Viikot';

  @override
  String get calendar => 'Kalenteri';

  @override
  String get tools => 'Laskurit';

  @override
  String get more => 'Lisää';

  @override
  String get settings => 'Asetukset';

  @override
  String get eyebrow => 'VIIKKONUMEROTYÖKALU';

  @override
  String get homeTitle => 'Mikä viikko nyt on?';

  @override
  String get homeLead => 'Viikkonumero, päivämäärät ja kalenterin tärkeät päivät yhdessä paikassa.';

  @override
  String get rightNow => 'JUURI NYT ON';

  @override
  String get week => 'Viikko';

  @override
  String weekLabel(int number) {
    return 'Viikko $number';
  }

  @override
  String weekShort(int number) {
    return 'Vk $number';
  }

  @override
  String yearLabel(int number) {
    return 'Vuosi $number';
  }

  @override
  String weekOf(int current, int total) {
    return 'Viikko $current / $total';
  }

  @override
  String yearProgress(int percent) {
    return '$percent% vuodesta kulunut';
  }

  @override
  String get weeksTotal => '52/53 viikkoa';

  @override
  String get previous => 'Edellinen';

  @override
  String get next => 'Seuraava';

  @override
  String get today => 'Tänään';

  @override
  String get thisWeek => 'Tämä viikko';

  @override
  String get thisMonth => 'Tämä kuukausi';

  @override
  String get thisYear => 'Tämä vuosi';

  @override
  String get lookupTitle => 'Tarkista minkä tahansa päivän viikkonumero';

  @override
  String get chooseDate => 'Valitse päivämäärä';

  @override
  String get dateToWeek => 'Päivämäärä viikoksi';

  @override
  String get weekToDate => 'Viikko päivämääräksi';

  @override
  String get weekdayCalculator => 'Viikonpäivälaskuri';

  @override
  String get openWeek => 'Avaa viikon tiedot';

  @override
  String get year => 'Vuosi';

  @override
  String get month => 'Kuukausi';

  @override
  String get weekNumber => 'Viikkonumero';

  @override
  String get dayOfYear => 'Vuoden päivä';

  @override
  String get daysRemaining => 'Päiviä jäljellä';

  @override
  String get quarter => 'Vuosineljännes';

  @override
  String quarterLabel(int number) {
    return 'Vuosineljännes $number';
  }

  @override
  String get weekRange => 'Maanantaista sunnuntaihin';

  @override
  String dayCount(int count) {
    return '$count päivää';
  }

  @override
  String weekDaysResult(int weeks, int days) {
    return '$weeks viikkoa ja $days päivää';
  }

  @override
  String get holidays => 'Pyhäpäivät';

  @override
  String get flagDays => 'Liputuspäivät';

  @override
  String get schoolHolidays => 'Koululomat';

  @override
  String get nextHoliday => 'Seuraava pyhäpäivä';

  @override
  String get noEvents => 'Ei merkkipäiviä';

  @override
  String get official => 'Virallinen pyhäpäivä';

  @override
  String get observance => 'Merkkipäivä';

  @override
  String get all => 'Kaikki';

  @override
  String get confirmed => 'Vahvistettu';

  @override
  String get estimated => 'arvio';

  @override
  String get unknown => 'Ei vielä julkaistu';

  @override
  String get noSchoolData => 'Tälle vuodelle ei ole julkaistua koululomatietoa.';

  @override
  String get schoolCoverage => 'Kuntien yleiset päivät voivat poiketa oman koulun päivistä.';

  @override
  String get winterBreak => 'Talviloma';

  @override
  String get autumnBreak => 'Syysloma';

  @override
  String get city => 'Kaupunki';

  @override
  String get source => 'Lähde';

  @override
  String verifiedAt(String date) {
    return 'Tarkistettu $date';
  }

  @override
  String get daysBetween => 'Päivien erotus';

  @override
  String get workingDaysBetween => 'Työpäivälaskuri';

  @override
  String get workingDays => 'Työpäivät';

  @override
  String get weekends => 'Viikonloput';

  @override
  String get weekdayHolidays => 'Arkipyhät (ma–pe)';

  @override
  String get totalDays => 'Päivää yhteensä';

  @override
  String get firstDate => 'Alkupäivä';

  @override
  String get lastDate => 'Loppupäivä';

  @override
  String get invalidRange => 'Loppupäivän on oltava alkupäivän jälkeen tai sama päivä.';

  @override
  String get distanceNote => 'Erotus on päivämäärien välinen etäisyys. Järjestyksellä ei ole väliä.';

  @override
  String get workingNote => 'Molemmat päivät lasketaan mukaan. Työpäivä on ma–pe, pois lukien viralliset pyhäpäivät. Jouluaatto ja juhannusaatto lasketaan työpäiviksi.';

  @override
  String get yearWeeks => 'Vuoden kaikki viikot';

  @override
  String get yearCalendar => 'Vuosikalenteri';

  @override
  String get firstHalf => 'Alkuvuosi';

  @override
  String get secondHalf => 'Loppuvuosi';

  @override
  String get wholeYear => 'Koko vuosi';

  @override
  String get yearWorkingDays => 'Vuoden työpäivät';

  @override
  String get monthWorkingDays => 'Kuukauden työpäivät';

  @override
  String get share => 'Jaa';

  @override
  String get openWebsite => 'Avaa verkossa';

  @override
  String get copy => 'Kopioi';

  @override
  String get copied => 'Kopioitu';

  @override
  String get printPdf => 'Tulosta / tallenna PDF';

  @override
  String get exportCsv => 'Lataa CSV';

  @override
  String get exportCalendar => 'Vie kalenteriin (.ics)';

  @override
  String get exportFailed => 'Vienti epäonnistui. Yritä uudelleen.';

  @override
  String get openFailed => 'Linkin avaaminen epäonnistui.';

  @override
  String get language => 'Kieli';

  @override
  String get finnish => 'Suomi';

  @override
  String get english => 'Englanti';

  @override
  String get theme => 'Ulkoasu';

  @override
  String get system => 'Järjestelmä';

  @override
  String get light => 'Vaalea';

  @override
  String get dark => 'Tumma';

  @override
  String get firstScreen => 'Aloitusnäkymä';

  @override
  String get privacyNote => 'Toimii ilman verkkoyhteyttä. Ei käyttäjätiliä, analytiikkaa tai mainoksia.';

  @override
  String get dataCoverage => 'Kalenteritiedot: 2020–2035. Koululomat saatavilla vain julkaistuille vuosille.';

  @override
  String get about => 'Tietoa sovelluksesta';

  @override
  String get licenses => 'Avoimen lähdekoodin lisenssit';

  @override
  String get info => 'Tietoa viikoista';

  @override
  String get faq => 'Usein kysytyt kysymykset';

  @override
  String get methodology => 'Laskentamenetelmä';

  @override
  String get sources => 'Tietolähteet';

  @override
  String get editorial => 'Toimitusperiaatteet';

  @override
  String get usComparison => 'Suomi ja USA';

  @override
  String get isoWeek => 'ISO-viikko';

  @override
  String get usWeek => 'USA:n viikko';

  @override
  String get isoExplanation => 'Viikko alkaa maanantaista. Vuoden ensimmäinen ISO-viikko sisältää 4. tammikuuta. Viikkovuosi voi erota kalenterivuodesta.';

  @override
  String get openData => 'Avoin data';

  @override
  String get dataExplorer => 'Tutki kalenteritietoja';

  @override
  String get bundledData => 'Sovelluksen mukana toimitettu aineisto';

  @override
  String get dataCopyNote => 'Voit kopioida valitun vuoden tiedot JSON-muodossa.';

  @override
  String get websiteResources => 'Lisää verkkosivustolla';

  @override
  String get websiteResourcesNote => 'Verkkosivuston lisäpalvelut avautuvat selaimessa ja tarvitsevat verkkoyhteyden.';

  @override
  String get contact => 'Ota yhteyttä';

  @override
  String get privacy => 'Tietosuoja';

  @override
  String get terms => 'Käyttöehdot';

  @override
  String get timeManagement => 'Ajanhallinta';

  @override
  String get sun => 'Aurinko Helsingissä';

  @override
  String get sunrise => 'Auringonnousu';

  @override
  String get sunset => 'Auringonlasku';

  @override
  String get daylight => 'Päivän pituus';

  @override
  String get polarDay => 'Yötön yö';

  @override
  String get polarNight => 'Kaamos';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get weekNotes => 'Viikon muistiinpano';

  @override
  String get noteHint => 'Kirjoita muistiinpano tälle viikolle…';

  @override
  String get saved => 'Tallennettu laitteelle';

  @override
  String get save => 'Tallenna';

  @override
  String get cancel => 'Peruuta';

  @override
  String get notFound => 'Sivua ei löytynyt';

  @override
  String get outOfRange => 'Valitse vuosi väliltä 2020–2035.';

  @override
  String get backHome => 'Palaa etusivulle';

  @override
  String get loadingError => 'Kalenteritietojen lataaminen epäonnistui.';

  @override
  String get retry => 'Yritä uudelleen';

  @override
  String get menu => 'Avaa valikko';

  @override
  String get dayDetails => 'Päivän tiedot';

  @override
  String get close => 'Sulje';

  @override
  String get holidayRule => 'Päivämäärän määräytyminen';

  @override
  String get fiContent => 'Verkkosivuston lähdeaineisto on suomeksi.';

  @override
  String get nameDaysUnavailable => 'Nimipäivät lisätään lisenssin varmistamisen jälkeen.';

  @override
  String get weekList => 'Viikkolista';
}
