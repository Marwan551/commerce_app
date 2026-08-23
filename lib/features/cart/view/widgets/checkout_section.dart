import 'package:commerce_app/core/utils/constants/assets/assets.gen.dart';
import 'package:easy_localization/easy_localization.dart';
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
            mainAxisSize: MainAxisSize.min,
            children: [
          Assets.images.imgs.trash.svg(
            width: 22,
            height: 22,
          ),
              const SizedBox(height: 4),
              Text(
                'clear_cart'.tr(),
                style: const TextStyle(color: AppColors.redFFED1010, fontSize: 12),
              )
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: CustomButton(
            text: 'go_to_checkout'.tr(),
            trailingIcon: Assets.images.imgs.arrowRight.svg(),
            onPressed: () {
              ScreenNavigation.navigateToHome();
            },
          ),
        ),
      ],
    ),
  );
}
