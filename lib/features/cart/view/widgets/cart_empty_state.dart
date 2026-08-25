import 'package:commerce_app/core/utils/constants/strings/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:commerce_app/core/utils/constants/assets/assets.gen.dart';
import 'package:flutter/material.dart';
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
              width: 64,
              height: 64,
            ),
            const SizedBox(height: 24),
            Text(
              AppStrings.emptyCartMsg.tr(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              AppStrings.emptyCartDesc.tr(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.grey707070),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
