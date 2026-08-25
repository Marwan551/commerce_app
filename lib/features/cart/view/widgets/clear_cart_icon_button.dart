import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/features/cart/controllers/cubit/cart_cubit.dart';
import 'package:commerce_app/features/cart/view/widgets/clear_cart_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClearCartIconButton extends StatelessWidget {
  const ClearCartIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => ClearCartDialog(
            onClear: () {
              context.read<CartCubit>().clearCart();
              Navigator.pop(context);
            },
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.delete_sweep_outlined,
            color: AppColors.redFFED1010,
            size: 28,
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
