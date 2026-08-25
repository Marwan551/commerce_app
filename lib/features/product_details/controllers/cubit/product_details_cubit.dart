import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/services/network_service/remote/base_client_service.dart';
import 'package:commerce_app/core/services/network_service/remote/endpoints.dart';
import 'package:commerce_app/core/services/network_service/remote/api_error_handler.dart';
import 'package:commerce_app/features/home/models/product_model.dart';
import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ApiService _apiService;

  ProductDetailsCubit(this._apiService) : super(ProductDetailsInitial());

  Future<void> getProductDetails(String productId) async {
    emit(ProductDetailsLoading());
    try {
      final response = await _apiService.getData(
        endpoint: '${Endpoints.products}/$productId',
      );
      final product = ProductData.fromJson(response.data['data']);
      emit(ProductDetailsSuccess(product));
    } catch (e) {
      emit(ProductDetailsError(ApiErrorHandler.getMessage(e)));
    }
  }
}
