import 'package:commerce_app/core/utils/constants/assets/assets.gen.dart';
import 'package:commerce_app/core/utils/constants/strings/app_strings.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_button.dart';
import 'package:commerce_app/features/cart/controllers/cubit/cart_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: AppStrings.goToCheckout.tr(),
      trailingIcon: Assets.images.imgs.arrowRight.svg(
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
      onPressed: () {
        context.read<CartCubit>().checkout();
      },
    );
  }
}
