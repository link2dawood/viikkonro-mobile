import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viikkonro/app.dart';
import 'package:viikkonro/core/data/calendar_repository.dart';
import 'package:viikkonro/core/date/iso_week.dart';
import 'package:viikkonro/core/settings/app_settings.dart';
import 'package:viikkonro/shared/components.dart';

void main() {
  // 2026-09-11 is a Friday in ISO week 37 of a 53-week year, which makes it a
  // useful fixed "today" for rollover, week-count and boundary assertions.
  final fixedToday = DateTime(2026, 9, 11, 10, 30);

  late CalendarRepository repository;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    repository = await CalendarRepository.load();
  });

  Future<AppSettings> newSettings() async {
    SharedPreferences.setMockInitialValues({'language': 'fi'});
    return AppSettings(await SharedPreferences.getInstance());
  }

  /// Pumps the app, runs [body], then unmounts so the midnight timer is
  /// cancelled before the test framework checks for pending timers.
  Future<void> runApp(
    WidgetTester tester,
    Future<void> Function() body, {
    DateTime? now,
  }) async {
    var clock = now ?? fixedToday;
    await tester.pumpWidget(
      ViikkonroApp(
        settings: await newSettings(),
        repository: repository,
        clock: () => clock,
      ),
    );
    await tester.pumpAndSettle();
    await body();
    await tester.pumpWidget(const SizedBox.shrink());
  }

  testWidgets('the app opens on the home screen showing the current week', (
    tester,
  ) async {
    await runApp(tester, () async {
      expect(find.text('${isoWeek(fixedToday)}'), findsWidgets);
      expect(find.text('Etusivu'), findsWidgets);
    });
  });

  testWidgets('a week route lists all seven days of that week', (tester) async {
    await runApp(tester, () async {
      final navigator = tester.state<NavigatorState>(find.byType(Navigator));
      navigator.pushNamed('/viikko-37-2026');
      await tester.pumpAndSettle();
      expect(find.text('Viikko 37/2026'), findsWidgets);
      for (final day in ['ma', 'ti', 'ke', 'to', 'pe', 'la', 'su']) {
        expect(find.text(day), findsWidgets, reason: day);
      }
      // 2026-09-11 is inside week 37, so it renders with its Finnish long form.
      expect(find.text('11. syyskuuta 2026'), findsOneWidget);
    });
  });

  testWidgets('an unrecognised path opens the home screen, not a 404', (
    tester,
  ) async {
    await runApp(tester, () async {
      final navigator = tester.state<NavigatorState>(find.byType(Navigator));
      navigator.pushNamed('/ei-tallaista-sivua');
      await tester.pumpAndSettle();
      expect(find.byType(AppShell), findsWidgets);
      expect(find.text('Sivua ei löytynyt'), findsNothing);
    });
  });

  testWidgets('the year grid renders every week of a 53-week year', (
    tester,
  ) async {
    await runApp(tester, () async {
      final navigator = tester.state<NavigatorState>(find.byType(Navigator));
      navigator.pushNamed('/vuosi-2026');
      await tester.pumpAndSettle();
      expect(weeksInIsoYear(2026), 53);
      final list = tester.widget<ListView>(find.byType(ListView).first);
      expect(
        (list.childrenDelegate as SliverChildBuilderDelegate).childCount,
        53,
      );
    });
  });

  testWidgets('midnight rollover moves the app to the new day unprompted', (
    tester,
  ) async {
    var clock = DateTime(2026, 12, 31, 23, 59, 30);
    final settings = await newSettings();
    await tester.pumpWidget(
      ViikkonroApp(
        settings: settings,
        repository: repository,
        clock: () => clock,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('31. joulukuuta 2026'), findsWidgets);

    clock = DateTime(2027, 1, 1, 0, 0, 5);
    await tester.pump(const Duration(seconds: 31));
    await tester.pumpAndSettle();
    // Crossing into an ISO year whose week 53 ran to 3 January 2027.
    expect(find.text('1. tammikuuta 2027'), findsWidgets);
    expect(isoWeek(clock), 53);
    expect(isoYear(clock), 2026);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('page content stays inside side and bottom system insets', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(padding: EdgeInsets.fromLTRB(24, 0, 18, 32)),
          child: PageBody(
            children: [SizedBox(key: Key('inset-content'), height: 20)],
          ),
        ),
      ),
    );

    final safeArea = tester.widget<SafeArea>(
      find.descendant(
        of: find.byType(PageBody),
        matching: find.byType(SafeArea),
      ),
    );
    expect(safeArea.top, isFalse);
    expect(safeArea.left, isTrue);
    expect(safeArea.right, isTrue);
    expect(safeArea.bottom, isTrue);
    // 24 logical pixels of system inset plus PageBody's 20-pixel margin.
    expect(tester.getTopLeft(find.byKey(const Key('inset-content'))).dx, 44);
  });
}
