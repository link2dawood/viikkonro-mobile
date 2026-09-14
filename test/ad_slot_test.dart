import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:viikkonro/core/ads/ad_slot.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('an ad slot stays empty before consent permits ads', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: AdSlot(enabled: true))),
    );
    expect(find.byType(AdWidget), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
