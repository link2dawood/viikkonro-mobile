import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'core/ads/ad_service.dart';
import 'core/data/calendar_repository.dart';
import 'core/settings/app_settings.dart';
import 'core/telemetry/telemetry_service.dart';
import 'core/theme/brand_theme.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase must start before UMP so UMP can update Google consent mode.
  // Missing local project configuration is non-fatal for development clones.
  await TelemetryService.instance.initialize();
  // FP-G04: Finnish date symbols must exist before anything renders, in release
  // builds as well as debug. FP-D01: the bundled snapshot is the only source
  // needed to start, so a first launch in airplane mode reaches every screen.
  await initializeDateFormatting('fi');
  final preferences = await SharedPreferences.getInstance();
  try {
    final repository = await CalendarRepository.load();
    runApp(
      ViikkonroApp(settings: AppSettings(preferences), repository: repository),
    );
    // UMP may need an Activity to present its consent form, so begin only after
    // the first frame. App startup and every screen remain independent of ads.
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => unawaited(AdService.instance.initialize()),
    );
  } on Object catch (error, stack) {
    debugPrint('Calendar data failed to load: $error\n$stack');
    runApp(const _StartupFailure());
  }
}

/// Bundled data that will not parse is a build defect, not a runtime condition
/// the user can fix, so this says so plainly rather than pretending to retry.
class _StartupFailure extends StatelessWidget {
  const _StartupFailure();
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    theme: Brand.theme(Brightness.light),
    darkTheme: Brand.theme(Brightness.dark),
    home: Builder(
      builder: (context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Text(
                AppLocalizations.of(context).loadingError,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
