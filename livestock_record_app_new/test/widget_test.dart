import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:livestock_record_app_new/main.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const PetnestApp());

    // Example: Check that the splash screen text exists
    expect(find.text('Petnest'), findsOneWidget);
  });
}
