import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/bindings/initial_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // .env is optional: absent on a fresh clone until `cp .env.example .env`,
  // or when relying purely on --dart-define=API_BASE_URL (see Env).
  await dotenv.load(isOptional: true);
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
      initialRoute: Routes.splash,
      getPages: AppPages.pages,
    );
  }
}
