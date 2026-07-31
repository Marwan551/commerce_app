import 'package:commerce_app/config/routing/app_router.dart';
import 'package:commerce_app/config/routing/routes_enums.dart';

class ScreenNavigation {
  ScreenNavigation._();
  static final ScreenNavigation _instance = ScreenNavigation._();
  factory ScreenNavigation() => _instance;

  static void navigateToHome() {
    AppRouter.router.go(AppRoutes.home.path);
  }

  static void navigateToLogin() {
    AppRouter.router.go(AppRoutes.login.path);
  }

  static void navigateToRegister() {
    AppRouter.router.go(AppRoutes.register.path);
  }

  static void navigateToForgetPassword() {
    AppRouter.router.go(AppRoutes.forgetPassword.path);
  }
}
