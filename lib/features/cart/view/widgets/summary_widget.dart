import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';

Widget buildSummarySection(BuildContext context, num totalCartPrice) {
  final theme = Theme.of(context);
  const double vat = 0;
  const double shipping = 0;

  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: AppColors.whiteFFFFFF,
    ),
    child: Column(
      children: [
        _summaryRow('Sub-total', '\$ $totalCartPrice', theme),
        const SizedBox(height: 8),
        _summaryRow('VAT (%)', '\$ $vat', theme),
        const SizedBox(height: 8),
        _summaryRow('Shipping fee', '\$ $shipping', theme),
        const SizedBox(height: 16),
        const Divider(thickness: 1,color: AppColors.greyFFE6E6E6,),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            Text('\$ ${totalCartPrice + vat + shipping}',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                )),
          ],
        ),
      ],
    ),
  );
}

Widget _summaryRow(String label, String value, ThemeData theme) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: theme.textTheme.bodyLarge?.copyWith(color: AppColors.grey707070)),
      Text(value, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
    ],
  );
}
