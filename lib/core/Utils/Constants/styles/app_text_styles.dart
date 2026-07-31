import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/constants/strings/app_strings.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();
  static final AppTextStyles _instance = AppTextStyles._();
  factory AppTextStyles() => _instance;

  // Regular (w400)
  static const TextStyle regular12 = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.black1A1A1A,
  );

  static const TextStyle regular14 = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.black1A1A1A,
  );

  static const TextStyle regular16 = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.black1A1A1A,
  );

  static const TextStyle regular18 = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.black1A1A1A,
  );

  // Medium (w500)
  static const TextStyle medium12 = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.black1A1A1A,
  );

  static const TextStyle medium14 = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.black1A1A1A,
  );

  static const TextStyle medium16 = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.black1A1A1A,
  );

  static const TextStyle medium18 = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.black1A1A1A,
  );

  static const TextStyle medium20 = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.black1A1A1A,
  );

  // Bold (w700)
  static const TextStyle bold14 = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.black1A1A1A,
  );

  static const TextStyle bold16 = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.black1A1A1A,
  );

  static const TextStyle bold18 = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.black1A1A1A,
  );

  static const TextStyle bold20 = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.black1A1A1A,
  );

  static const TextStyle bold24 = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.black1A1A1A,
  );

  static const TextStyle bold32 = TextStyle(
    fontFamily: AppStrings.fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.black1A1A1A,
  );
}
