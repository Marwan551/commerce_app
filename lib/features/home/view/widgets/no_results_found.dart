import 'package:commerce_app/core/utils/constants/strings/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NoResultsFound extends StatelessWidget {
  const NoResultsFound({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 80, color: theme.colorScheme.secondary),
            const SizedBox(height: 24),
            Text(AppStrings.noResults.tr(), style: theme.textTheme.displayMedium),
            const SizedBox(height: 12),
            Text(
              AppStrings.noResultsMsg.tr(),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
