import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                spacing: 5,
                children: List.generate(5, (index) {
                  final isFilled = index < averageRating.round();
                  return Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: SvgPicture.asset(
                      isFilled
                          ? 'assets/images/imgs/star_gold.svg'
                          : 'assets/images/imgs/star_grey.svg',
                      width: 28,
                      height: 28,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 6),
              Text(
                '$totalReviews Ratings',
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
