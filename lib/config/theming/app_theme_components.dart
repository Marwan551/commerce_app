import 'package:flutter/material.dart';
import '../../core/Utils/Constants/color/app_colors.dart';
import '../../core/Utils/Constants/styles/app_text_styles.dart';

class AppThemeComponents {
  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
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
      foregroundColor: Colors.white,
      textStyle: AppTextStyles.medium18,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );

  static TextTheme textTheme = const TextTheme(
    displayLarge: AppTextStyles.bold24,
    bodyLarge: AppTextStyles.regular16,
    bodyMedium: AppTextStyles.regular16,
  );
}
