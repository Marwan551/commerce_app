import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:commerce_app/features/home/models/product_model.dart';

class ProductInfoSection extends StatelessWidget {
  final ProductData product;
  final VoidCallback onReviewsTap;

  const ProductInfoSection({
    super.key,
    required this.product,
    required this.onReviewsTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title ?? 'N/A',
            style: theme.textTheme.displayMedium,
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: onReviewsTap,
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/imgs/star_gold.svg',
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  '${product.ratingsAverage?.toStringAsFixed(1) ?? "0.0"}/5',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),

                ),
                const SizedBox(width: 8),
                Text(
                  '(${product.ratingsQuantity ?? 0} reviews)',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: AppColors.grey707070,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            product.description ?? '',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.secondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
