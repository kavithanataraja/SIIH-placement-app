import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kcg_placement_app/main.dart'; // corrected package name

void main() {
  testWidgets('Dashboard loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const SiihApp());
    await tester.pumpAndSettle();

    expect(find.text('Placement Dashboard'), findsOneWidget);
    expect(find.byType(SizedBox), findsWidgets);
    expect(find.byType(IconButton), findsWidgets);
  });
}
