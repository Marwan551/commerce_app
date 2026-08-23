import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';

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
            Text(
              'empty_wishlist_msg'.tr(),
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'empty_wishlist_desc'.tr(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.grey707070),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
