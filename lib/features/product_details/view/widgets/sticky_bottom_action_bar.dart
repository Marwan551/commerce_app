import 'package:easy_localization/easy_localization.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_button.dart';

class StickyBottomActionBar extends StatelessWidget {
  final num price;
  final VoidCallback onAddToCart;
  final bool isAddingToCart;

  const StickyBottomActionBar({
    super.key,
    required this.price,
    required this.onAddToCart,
    required this.isAddingToCart,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.whiteFFFFFF,
        border: Border(top: BorderSide(color: AppColors.greyFFE6E6E6)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'price'.tr(), 
                  style: theme.textTheme.bodyLarge?.copyWith(color: AppColors.grey707070),
                ),
                Text(
                  '\$ $price',
                  style: theme.textTheme.displayMedium,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: CustomButton(
              text: 'add_to_cart'.tr(),
              isLoading: isAddingToCart,
              onPressed: onAddToCart,
              leadingIcon: const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
