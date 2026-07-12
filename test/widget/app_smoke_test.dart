import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hr_leave_management/main.dart';

void main() {
  testWidgets('app launches to the login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const HrLeaveManagementApp());

    expect(find.text('HR Leave Management'), findsWidgets);
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Log in'), findsOneWidget);
  });
}
