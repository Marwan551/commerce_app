import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_button.dart';
import 'package:commerce_app/core/utils/constants/assets/assets.gen.dart';
import 'package:commerce_app/core/utils/constants/strings/app_strings.dart';

class DeleteCartItemDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const DeleteCartItemDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.images.imgs.warning.svg(width: 80, height: 80),
            const SizedBox(height: 24),
            Text(
              'remove_item_question'.tr(),
              style: theme.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'remove_item_confirm_msg'.tr(),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: AppColors.grey707070,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'yes_remove'.tr(),
              onPressed: () {
                onConfirm();
                Navigator.pop(context);
              },
              backgroundColor: AppColors.redFFED1010,
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.greyB3B3B3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  AppStrings.noCancel.tr(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.black1A1A1A,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
