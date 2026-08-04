import 'package:commerce_app/core/utils/navigation/screen_navigation.dart';

class AuthNavigation {
  AuthNavigation._();

  static void navigateToLogin() {
    ScreenNavigation.navigateToLogin();
  }

  static void navigateToRegister() {
    ScreenNavigation.navigateToRegister();
  }

  static void navigateToForgotPassword() {
    ScreenNavigation.navigateToForgotPassword();
  }

  static void navigateToVerifyCode({required String email}) {
    ScreenNavigation.navigateToVerifyCode(email: email);
  }

  static void navigateToResetPassword({required String email}) {
    ScreenNavigation.navigateToResetPassword(email: email);
  }
}
