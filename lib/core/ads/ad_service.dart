import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Owns the Google UMP consent flow and exposes ads only after the SDK confirms
/// that requests are allowed. The current AdMob account is Android-only.
class AdService extends ChangeNotifier {
  AdService._();

  static final instance = AdService._();
  static const _channel = MethodChannel('fi.viikkonro.app/ads');

  bool _started = false;
  bool _sdkInitialized = false;
  bool _canRequestAds = false;
  bool _privacyOptionsRequired = false;
  String? _bannerAdUnitId;

  bool get canRequestAds => _canRequestAds;
  bool get privacyOptionsRequired => _privacyOptionsRequired;
  String? get bannerAdUnitId => _bannerAdUnitId;

  Future<void> initialize() async {
    if (_started || defaultTargetPlatform != TargetPlatform.android) return;
    _started = true;

    try {
      final configuration = await _channel.invokeMapMethod<String, dynamic>(
        'configuration',
      );
      final id = configuration?['bannerAdUnitId'] as String?;
      if (id == null || id.isEmpty) return;
      _bannerAdUnitId = id;
    } on MissingPluginException {
      // Flutter unit/widget tests have no Android host and must stay offline.
      return;
    } on PlatformException catch (error) {
      debugPrint('AdMob configuration unavailable: $error');
      return;
    }

    try {
      ConsentInformation.instance.requestConsentInfoUpdate(
        ConsentRequestParameters(),
        () => unawaited(_gatherConsent()),
        (error) => unawaited(_handleConsentUpdateFailure(error)),
      );
    } on Object catch (error, stack) {
      _logFailure('consent update', error, stack);
    }
  }

  Future<void> showPrivacyOptions() async {
    try {
      await ConsentForm.showPrivacyOptionsForm(
        (error) => unawaited(_finishConsent(error, 'privacy options')),
      );
    } on Object catch (error, stack) {
      _logFailure('privacy options', error, stack);
    }
  }

  Future<void> _gatherConsent() async {
    try {
      await _refreshPrivacyOptionsRequirement();
      // A previous valid decision may already allow requests while a form is
      // being checked. The guard prevents duplicate SDK initialization.
      await _startAdsIfAllowed();
      await ConsentForm.loadAndShowConsentFormIfRequired(
        (error) => unawaited(_finishConsent(error, 'consent form')),
      );
    } on Object catch (error, stack) {
      _logFailure('consent form', error, stack);
    }
  }

  Future<void> _handleConsentUpdateFailure(FormError error) async {
    debugPrint('AdMob consent update failed: ${error.message}');
    // UMP can still permit ads using a valid decision from an earlier run.
    try {
      await _startAdsIfAllowed();
    } on Object catch (fallbackError, stack) {
      _logFailure('cached consent', fallbackError, stack);
    }
  }

  Future<void> _finishConsent(FormError? error, String source) async {
    if (error != null) debugPrint('AdMob $source failed: ${error.message}');
    try {
      await _refreshPrivacyOptionsRequirement();
      await _startAdsIfAllowed();
    } on Object catch (finishError, stack) {
      _logFailure(source, finishError, stack);
    }
  }

  Future<void> _refreshPrivacyOptionsRequirement() async {
    final required =
        await ConsentInformation.instance
            .getPrivacyOptionsRequirementStatus() ==
        PrivacyOptionsRequirementStatus.required;
    if (required == _privacyOptionsRequired) return;
    _privacyOptionsRequired = required;
    notifyListeners();
  }

  Future<void> _startAdsIfAllowed() async {
    if (_bannerAdUnitId == null ||
        !await ConsentInformation.instance.canRequestAds()) {
      return;
    }
    if (!_sdkInitialized) {
      _sdkInitialized = true;
      await MobileAds.instance.initialize();
    }
    if (_canRequestAds) return;
    _canRequestAds = true;
    notifyListeners();
  }

  void _logFailure(String source, Object error, StackTrace stack) {
    debugPrint('AdMob $source unavailable: $error');
    debugPrintStack(stackTrace: stack);
  }
}
