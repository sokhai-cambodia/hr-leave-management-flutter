import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/bindings/initial_binding.dart';
import 'app/theme/app_theme.dart';
import 'features/auth/views/login_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const HrLeaveManagementApp());
}

class HrLeaveManagementApp extends StatelessWidget {
  const HrLeaveManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HR Leave Management',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      initialBinding: InitialBinding(),
      home: const LoginView(),
    );
  }
}
