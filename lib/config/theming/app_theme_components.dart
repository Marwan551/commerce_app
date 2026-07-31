import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/core/utils/constants/styles/app_text_styles.dart';

class AppThemeComponents {
  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.whiteFFFFFF,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.greyB3B3B3),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.black1A1A1A),
    ),
  );

  static ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.black1A1A1A,
      foregroundColor: AppColors.whiteFFFFFF,
      textStyle: AppTextStyles.medium18,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );

  static TextButtonThemeData textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.black1A1A1A,
      textStyle: AppTextStyles.medium18,
    ),
  );

  static TextTheme textTheme = const TextTheme(
    displayLarge: AppTextStyles.bold32,
    displayMedium: AppTextStyles.bold24,
    displaySmall: AppTextStyles.bold20,
    headlineLarge: AppTextStyles.bold20,
    headlineMedium: AppTextStyles.bold18,
    headlineSmall: AppTextStyles.bold16,
    titleLarge: AppTextStyles.medium18,
    titleMedium: AppTextStyles.medium16,
    titleSmall: AppTextStyles.medium14,
    bodyLarge: AppTextStyles.regular16,
    bodyMedium: AppTextStyles.regular14,
    bodySmall: AppTextStyles.regular12,
    labelLarge: AppTextStyles.medium14,
    labelMedium: AppTextStyles.medium12,
    labelSmall: AppTextStyles.regular12,
  );
}
