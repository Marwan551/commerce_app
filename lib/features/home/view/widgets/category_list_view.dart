import 'package:flutter/material.dart';
import 'package:commerce_app/features/home/models/category_model.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/core/utils/constants/styles/app_text_styles.dart';

class CategoryListView extends StatelessWidget {
  final List<CategoryData> categories;
  final String? selectedCategoryId;
  final void Function(String?) onCategorySelected;

  const CategoryListView({
    super.key,
    required this.categories,
    this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _chip(
              label: 'All',
              isSelected: selectedCategoryId == null,
              onTap: () => onCategorySelected(null),
            );
          }
          final category = categories[index - 1];
          return _chip(
            label: category.name ?? '',
            isSelected: selectedCategoryId == category.id,
            onTap: () => onCategorySelected(category.id),
          );
        },
      ),
    );
  }

  Widget _chip({required String label, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.black1A1A1A : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? AppColors.black1A1A1A : AppColors.greyB3B3B3),
        ),
        child: Text(
          label,
          style: AppTextStyles.medium14.copyWith(
            color: isSelected ? Colors.white : AppColors.black1A1A1A,
          ),
        ),
      ),
    );
  }
}
