import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';

class WishListShimmer extends StatelessWidget {
  const WishListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Shimmer.fromColors(
                baseColor: AppColors.greyB3B3B3.withAlpha(100),
                highlightColor: AppColors.greyB3B3B3.withAlpha(50),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteFFFFFF,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Shimmer.fromColors(
              baseColor: AppColors.greyB3B3B3.withAlpha(100),
              highlightColor: AppColors.greyB3B3B3.withAlpha(50),
              child: Container(
                height: 20,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.whiteFFFFFF,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Shimmer.fromColors(
              baseColor: AppColors.greyB3B3B3.withAlpha(100),
              highlightColor: AppColors.greyB3B3B3.withAlpha(50),
              child: Container(
                height: 18,
                width: 80,
                decoration: BoxDecoration(
                  color: AppColors.whiteFFFFFF,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}