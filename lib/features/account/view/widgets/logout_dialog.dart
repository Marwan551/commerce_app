import 'package:commerce_app/core/utils/constants/strings/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_button.dart';
import 'package:commerce_app/core/utils/constants/assets/assets.gen.dart';

class LogoutDialog extends StatefulWidget {
  final Future<void> Function() onLogout;

  const LogoutDialog({super.key, required this.onLogout});

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  bool _isLoading = false;

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
              AppStrings.logoutQuestion.tr(),
              style: theme.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              AppStrings.logoutConfirmMsg.tr(),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: AppColors.grey707070,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: AppStrings.yesLogout.tr(),
              isLoading: _isLoading,
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                await widget.onLogout();
                if (mounted) {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              backgroundColor: AppColors.redFFED1010,
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: _isLoading ? null : () => Navigator.pop(context),
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
