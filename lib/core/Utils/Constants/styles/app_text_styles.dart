import 'package:flutter/material.dart';
import '../strings/app_strings.dart';
import '../color/app_colors.dart';

class AppTextStyles {

  AppTextStyles._();

  static const TextStyle regular16 = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.black1A1A1A,
  );

  static const TextStyle medium18 = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.black1A1A1A,
  );

  static const TextStyle bold24 = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.black1A1A1A,
  );
}
