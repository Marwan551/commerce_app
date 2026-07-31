import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_button.dart';
import 'package:commerce_app/features/auth/view/navigation/screen_navigation.dart';
import 'package:commerce_app/features/splash/views/screens/splash_screen.dart';
import 'package:commerce_app/features/auth/view/screens/login/login_screen.dart';
import 'package:commerce_app/features/auth/view/screens/register/register_screen.dart';
import 'package:commerce_app/config/routing/routes_enums.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash.path,
    routes: [
      GoRoute(
        path: AppRoutes.splash.path,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login.path,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register.path,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgetPassword.path,
        builder: (context, state) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Forget Password Screen'),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                    text: 'Back to Login',
                    onPressed: () => ScreenNavigation.navigateToLogin(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.home.path,
        builder: (context, state) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Home Screen'),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                    text: 'Logout & Return to Login',
                    onPressed: () => ScreenNavigation.navigateToLogin(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
