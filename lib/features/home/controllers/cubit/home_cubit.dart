import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/services/remote/base_client_service.dart';
import 'package:commerce_app/core/services/remote/endpoints.dart';
import 'package:commerce_app/core/services/remote/api_error_handler.dart';
import 'package:commerce_app/features/home/models/category_model.dart';
import 'package:commerce_app/features/home/models/product_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiService _apiService;

  HomeCubit(this._apiService) : super(HomeInitial());

  Timer? _debounce;
  
  List<CategoryData> _categories = [];
  
  String? _selectedCategoryId;
  String _searchQuery = '';
  String _sortBy = 'Relevance';
  double _minPrice = 0;
  double _maxPrice = 10000;
  int _currentPage = 1;

  Future<void> getHomeData({int page = 1, bool isSilent = false}) async {
    _currentPage = page;

    if (state is HomeSuccess && !isSilent) {
      emit((state as HomeSuccess).copyWith(isFetching: true));
    } else if (state is! HomeSuccess) {
      emit(HomeLoading());
    }

    try {
      final Map<String, dynamic> queryParams = {
        'page': _currentPage,
        'limit': 6,
      };

      if (_selectedCategoryId != null) queryParams['category'] = _selectedCategoryId;
      if (_searchQuery.isNotEmpty) queryParams['keyword'] = _searchQuery;
      
      final sortString = _getSortString(_sortBy);
      if (sortString.isNotEmpty) queryParams['sort'] = sortString;
      
      queryParams['price[gte]'] = _minPrice;
      queryParams['price[lte]'] = _maxPrice;

      final productsResponseFuture = _apiService.getData(
        endpoint: Endpoints.products,
        query: queryParams,
      );

      dynamic results;
      if (_categories.isEmpty) {
        results = await Future.wait([
          _apiService.getData(endpoint: Endpoints.categories),
          productsResponseFuture,
        ]);
        _categories = CategoryModel.fromJson(results[0].data).data ?? [];
        results = results[1];
      } else {
        results = await productsResponseFuture;
      }

      final productModel = ProductModel.fromJson(results.data);

      emit(HomeSuccess(
        categories: _categories,
        products: productModel.data ?? [],
        currentPage: productModel.metadata?.currentPage ?? 1,
        totalPageCount: productModel.metadata?.numberOfPages ?? 1,
        selectedCategoryId: _selectedCategoryId,
        searchQuery: _searchQuery,
        sortBy: _sortBy,
        minPrice: _minPrice,
        maxPrice: _maxPrice,
        isFetching: false,
      ));
    } catch (e) {
      emit(HomeError(ApiErrorHandler.getMessage(e)));
    }
  }

  void updateSearch(String query) {
    _searchQuery = query;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      getHomeData(page: 1);
    });
  }

  void selectCategory(String? categoryId) {
    _selectedCategoryId = categoryId;
    getHomeData(page: 1);
  }

  void applyFilters({String? sortBy, double? minPrice, double? maxPrice}) {
    if (sortBy != null) _sortBy = sortBy;
    if (minPrice != null) _minPrice = minPrice;
    if (maxPrice != null) _maxPrice = maxPrice;
    getHomeData(page: 1);
  }

  void changePage(int page) {
    getHomeData(page: page);
  }

  String _getSortString(String sortBy) {
    switch (sortBy) {
      case 'Price: Low → High':
        return 'price';
      case 'Price: High → Low':
        return '-price';
      default:
        return '';
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
