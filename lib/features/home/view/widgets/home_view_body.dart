import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:commerce_app/core/utils/constants/strings/app_strings.dart';
import 'package:commerce_app/features/home/models/category_model.dart';
import 'package:commerce_app/features/home/models/product_model.dart';
import 'custom_search_bar.dart';
import 'category_list_view.dart';
import 'product_item.dart';
import 'no_results_found.dart';
import 'filter_bottom_sheet.dart';

class HomeViewBody extends StatelessWidget {
  final List<CategoryData> categories;
  final List<ProductData> products;
  final int currentPage;
  final int totalPageCount;
  final String? selectedCategoryId;
  final String sortBy;
  final double minPrice;
  final double maxPrice;
  final bool isFetching;
  final void Function(String) onSearchChanged;
  final void Function(String?) onCategorySelected;
  final void Function(int) onPageChanged;
  final void Function(String sortBy, double minPrice, double maxPrice) onFiltersApplied;

  const HomeViewBody({
    super.key,
    required this.categories,
    required this.products,
    required this.currentPage,
    required this.totalPageCount,
    this.selectedCategoryId,
    required this.sortBy,
    required this.minPrice,
    required this.maxPrice,
    required this.isFetching,
    required this.onSearchChanged,
    required this.onCategorySelected,
    required this.onPageChanged,
    required this.onFiltersApplied,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.discover, style: theme.textTheme.displayLarge),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: CustomSearchBar(
            onSearchChanged: onSearchChanged,
            onFilterTap: () => _showFilterSheet(context),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(AppStrings.categories, style: theme.textTheme.headlineMedium),
                const SizedBox(height: 16),
                CategoryListView(
                  categories: categories,
                  selectedCategoryId: selectedCategoryId,
                  onCategorySelected: onCategorySelected,
                ),
                const SizedBox(height: 24),
                Text(AppStrings.recentProducts, style: theme.textTheme.headlineMedium),
                const SizedBox(height: 16),
                if (isFetching)
                  _buildGridShimmer(context)
                else if (products.isEmpty)
                  const NoResultsFound()
                else ...[
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ProductItem(product: products[index]);
                    },
                  ),
                  const SizedBox(height: 20),
                  NumberPaginator(
                    numberPages: totalPageCount,
                    initialPage: currentPage - 1,
                    onPageChange: (index) => onPageChanged(index + 1),
                    child: const SizedBox(
                      height: 48,
                      child: Row(
                        children: [
                          PrevButton(),
                          Flexible(child: ScrollableNumberContent()),
                          NextButton(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGridShimmer(BuildContext context) {
    final theme = Theme.of(context);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemCount: 6,
      itemBuilder: (_, index) => Shimmer.fromColors(
        baseColor: theme.colorScheme.secondary,
        highlightColor: theme.colorScheme.secondary.withAlpha(100),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FilterBottomSheet(
        initialSortBy: sortBy,
        initialMinPrice: minPrice,
        initialMaxPrice: maxPrice,
        onApply: onFiltersApplied,
      ),
    );
  }
}
