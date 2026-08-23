import 'package:commerce_app/core/utils/constants/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/features/cart/models/cart_model.dart';

class CartItemWidget extends StatefulWidget {
  final CartProduct cartProduct;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const CartItemWidget({
    super.key,
    required this.cartProduct,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.cartProduct.count.toString());
  }

  @override
  void didUpdateWidget(CartItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.cartProduct.count.toString() != _controller.text) {
      _controller.text = widget.cartProduct.count.toString();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateQuantity(int newCount) {
    if (newCount >= 1) {
      widget.onQuantityChanged(newCount);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final product = widget.cartProduct.product;

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
                    GestureDetector(
                      onTap: widget.onRemove,
                      child: Assets.images.imgs.trash.svg(
                        width: 12.5,
                        height: 13.75,
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsetsDirectional.only(top: 20)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 60),
                      child: Text(
                        '\$ ${widget.cartProduct.price}',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: AppColors.black1A1A1A,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    _quantityButton(
                      svg: Assets.images.imgs.minus,
                      onPressed: () => _updateQuantity((widget.cartProduct.count ?? 1) - 1),
                    ),
                    Padding(padding: EdgeInsetsDirectional.only(start: 10)),
                    SizedBox(
                      width: 35,
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                        ),
                        onSubmitted: (value) {
                          final int? newCount = int.tryParse(value);
                          if (newCount != null) {
                            _updateQuantity(newCount);
                          } else {
                            _controller.text = widget.cartProduct.count.toString();
                          }
                        },
                        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                      ),
                    ),
                    Padding(padding: EdgeInsetsDirectional.only(start: 10)),
                    _quantityButton(
                      svg: Assets.images.imgs.plus,
                      onPressed: () => _updateQuantity((widget.cartProduct.count ?? 1) + 1),
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

  Widget _quantityButton({required SvgGenImage svg, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: svg.svg(),
      ),
    );
  }
}
