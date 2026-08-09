import 'package:commerce_app/features/home/models/category_model.dart';
import 'package:commerce_app/features/home/models/product_model.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<CategoryData> categories;
  final List<ProductData> products;
  final int currentPage;
  final int totalPageCount;
  final String? selectedCategoryId;
  final String searchQuery;
  final String sortBy;
  final double minPrice;
  final double maxPrice;
  final bool isFetching;

  HomeSuccess({
    required this.categories,
    required this.products,
    required this.currentPage,
    required this.totalPageCount,
    this.selectedCategoryId,
    this.searchQuery = '',
    this.sortBy = 'Relevance',
    this.minPrice = 0,
    this.maxPrice = 10000,
    this.isFetching = false,
  });

  HomeSuccess copyWith({
    List<CategoryData>? categories,
    List<ProductData>? products,
    int? currentPage,
    int? totalPageCount,
    String? selectedCategoryId,
    bool clearCategoryId = false,
    String? searchQuery,
    String? sortBy,
    double? minPrice,
    double? maxPrice,
    bool? isFetching,
  }) {
    return HomeSuccess(
      categories: categories ?? this.categories,
      products: products ?? this.products,
      currentPage: currentPage ?? this.currentPage,
      totalPageCount: totalPageCount ?? this.totalPageCount,
      selectedCategoryId: clearCategoryId ? null : (selectedCategoryId ?? this.selectedCategoryId),
      searchQuery: searchQuery ?? this.searchQuery,
      sortBy: sortBy ?? this.sortBy,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      isFetching: isFetching ?? this.isFetching,
    );
  }
}

final class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
