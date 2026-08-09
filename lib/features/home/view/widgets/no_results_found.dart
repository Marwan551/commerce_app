import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/constants/styles/app_text_styles.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';

import 'package:commerce_app/core/utils/constants/strings/app_strings.dart';

class NoResultsFound extends StatelessWidget {
  const NoResultsFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 80, color: AppColors.greyB3B3B3),
            const SizedBox(height: 24),
            const Text(AppStrings.noResults, style: AppTextStyles.bold24),
            const SizedBox(height: 12),
            Text(
              AppStrings.noResultsMsg,
              textAlign: TextAlign.center,
              style: AppTextStyles.regular16.copyWith(color: AppColors.grey707070),
            ),
          ],
        ),
      ),
    );
  }
}
