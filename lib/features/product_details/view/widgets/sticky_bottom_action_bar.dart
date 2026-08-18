import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        border: Border(top: BorderSide(color:AppColors.greyFFE6E6E6)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price', 
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
              text: 'Add to Cart',
              isLoading: isAddingToCart,
              onPressed: onAddToCart,
              leadingIcon: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: SvgPicture.asset(
                  'assets/images/imgs/bag.svg',
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
