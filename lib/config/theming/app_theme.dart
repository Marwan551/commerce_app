import 'package:flutter/material.dart';
import '../../core/Utils/Constants/color/app_colors.dart';
import '../../core/Utils/Constants/strings/app_strings.dart';
import 'app_theme_components.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: AppStrings.fontFamily,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.black1A1A1A,
      primary: AppColors.black1A1A1A,
      secondary: AppColors.greyB3B3B3,
    ),
    textTheme: AppThemeComponents.textTheme,
    inputDecorationTheme: AppThemeComponents.inputDecorationTheme,
    elevatedButtonTheme: AppThemeComponents.elevatedButtonTheme,
  );
}
