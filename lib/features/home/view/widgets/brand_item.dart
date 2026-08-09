import 'package:flutter/material.dart';
import 'package:commerce_app/features/home/models/brand_model.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';

class BrandItem extends StatelessWidget {
  final BrandData brand;
  const BrandItem({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.greyB3B3B3),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          brand.image ?? '',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
