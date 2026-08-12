import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:commerce_app/core/utils/constants/styles/app_text_styles.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/core/utils/constants/strings/app_strings.dart';

class WishlistEmptyState extends StatelessWidget {
  const WishlistEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/imgs/empty_wishlist.svg',
              width: 64,
              height: 64,
            ),
            const SizedBox(height: 24),
            const Text(
              AppStrings.noSavedItems,
              style: AppTextStyles.bold24,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              AppStrings.noSavedItemsMsg,
              style: AppTextStyles.regular16.copyWith(color: AppColors.grey707070),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
