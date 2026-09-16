import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viikkonro/app.dart';
import 'package:viikkonro/core/data/calendar_repository.dart';
import 'package:viikkonro/core/settings/app_settings.dart';

/// Store-listing screenshots rendered from the real app UI.
///
/// Regenerate them with:
///
///   flutter test --update-goldens test/store_screenshot_test.dart
///
/// The five images in each device set deliberately use [AppShell]. That keeps
/// the same bottom navigation visible on every screenshot and only changes the
/// selected destination.
void main() {
  const screenshotKey = ValueKey('store-screenshot');
  final today = DateTime(2026, 9, 15, 12);

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
    await _loadFonts();
  });

  for (final device in const [
    _StoreDevice(
      directory: 'phone',
      logicalSize: Size(360, 640),
      outputSize: Size(1080, 1920),
    ),
    _StoreDevice(
      directory: 'tablet',
      logicalSize: Size(720, 1280),
      outputSize: Size(1440, 2560),
    ),
  ]) {
    testWidgets('generate ${device.directory} store screenshots', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(device.outputSize);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      SharedPreferences.setMockInitialValues({
        'language': 'fi',
        'theme': ThemeMode.light.name,
        'firstScreen': 'home',
      });
      final settings = AppSettings(await SharedPreferences.getInstance());

      await tester.pumpWidget(
        RepaintBoundary(
          key: screenshotKey,
          child: FittedBox(
            fit: BoxFit.fill,
            child: SizedBox.fromSize(
              size: device.logicalSize,
              child: MediaQuery(
                data: MediaQueryData(size: device.logicalSize),
                child: ViikkonroApp(
                  settings: settings,
                  repository: repository,
                  clock: () => today,
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      for (var tab = 0; tab < _tabNames.length; tab++) {
        if (tab > 0) {
          await tester.tap(find.byType(NavigationDestination).at(tab));
          await tester.pumpAndSettle();
        }
        await expectLater(
          find.byKey(screenshotKey),
          matchesGoldenFile(
            '../store-assets/screenshots/${device.directory}/'
            '${tab + 1}-${_tabNames[tab]}.png',
          ),
        );
      }
    });
  }
}

Future<void> _loadFonts() async {
  final icons = FontLoader('MaterialIcons');
  icons.addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
  await icons.load();

  for (final entry in const {
    'Inter': ['400', '500', '600', '700', '800'],
    'Bricolage': ['400', '500', '600', '700', '800'],
    'PlexMono': ['400', '500', '600', '700'],
  }.entries) {
    final loader = FontLoader(entry.key);
    for (final weight in entry.value) {
      loader.addFont(rootBundle.load('assets/fonts/${entry.key}-$weight.ttf'));
    }
    await loader.load();
  }
}

const _tabNames = ['home', 'weeks', 'calendar', 'tools', 'more'];

class _StoreDevice {
  const _StoreDevice({
    required this.directory,
    required this.logicalSize,
    required this.outputSize,
  });

  final String directory;
  final Size logicalSize;
  final Size outputSize;
}
