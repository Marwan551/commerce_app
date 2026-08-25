import 'package:commerce_app/core/utils/constants/assets/assets.gen.dart';
import 'package:commerce_app/features/cart/controllers/cubit/cart_cubit.dart';
import 'package:commerce_app/features/cart/view/widgets/cart_empty_state.dart';
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
          Assets.images.imgs.trash.svg(width: 30,height: 30),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
