import '../../../../config/routing/app_router.dart';
import '../../../../config/routing/routes_enums.dart';

class ScreenNavigation {

  ScreenNavigation._();

  static void navigateToHome() {
    AppRouter.router.go(AppRoutes.home.path);
  }

  static void navigateToLogin() {
    AppRouter.router.go(AppRoutes.login.path);
  }
}
