import 'package:commerce_app/core/utils/constants/strings/app_strings.dart';
import 'package:commerce_app/core/utils/widgets/dividers/custom_divider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'summary_row.dart';
import 'summary_total_row.dart';

class SummarySection extends StatelessWidget {
  final num totalCartPrice;
  final int itemCount;

  const SummarySection({
    super.key,
    required this.totalCartPrice,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    const double vat = 0;
    const double shipping = 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: const BoxDecoration(
        color: AppColors.whiteFFFFFF,
      ),
      child: Column(
        children: [
          SummaryRow(label: AppStrings.subtotal.tr(), value: '\$ $totalCartPrice'),
          const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
          SummaryRow(label: AppStrings.vat.tr(), value: '\$ $vat'),
          const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
          SummaryRow(label: AppStrings.shipping.tr(), value: '\$ $shipping'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: CustomDivider(),
          ),
          SummaryTotalRow(totalPrice: totalCartPrice + vat + shipping),
        ],
      ),
    );
  }
}
