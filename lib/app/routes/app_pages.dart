import 'package:get/get.dart';

import '../../features/auth/views/login_view.dart';
import '../../features/auth/views/splash_view.dart';
import '../../features/auth/views/welcome_view.dart';
import 'app_routes.dart';
import 'auth_middleware.dart';

abstract class AppPages {
  AppPages._();

  static final pages = [
    GetPage(name: Routes.splash, page: () => const SplashView()),
    GetPage(name: Routes.login, page: () => const LoginView()),
    GetPage(
      name: Routes.welcome,
      page: () => const WelcomeView(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
