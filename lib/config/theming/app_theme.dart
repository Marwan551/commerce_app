import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/core/utils/constants/strings/app_strings.dart';
import 'package:commerce_app/config/theming/app_theme_components.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: AppStrings.fontFamily,
    scaffoldBackgroundColor: AppColors.whiteFFFFFF,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.black1A1A1A,
      primary: AppColors.black1A1A1A,
      secondary: AppColors.greyB3B3B3,
    ),
    textTheme: AppThemeComponents.textTheme,
    inputDecorationTheme: AppThemeComponents.inputDecorationTheme,
    elevatedButtonTheme: AppThemeComponents.elevatedButtonTheme,
    textButtonTheme: AppThemeComponents.textButtonTheme,
  );
}
