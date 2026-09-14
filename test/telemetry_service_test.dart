import 'package:flutter_test/flutter_test.dart';
import 'package:viikkonro/core/telemetry/telemetry_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('telemetry stays inactive without a native Firebase host', () async {
    await TelemetryService.instance.initialize();

    expect(TelemetryService.instance.initialized, isFalse);
    expect(TelemetryService.instance.collectionEnabled, isFalse);
    expect(TelemetryService.instance.navigatorObservers, isEmpty);
  });
}
