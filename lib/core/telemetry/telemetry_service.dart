import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Initializes the two approved telemetry products without making application
/// startup depend on network access or local Firebase project files.
class TelemetryService {
  TelemetryService._();

  static final instance = TelemetryService._();

  bool _initialized = false;
  bool _collectionEnabled = false;
  FirebaseAnalyticsObserver? _observer;

  bool get initialized => _initialized;
  bool get collectionEnabled => _collectionEnabled;
  List<NavigatorObserver> get navigatorObservers => [?_observer];

  Future<void> initialize() async {
    if (_initialized ||
        (defaultTargetPlatform != TargetPlatform.android &&
            defaultTargetPlatform != TargetPlatform.iOS)) {
      return;
    }

    try {
      await Firebase.initializeApp();
      _initialized = true;

      // Debug installations must not pollute production reports. Developers
      // can opt in while validating with --dart-define.
      const debugOptIn = bool.fromEnvironment('ENABLE_FIREBASE_TELEMETRY');
      _collectionEnabled = kReleaseMode || debugOptIn;
      await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(
        _collectionEnabled,
      );
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
        _collectionEnabled,
      );

      if (!_collectionEnabled) return;
      _observer = FirebaseAnalyticsObserver(
        analytics: FirebaseAnalytics.instance,
      );
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    } on MissingPluginException {
      // Unit/widget tests have no native Firebase host.
    } on PlatformException catch (error) {
      debugPrint('Firebase telemetry unavailable: ${error.code}');
    } on FirebaseException catch (error, stack) {
      debugPrint('Firebase telemetry unavailable: ${error.code}');
      debugPrintStack(stackTrace: stack);
    } on Object catch (error, stack) {
      debugPrint('Firebase telemetry unavailable: $error');
      debugPrintStack(stackTrace: stack);
    }
  }

  Future<void> logScreenView(String screenName) async {
    if (!_collectionEnabled) return;
    await FirebaseAnalytics.instance.logScreenView(screenName: screenName);
  }
}
