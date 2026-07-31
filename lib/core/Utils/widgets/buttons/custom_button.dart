import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/core/utils/widgets/loading/app_loading_indicator.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              onPressed == null ? AppColors.greyB3B3B3 : AppColors.black1A1A1A,
          disabledBackgroundColor: AppColors.greyB3B3B3,
        ),
        child: isLoading
            ? const AppLoadingIndicator(
                size: 24,
                color: Colors.white,
              )
            : Text(text),
      ),
    );
  }
}
