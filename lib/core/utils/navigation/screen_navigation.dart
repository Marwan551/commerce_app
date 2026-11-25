import 'package:commerce_app/config/routing/app_router.dart';
import 'package:commerce_app/config/routing/routes_enums.dart';
import 'package:commerce_app/core/controllers/navigation_cubit/navigation_cubit.dart';
import 'package:commerce_app/features/home/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenNavigation {
  ScreenNavigation._();

  static void navigateToHome(BuildContext context) {
    context.read<NavigationCubit>().navigateToHome();
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

  static void navigateToProductDetails(ProductData product) {
    AppRouter.router.push(AppRoutes.productDetails.path, extra: product);
  }

  static void navigateToReviews(ProductData product) {
    AppRouter.router.push(AppRoutes.reviews.path, extra: product);
  }

  static void navigateToCart(BuildContext context) {
    context.read<NavigationCubit>().navigateToCart();
    AppRouter.router.go(AppRoutes.home.path);
  }
  
  static void navigateToSaved(BuildContext context) {
    context.read<NavigationCubit>().navigateToSaved();
    AppRouter.router.go(AppRoutes.home.path);
  }
}
