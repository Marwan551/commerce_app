import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/app_date_formatter.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/features/reviews/models/review_model.dart';

class ReviewItemWidget extends StatelessWidget {
  final ReviewData review;
  const ReviewItemWidget({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(5, (index) {
              final isFilled = index < (review.ratings ?? 0).round();
              return Icon(
                isFilled ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 20,
              );
            }),
          ),
          const SizedBox(height: 12),
          Text(
            review.comment ?? '',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.grey707070,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Flexible(
                child: Text(
                  review.user?.name ?? 'Anonymous',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.black1A1A1A,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.circle, size: 4, color: AppColors.greyB3B3B3),
              const SizedBox(width: 8),
              Text(
                AppDateFormatter.formatReviewDate(review.createdAt ?? ''),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.greyB3B3B3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(height: 1, color: AppColors.greyFFE6E6E6),
        ],
      ),
    );
  }
}
