import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/constants/styles/app_text_styles.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_button.dart';

import 'package:commerce_app/core/utils/constants/strings/app_strings.dart';

class FilterBottomSheet extends StatefulWidget {
  final String initialSortBy;
  final double initialMinPrice;
  final double initialMaxPrice;
  final void Function(String sortBy, double minPrice, double maxPrice) onApply;

  const FilterBottomSheet({
    super.key,
    required this.initialSortBy,
    required this.initialMinPrice,
    required this.initialMaxPrice,
    required this.onApply,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late String _selectedSortBy;
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    super.initState();
    _selectedSortBy = widget.initialSortBy;
    _currentRangeValues = RangeValues(widget.initialMinPrice, widget.initialMaxPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(AppStrings.filter, style: AppTextStyles.bold20),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(AppStrings.sortBy, style: AppTextStyles.bold16),
          const SizedBox(height: 12),
          _sortOption(AppStrings.relevance),
          _sortOption(AppStrings.priceLowHigh),
          _sortOption(AppStrings.priceHighLow),
          const SizedBox(height: 24),
          const Text(AppStrings.priceRange, style: AppTextStyles.bold16),
          const SizedBox(height: 12),
          RangeSlider(
            values: _currentRangeValues,
            min: 0,
            max: 10000,
            divisions: 100,
            activeColor: AppColors.black1A1A1A,
            inactiveColor: AppColors.greyB3B3B3,
            labels: RangeLabels(
              '\$${_currentRangeValues.start.round()}',
              '\$${_currentRangeValues.end.round()}',
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
              });
            },
          ),
          const SizedBox(height: 32),
          CustomButton(
            text: AppStrings.applyFilter,
            onPressed: () {
              widget.onApply(
                _selectedSortBy,
                _currentRangeValues.start,
                _currentRangeValues.end,
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _sortOption(String title) {
    return RadioListTile<String>(
      title: Text(title, style: AppTextStyles.regular16),
      value: title,
      groupValue: _selectedSortBy,
      activeColor: AppColors.black1A1A1A,
      contentPadding: EdgeInsets.zero,
      onChanged: (value) {
        setState(() {
          _selectedSortBy = value!;
        });
      },
    );
  }
}
