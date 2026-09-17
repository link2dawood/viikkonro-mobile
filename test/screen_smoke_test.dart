import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viikkonro/app.dart';
import 'package:viikkonro/core/data/calendar_repository.dart';
import 'package:viikkonro/core/settings/app_settings.dart';
import 'package:viikkonro/l10n/app_localizations.dart';

/// Every route, rendered at a small phone width and again at the 200% font
/// scale FP-A01 requires, asserting that nothing overflows or throws.
void main() {
  final today = DateTime(2026, 9, 11, 10, 30);

  const routes = [
    '/',
    '/viikko-37-2026',
    '/viikko-53-2026',
    '/viikonpaiva?paiva=2026-12-31',
    '/vuosi-2026',
    '/kalenteri-2026',
    '/kuukausi-1-2026',
    '/kuukausi-12-2026',
    '/pyhapaivat-2026',
    '/liputuspaivat-2026',
    '/koululomat-2026',
    '/paivamaara-viikoksi',
    '/viikko-paivamaaraksi',
    '/paivien-erotus',
    '/tyopaivalaskuri',
    '/asetukset',
    '/ukk',
  ];

  late CalendarRepository repository;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    PackageInfo.setMockInitialValues(
      appName: 'Viikkonro',
      packageName: 'fi.viikkonro.app',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: '',
    );
    repository = await CalendarRepository.load();
  });

  Future<void> sweep(
    WidgetTester tester, {
    required Size size,
    required double textScale,
    required String language,
  }) async {
    // Layout errors reach the test as a bare exception, which does not say
    // which widget overflowed. Recording the details keeps the failure useful.
    final recorded = <FlutterErrorDetails>[];
    final previous = FlutterError.onError;
    FlutterError.onError = (details) {
      recorded.add(details);
      previous?.call(details);
    };
    addTearDown(() => FlutterError.onError = previous);
    void check(String label) {
      final error = tester.takeException();
      final report = recorded
          .map((d) => d.toDiagnosticsNode().toStringDeep())
          .join('\n');
      recorded.clear();
      if (error == null) return;
      // Put the handler back before failing: flutter_test asserts that a test
      // which overrode it restored it before the first expect() failure.
      FlutterError.onError = previous;
      fail('$label, $language, ${textScale}x\n$report');
    }

    await tester.binding.setSurfaceSize(size);
    addTearDown(() => tester.binding.setSurfaceSize(null));
    SharedPreferences.setMockInitialValues({'language': language});
    final settings = AppSettings(await SharedPreferences.getInstance());
    await tester.pumpWidget(
      MediaQuery(
        data: MediaQueryData(
          size: size,
          textScaler: TextScaler.linear(textScale),
        ),
        child: ViikkonroApp(
          settings: settings,
          repository: repository,
          clock: () => today,
        ),
      ),
    );
    await tester.pumpAndSettle();
    check('home');

    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    for (final route in routes) {
      navigator.pushNamed(route);
      await tester.pumpAndSettle();
      check(route);
      navigator.pop();
      await tester.pumpAndSettle();
    }

    // Each bottom-navigation tab, which the routes above never mount.
    for (var tab = 1; tab < 5; tab++) {
      await tester.tap(find.byType(NavigationDestination).at(tab));
      await tester.pumpAndSettle();
      check('tab $tab');
    }
    await tester.pumpWidget(const SizedBox.shrink());
  }

  testWidgets('every route renders on a small phone in Finnish', (
    tester,
  ) async {
    await sweep(
      tester,
      size: const Size(360, 740),
      textScale: 1,
      language: 'fi',
    );
  });

  testWidgets('every route renders on a small phone in English', (
    tester,
  ) async {
    await sweep(
      tester,
      size: const Size(360, 740),
      textScale: 1,
      language: 'en',
    );
  });

  testWidgets('every route survives a 200 percent font scale', (tester) async {
    await sweep(
      tester,
      size: const Size(360, 740),
      textScale: 2,
      language: 'fi',
    );
  });

  testWidgets('every route renders in landscape', (tester) async {
    await sweep(
      tester,
      size: const Size(740, 360),
      textScale: 1,
      language: 'fi',
    );
  });

  // A long translation is the usual cause of a broken layout, so every shipped
  // language gets the same phone-width sweep rather than a spot check.
  for (final locale in AppLocalizations.supportedLocales) {
    testWidgets('every route renders in ${locale.languageCode}', (
      tester,
    ) async {
      await sweep(
        tester,
        size: const Size(360, 740),
        textScale: 1,
        language: locale.languageCode,
      );
    });
  }
}
