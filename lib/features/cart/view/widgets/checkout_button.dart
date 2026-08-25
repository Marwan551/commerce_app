import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/core/utils/constants/strings/app_strings.dart';
import 'package:commerce_app/core/utils/navigation/screen_navigation.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: AppStrings.goToCheckout.tr(),
      trailingIcon: const Icon(
        Icons.arrow_forward,
        color: AppColors.whiteFFFFFF,
        size: 20,
      ),
      onPressed: () {
        ScreenNavigation.navigateToHome(context);
      },
    );
  }
}
