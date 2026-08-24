import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';

Widget buildSummarySection(BuildContext context, num totalCartPrice) {
  final theme = Theme.of(context);
  const double vat = 0;
  const double shipping = 0;

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    decoration: BoxDecoration(
      color: AppColors.whiteFFFFFF,
    ),
    child: Column(
      children: [
        _summaryRow('subtotal'.tr(), '\$ $totalCartPrice', theme),
        const Padding(padding: EdgeInsets.only(top: 8)),
        _summaryRow('vat'.tr(), '\$ $vat', theme),
        const Padding(padding: EdgeInsets.only(top: 8)),
        _summaryRow('shipping'.tr(), '\$ $shipping', theme),
        const Padding(padding: EdgeInsets.only(top: 16)),
        const Divider(thickness: 1, color: AppColors.greyFFE6E6E6),
        const Padding(padding: EdgeInsets.only(top: 16)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('total'.tr(), style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
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
