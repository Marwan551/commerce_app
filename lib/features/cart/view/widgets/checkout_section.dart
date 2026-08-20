import 'package:commerce_app/core/utils/constants/assets/assets.gen.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_button.dart';
import 'package:commerce_app/core/utils/navigation/screen_navigation.dart';
import 'package:commerce_app/features/cart/controllers/cubit/cart_cubit.dart';


Widget buildCheckoutSection(BuildContext context) {
  return Container(
    padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 12),
    color: AppColors.whiteFFFFFF,
    child: Row(
      children: [
        GestureDetector(
          onTap: () => context.read<CartCubit>().clearCart(),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Assets.images.imgs.trash.svg(
                  width: 25,
                  height: 22,
                ),
              ),
            Text('Clear Cart',style: TextStyle(color: AppColors.redFFED1010),)
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: CustomButton(
            text: 'Go To Checkout',
            trailingIcon: const Icon(
              Icons.arrow_forward,
              color: AppColors.whiteFFFFFF,
              size: 20,
            ),
            onPressed: () {
              ScreenNavigation.navigateToHome();
            },
          ),
        ),
      ],
    ),
  );
}
