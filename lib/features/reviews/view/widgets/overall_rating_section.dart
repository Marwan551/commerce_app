import 'package:commerce_app/core/utils/constants/strings/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';

class OverallRatingSection extends StatelessWidget {
  final num averageRating;
  final int totalReviews;

  const OverallRatingSection({
    super.key,
    required this.averageRating,
    required this.totalReviews,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          averageRating.toStringAsFixed(1),
          style: theme.textTheme.displayLarge?.copyWith(
            fontSize: 80,
            fontWeight: FontWeight.w700,
            color: AppColors.black1A1A1A,
            height: 1.1,
          ),
        ),
        const SizedBox(width: 20),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: List.generate(5, (index) {
                  final isFilled = index < averageRating.round();
                  return Icon(
                    isFilled ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 28,
                  );
                }),
              ),
              const SizedBox(height: 6),
              Text(
                '$totalReviews ${AppStrings.ratings.tr()}',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.grey707070,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
