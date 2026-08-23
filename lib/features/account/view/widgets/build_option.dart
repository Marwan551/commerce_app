import 'package:commerce_app/core/utils/constants/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';

Widget buildOption(
    BuildContext context, {
      required SvgGenImage svg,
      required String title,
      Widget? trailing,
      Color? titleColor,
      required VoidCallback onTap,
    }) {
  return ListTile(
    leading: svg.svg(width: 24, height: 24),
    title: Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: titleColor ?? AppColors.black1A1A1A,
        fontWeight: FontWeight.w600,
      ),
    ),
    trailing: trailing,
    onTap: onTap,
  );
}
