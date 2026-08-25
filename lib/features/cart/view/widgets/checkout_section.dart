import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'clear_cart_icon_button.dart';
import 'checkout_button.dart';

class CheckoutSection extends StatelessWidget {
  final int itemCount;

  const CheckoutSection({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    // Reactive bottom padding
    final double bottomPadding = itemCount < 3 ? 32.0 : 24.0;

    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, bottomPadding),
      color: AppColors.whiteFFFFFF,
      child: const Row(
        children: [
          ClearCartIconButton(),
          SizedBox(width: 16),
          Expanded(
            child: CheckoutButton(),
          ),
        ],
      ),
    );
  }
}
