import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hr_leave_management/core/storage/secure_storage_service.dart';
import 'package:hr_leave_management/data/repositories/auth_repository.dart';
import 'package:hr_leave_management/data/repositories/teams_repository.dart';
import 'package:hr_leave_management/features/auth/controllers/auth_controller.dart';
import 'package:hr_leave_management/features/auth/views/login_view.dart';

void main() {
  testWidgets('login screen renders the sign-in form', (
    WidgetTester tester,
  ) async {
    Get.put(
      AuthController(
        authRepository: AuthRepository(dio: Dio()),
        teamsRepository: TeamsRepository(dio: Dio()),
        secureStorageService: SecureStorageService(),
      ),
    );

    await tester.pumpWidget(GetMaterialApp(home: const LoginView()));

    expect(find.text('HR Leave Management'), findsWidgets);
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Log in'), findsOneWidget);
  });
}
