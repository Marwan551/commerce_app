import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';

class CartShimmerLoading extends StatelessWidget {
  const CartShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: AppColors.greyB3B3B3.withAlpha(100),
          highlightColor: AppColors.greyB3B3B3.withAlpha(50),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.whiteFFFFFF,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      },
    );
  }
}
