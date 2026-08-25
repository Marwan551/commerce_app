import 'package:commerce_app/core/utils/constants/assets/assets.gen.dart';
import 'package:flutter/material.dart';

class CartItemTrashButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isUpdating;

  const CartItemTrashButton({
    super.key,
    required this.onTap,
    this.isUpdating = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 20),
      child: GestureDetector(
        onTap: isUpdating ? null : onTap,
        child: Opacity(
          opacity: isUpdating ? 0.5 : 1.0,
          child: Assets.images.imgs.trash.svg(
            width: 15,
            height: 15,
          ),
        ),
      ),
    );
  }
}
