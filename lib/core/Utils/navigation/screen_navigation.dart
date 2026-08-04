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

  static void navigateToForgotPassword() {
    AppRouter.router.push(AppRoutes.forgotPassword.path);
  }

  static void navigateToVerifyCode({required String email}) {
    AppRouter.router.push(AppRoutes.verifyCode.path, extra: email);
  }

  static void navigateToResetPassword({required String email}) {
    AppRouter.router.push(AppRoutes.resetPassword.path, extra: email);
  }
}
