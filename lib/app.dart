import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/data/calendar_repository.dart';
import 'core/date/iso_week.dart';
import 'core/settings/app_settings.dart';
import 'core/telemetry/telemetry_service.dart';
import 'core/theme/brand_theme.dart';
import 'features/calendar/month_screen.dart';
import 'features/holidays/holidays_screen.dart';
import 'features/home/home_screen.dart';
import 'features/lookup/lookup_screen.dart';
import 'features/more/more_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/tools/tools_screen.dart';
import 'features/week/day_screen.dart';
import 'features/week/week_screen.dart';
import 'features/year/year_calendar_screen.dart';
import 'features/year/year_weeks_screen.dart';
import 'l10n/app_localizations.dart';
import 'routing/deep_links.dart';
import 'shared/components.dart';
import 'shared/formatters.dart';

class ViikkonroApp extends StatefulWidget {
  const ViikkonroApp({
    super.key,
    required this.settings,
    required this.repository,
    this.clock,
  });
  final AppSettings settings;
  final CalendarRepository repository;

  /// Injected in tests so a fixed date can be asserted on.
  final DateTime Function()? clock;

  @override
  State<ViikkonroApp> createState() => _ViikkonroAppState();
}

class _ViikkonroAppState extends State<ViikkonroApp> {
  /// Home screen widgets hand their route over the platform channel, so the
  /// navigator has to be reachable from outside the widget tree (FP-W12).
  static const _channel = MethodChannel('fi.viikkonro.app/routes');
  final _navigator = GlobalKey<NavigatorState>();

  AppSettings get settings => widget.settings;
  CalendarRepository get repository => widget.repository;

  @override
  void initState() {
    super.initState();
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'route') _open(call.arguments as String?);
    });
    // A cold start from a widget tap has its route waiting on the native side
    // before the first frame; ask for it once the navigator exists.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        _open(await _channel.invokeMethod<String>('initialRoute'));
      } on MissingPluginException {
        // No host channel: the app was not launched from a widget.
      }
    });
  }

  void _open(String? route) {
    if (route == null || route.isEmpty) return;
    _navigator.currentState?.pushNamed(route);
  }

  @override
  Widget build(BuildContext context) => TodayScope(
    clock: widget.clock,
    child: ListenableBuilder(
      listenable: settings,
      builder: (context, _) => MaterialApp(
        onGenerateTitle: (context) => AppLocalizations.of(context).appName,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: settings.locale,
        theme: Brand.theme(Brightness.light),
        darkTheme: Brand.theme(Brightness.dark),
        themeMode: settings.theme,
        navigatorKey: _navigator,
        navigatorObservers: TelemetryService.instance.navigatorObservers,
        // Native edge-to-edge follows the device theme. Keep Android's system
        // bar icons legible when the user explicitly chooses the opposite app
        // theme without replacing Android's three-button navigation scrim.
        builder: (context, child) {
          final iconBrightness = Theme.of(context).brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark;
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarIconBrightness: iconBrightness,
              systemNavigationBarIconBrightness: iconBrightness,
            ),
            child: child!,
          );
        },
        home: AppShell(settings: settings, repository: repository),
        onGenerateRoute: (routeSettings) => _route(routeSettings),
        // FP-R07: an unrecognised path is never a dead end.
        onUnknownRoute: (routeSettings) => MaterialPageRoute(
          settings: routeSettings,
          builder: (context) =>
              AppShell(settings: settings, repository: repository),
        ),
      ),
    ),
  );

  Route<dynamic>? _route(RouteSettings routeSettings) => MaterialPageRoute(
    settings: routeSettings,
    builder: (context) {
      final today = TodayScope.of(context);
      final route = AppRoute.parse(routeSettings.name ?? '/', today);
      final year = route.year ?? isoYear(today);
      return switch (route.kind) {
        'week' => WeekScreen(
          repository: repository,
          today: today,
          week: route.week!,
          year: route.year!,
        ),
        'weekday' => DayScreen(
          repository: repository,
          today: today,
          date: route.date ?? today,
        ),
        'weeks' || 'weekList' || 'quarter' => YearWeeksScreen(
          repository: repository,
          today: today,
          year: year,
        ),
        'yearCalendar' || 'printCalendar' => YearCalendarScreen(
          repository: repository,
          today: today,
          year: year,
        ),
        'month' => MonthScreen(
          repository: repository,
          today: today,
          year: year,
          month: route.month ?? today.month,
        ),
        'holidays' || 'holidayDetail' => HolidaysScreen(
          repository: repository,
          today: today,
          year: year,
        ),
        'flags' => HolidaysScreen(
          repository: repository,
          today: today,
          year: year,
          tab: 1,
        ),
        'school' => HolidaysScreen(
          repository: repository,
          today: today,
          year: year,
          tab: 2,
        ),
        'dateLookup' => LookupScreen(repository: repository, today: today),
        'weekLookup' => LookupScreen(
          repository: repository,
          today: today,
          tab: 1,
        ),
        'daysBetween' => ToolsScreen(repository: repository, today: today),
        'tools' || 'workingBetween' || 'workingYear' || 'workingMonth' =>
          ToolsScreen(repository: repository, today: today, tab: 1),
        'settings' => SettingsScreen(
          settings: settings,
          repository: repository,
        ),
        'faq' => WebsiteScreen(
          title: AppLocalizations.of(context).faq,
          slug: 'ukk',
        ),
        'nameDays' => WebsiteScreen(
          title: AppLocalizations.of(context).appName,
          slug: 'nimipaivat/tanaan',
          note: AppLocalizations.of(context).nameDaysUnavailable,
        ),
        'article' => WebsiteScreen(
          title: AppLocalizations.of(context).websiteResources,
          slug: route.slug ?? '',
        ),
        'data' => WebsiteScreen(
          title: AppLocalizations.of(context).openData,
          slug: 'avoin-data',
        ),
        _ => AppShell(settings: settings, repository: repository),
      };
    },
  );
}

/// The current civil date, refreshed when it actually changes. Everything that
/// says "today" reads it from here so midnight rollover is a single concern.
class TodayScope extends StatefulWidget {
  const TodayScope({super.key, required this.child, this.clock});
  final Widget child;
  final DateTime Function()? clock;

  static DateTime of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_TodayValue>()!.today;

  @override
  State<TodayScope> createState() => _TodayScopeState();
}

class _TodayScopeState extends State<TodayScope> {
  late DateTime _today = _now();
  Timer? _timer;
  AppLifecycleListener? _lifecycle;

  DateTime _now() => dateOnly((widget.clock ?? DateTime.now)());

  @override
  void initState() {
    super.initState();
    _schedule();
    // Coming back from the background can skip the timer entirely, so re-check.
    _lifecycle = AppLifecycleListener(onResume: _refresh);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _lifecycle?.dispose();
    super.dispose();
  }

  /// FP-H10: fire just after the next local midnight. Using the date
  /// constructor rather than a 24-hour duration keeps this correct across the
  /// daylight-saving transitions, when a civil day is 23 or 25 hours long.
  void _schedule() {
    _timer?.cancel();
    final now = (widget.clock ?? DateTime.now)();
    final midnight = DateTime(now.year, now.month, now.day + 1);
    final wait = midnight.difference(now) + const Duration(seconds: 1);
    _timer = Timer(
      wait.isNegative ? const Duration(seconds: 1) : wait,
      _refresh,
    );
  }

  void _refresh() {
    final today = _now();
    if (today != _today) setState(() => _today = today);
    _schedule();
  }

  @override
  Widget build(BuildContext context) =>
      _TodayValue(today: _today, child: widget.child);
}

class _TodayValue extends InheritedWidget {
  const _TodayValue({required this.today, required super.child});
  final DateTime today;
  @override
  bool updateShouldNotify(_TodayValue oldWidget) => oldWidget.today != today;
}

/// The four working surfaces plus the index, with state kept across switches.
class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.settings, required this.repository});
  final AppSettings settings;
  final CalendarRepository repository;
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late int _tab = AppSettings.firstScreens
      .indexOf(widget.settings.firstScreen)
      .clamp(0, 3);

  static const _analyticsScreens = [
    'home',
    'weeks',
    'calendar',
    'tools',
    'more',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => TelemetryService.instance.logScreenView(_analyticsScreens[_tab]),
    );
  }

  void _selectTab(int index) {
    setState(() => _tab = index);
    TelemetryService.instance.logScreenView(_analyticsScreens[index]);
  }

  @override
  Widget build(BuildContext context) {
    final s = context.s;
    final today = TodayScope.of(context);
    final titles = [s.home, s.weeks, s.calendar, s.tools, s.more];
    return Scaffold(
      appBar: AppBar(
        title: _tab == 0 ? const BrandLogoTitle() : Text(titles[_tab]),
        actions: [
          IconButton(
            tooltip: s.settings,
            onPressed: () => Navigator.pushNamed(context, '/asetukset'),
            icon: const Icon(Icons.tune_rounded),
          ),
        ],
      ),
      body: IndexedStack(
        index: _tab,
        children: [
          HomeScreen(repository: widget.repository, today: today),
          YearWeeksScreen(
            repository: widget.repository,
            today: today,
            year: isoYear(today),
            embedded: true,
          ),
          MonthScreen(
            repository: widget.repository,
            today: today,
            year: today.year,
            month: today.month,
            embedded: true,
          ),
          ToolsScreen(
            repository: widget.repository,
            today: today,
            embedded: true,
          ),
          MoreScreen(repository: widget.repository, today: today),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: _selectTab,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.today_outlined),
            selectedIcon: const Icon(Icons.today),
            label: s.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.view_week_outlined),
            selectedIcon: const Icon(Icons.view_week),
            label: s.weeks,
          ),
          NavigationDestination(
            icon: const Icon(Icons.calendar_month_outlined),
            selectedIcon: const Icon(Icons.calendar_month),
            label: s.calendar,
          ),
          NavigationDestination(
            icon: const Icon(Icons.calculate_outlined),
            selectedIcon: const Icon(Icons.calculate),
            label: s.tools,
          ),
          NavigationDestination(
            icon: const Icon(Icons.more_horiz),
            label: s.more,
          ),
        ],
      ),
    );
  }
}

class BrandLogoTitle extends StatelessWidget {
  const BrandLogoTitle({super.key});
  @override
  Widget build(BuildContext context) => const BrandLogo();
}
