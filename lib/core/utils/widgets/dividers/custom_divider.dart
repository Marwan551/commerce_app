import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';

class CustomDivider extends StatelessWidget {
  final double height;
  final double thickness;
  final Color color;
  final double? indent;
  final double? endIndent;

  const CustomDivider({
    super.key,
    this.height = 0,
    this.thickness = 0,
    this.color = AppColors.greyFFE6E6E6,
    this.indent,
    this.endIndent,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: thickness,
      color: color,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
