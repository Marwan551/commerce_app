import 'package:commerce_app/core/utils/navigation/screen_navigation.dart';
import 'package:flutter/material.dart';

class SplashNavigation {
  SplashNavigation._();

  static void navigateToLogin() {
    ScreenNavigation.navigateToLogin();
  }

  static void navigateToHome(BuildContext context) {
    ScreenNavigation.navigateToHome(context);
  }
}
