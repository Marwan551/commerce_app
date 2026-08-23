import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_button.dart';

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
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('filter'.tr(), style: theme.textTheme.headlineLarge),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('sortBy'.tr(), style: theme.textTheme.headlineSmall),
          const SizedBox(height: 12),
          _sortOption('relevance'.tr()),
          _sortOption('priceLowHigh'.tr()),
          _sortOption('priceHighLow'.tr()),
          const SizedBox(height: 24),
          Text('priceRange'.tr(), style: theme.textTheme.headlineSmall),
          const SizedBox(height: 12),
          RangeSlider(
            values: _currentRangeValues,
            min: 0,
            max: 10000,
            divisions: 100,
            activeColor: theme.colorScheme.primary,
            inactiveColor: theme.colorScheme.secondary,
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
            text: 'applyFilter'.tr(),
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
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      value: title,
      groupValue: _selectedSortBy,
      activeColor: Theme.of(context).colorScheme.primary,
      contentPadding: EdgeInsets.zero,
      onChanged: (value) {
        setState(() {
          _selectedSortBy = value!;
        });
      },
    );
  }
}
