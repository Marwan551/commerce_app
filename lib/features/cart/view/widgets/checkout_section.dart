import 'package:commerce_app/core/utils/constants/strings/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_button.dart';
import 'package:commerce_app/core/utils/navigation/screen_navigation.dart';
import 'package:commerce_app/features/cart/controllers/cubit/cart_cubit.dart';
import 'package:commerce_app/features/cart/view/widgets/clear_cart_dialog.dart';
import 'package:commerce_app/core/utils/constants/assets/assets.gen.dart';


class CheckoutSection extends StatelessWidget {
  final int itemCount;

  const CheckoutSection({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {


    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 24),
      color: AppColors.whiteFFFFFF,
      child: Row(
        children: [
          GestureDetector(
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
          ),
          const SizedBox(width: 16),
          Expanded(
            child: CustomButton(
              text: AppStrings.goToCheckout.tr(),
              trailingIcon: const Icon(
                Icons.arrow_forward,
                color: AppColors.whiteFFFFFF,
                size: 20,
              ),
              onPressed: () {
                ScreenNavigation.navigateToHome(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
