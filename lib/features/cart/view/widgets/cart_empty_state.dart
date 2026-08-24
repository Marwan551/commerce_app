import 'package:commerce_app/core/utils/constants/assets/assets.gen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/constants/styles/app_text_styles.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';

class CartEmptyState extends StatelessWidget {
  const CartEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.images.imgs.cartEmpty.svg(
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 24),
            Text(
              'empty_cart_msg'.tr(),
              style: AppTextStyles.bold24,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'empty_cart_desc'.tr(),
              style: AppTextStyles.regular16.copyWith(color: AppColors.grey707070),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
