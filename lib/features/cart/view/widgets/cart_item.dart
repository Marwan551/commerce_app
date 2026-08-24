import 'package:commerce_app/core/utils/constants/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/features/cart/models/cart_model.dart';
import 'cart_quantity_selector.dart';

class CartItemWidget extends StatelessWidget {
  final CartProduct cartProduct;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;
  final bool isUpdating;

  const CartItemWidget({
    super.key,
    required this.cartProduct,
    required this.onQuantityChanged,
    required this.onRemove,
    this.isUpdating = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final product = cartProduct.product;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.whiteFFFFFF,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.greyFFE6E6E6),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: product?.imageCover ?? '',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        product?.title ?? 'N/A',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(bottom: 20),
                      child: GestureDetector(
                        onTap: isUpdating ? null : onRemove,
                        child: Opacity(
                          opacity: isUpdating ? 0.5 : 1.0,
                          child: Assets.images.imgs.trash.svg(
                            width: 15,
                            height: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 16)),
                Row(
                  children: [
                    Text(
                      '\$ ${cartProduct.price}',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.black1A1A1A,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    CartQuantitySelector(
                      count: cartProduct.count ?? 1,
                      onQuantityChanged: onQuantityChanged,
                      isUpdating: isUpdating,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
