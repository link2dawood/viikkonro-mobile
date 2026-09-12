import '../core/date/iso_week.dart';

class AppRoute {
  const AppRoute(this.kind, {this.year, this.month, this.week, this.quarter, this.date, this.slug, this.half});
  final String kind;
  final int? year, month, week, quarter, half;
  final DateTime? date;
  final String? slug;
  static AppRoute parse(String value, DateTime now) {
    final uri = Uri.tryParse(value);
    if (uri == null || (uri.hasScheme && (!['http', 'https'].contains(uri.scheme) || uri.host != 'viikkonro.fi'))) return const AppRoute('notFound');
    final path = uri.path.endsWith('/') && uri.path.length > 1 ? uri.path.substring(0, uri.path.length - 1) : uri.path;
    const staticRoutes = {
      '/': 'home',
      '/en': 'home',
      '/laskurit': 'tools',
      '/asetukset': 'settings',
      '/paivamaara-viikoksi': 'dateLookup',
      '/viikko-paivamaaraksi': 'weekLookup',
      '/viikonpaiva': 'weekday',
      '/paivien-erotus': 'daysBetween',
      '/tyopaivalaskuri': 'workingBetween',
      '/mika-kuukausi-nyt': 'month',
      '/mika-vuosi-nyt': 'yearCalendar',
      '/liputuspaivat': 'flags',
      '/ukk': 'faq',
      '/lisaa': 'more',
      '/avoin-data': 'data',
      '/api-playground': 'data',
      '/data/week': 'data',
      '/data/month': 'data',
      '/data/year': 'data',
      '/data/holiday': 'data',
      '/data/working-days': 'data',
      '/nimipaivat/tanaan': 'nameDays',
    };
    if (staticRoutes.containsKey(path)) {
      DateTime? chosen;
      final raw = uri.queryParameters['paiva'];
      if (raw != null) {
        chosen = DateTime.tryParse(raw);
        if (chosen == null || formatDate(chosen) != raw || chosen.year < 2020 || chosen.year > 2035) return const AppRoute('notFound');
      }
      return AppRoute(staticRoutes[path]!, year: now.year, month: now.month, date: chosen ?? now);
    }
    const articles = [
      'mika-on-viikkonumero',
      'viikko-alkaa-maanantaista',
      'kuinka-monta-viikkoa-vuodessa',
      'suomi-vs-usa-viikkonumerot',
      'tietolahteet',
      'menetelma',
      'toimitusperiaatteet',
      'tietoa-meista',
      'ota-yhteytta',
      'tietosuoja',
      'kayttoehdot',
      'ajanhallinta',
    ];
    final slug = path.replaceFirst('/', '');
    if (articles.contains(slug)) return AppRoute('article', slug: slug);
    if (path.startsWith('/nimipaiva/') || path.startsWith('/nimipaivat/')) return const AppRoute('nameDays');
    var match = RegExp(r'^/viikko-(\d+)-(\d{4})$').firstMatch(path);
    if (match != null) {
      final w = int.parse(match[1]!), y = int.parse(match[2]!);
      if (_year(y) && w >= 1 && w <= weeksInIsoYear(y)) return AppRoute('week', year: y, week: w);
      return const AppRoute('notFound');
    }
    match = RegExp(r'^/kuukausi-(\d+)-(\d{4})$').firstMatch(path);
    if (match != null) {
      final m = int.parse(match[1]!), y = int.parse(match[2]!);
      if (_year(y) && m >= 1 && m <= 12) return AppRoute('month', year: y, month: m);
      return const AppRoute('notFound');
    }
    match = RegExp(r'^/q([1-4])-(\d{4})$').firstMatch(path);
    if (match != null && _year(int.parse(match[2]!))) return AppRoute('quarter', quarter: int.parse(match[1]!), year: int.parse(match[2]!));
    match = RegExp(r'^/(vuosi|tulosta|kalenteri|tulostettava-kalenteri|pyhapaivat|liputuspaivat|tyopaivat|koululomat)-(\d{4})(?:-(alkuvuosi|loppuvuosi))?$').firstMatch(path);
    if (match != null && _year(int.parse(match[2]!))) {
      const kinds = {
        'vuosi': 'weeks',
        'tulosta': 'weekList',
        'kalenteri': 'yearCalendar',
        'tulostettava-kalenteri': 'printCalendar',
        'pyhapaivat': 'holidays',
        'liputuspaivat': 'flags',
        'tyopaivat': 'workingYear',
        'koululomat': 'school',
      };
      return AppRoute(
        kinds[match[1]]!,
        year: int.parse(match[2]!),
        half: match[3] == null
            ? null
            : match[3] == 'alkuvuosi'
            ? 1
            : 2,
      );
    }
    match = RegExp(r'^/tyopaivat-([a-z]+)-(\d{4})$').firstMatch(path);
    const months = ['tammikuu', 'helmikuu', 'maaliskuu', 'huhtikuu', 'toukokuu', 'kesakuu', 'heinakuu', 'elokuu', 'syyskuu', 'lokakuu', 'marraskuu', 'joulukuu'];
    if (match != null && months.contains(match[1]) && _year(int.parse(match[2]!))) return AppRoute('workingMonth', month: months.indexOf(match[1]!) + 1, year: int.parse(match[2]!));
    match = RegExp(r'^/(\d{4})/([a-z-]+)$').firstMatch(path);
    if (match != null && _year(int.parse(match[1]!))) return AppRoute('holidayDetail', year: int.parse(match[1]!), slug: match[2]);
    return const AppRoute('notFound');
  }

  static bool _year(int y) => y >= 2020 && y <= 2035;
}
