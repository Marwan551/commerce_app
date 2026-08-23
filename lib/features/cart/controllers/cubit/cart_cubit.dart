import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/services/network_service/remote/base_client_service.dart';
import 'package:commerce_app/core/services/network_service/remote/endpoints.dart';
import 'package:commerce_app/core/services/network_service/local/shared_pref_service.dart';
import 'package:commerce_app/core/services/network_service/remote/api_error_handler.dart';
import 'package:commerce_app/features/cart/models/cart_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final ApiService _apiService;

  CartCubit(this._apiService) : super(CartInitial());

  Future<void> getCart() async {
    final token = SharedPrefHelper.getData(SharedPrefKeys.token);
    if (token == null) {
      emit(CartError('Please login first to view your cart.'));
      return;
    }

    emit(CartLoading());
    try {
      final response = await _apiService.getData(
        endpoint: Endpoints.cart,
        token: token,
      );
      final cartModel = CartModel.fromJson(response.data);
      emit(CartSuccess(cartModel));
    } catch (e) {
      emit(CartError(ApiErrorHandler.getMessage(e)));
    }
  }

  Future<void> updateProductQuantity(String productId, int count) async {
    final token = SharedPrefHelper.getData(SharedPrefKeys.token);
    if (token == null) return;

    try {
      final response = await _apiService.putData(
        endpoint: '${Endpoints.cart}/$productId',
        data: {'count': count.toString()},
        token: token,
      );
      final cartModel = CartModel.fromJson(response.data);
      emit(CartSuccess(cartModel));
    } catch (e) {
      emit(CartUpdateError(ApiErrorHandler.getMessage(e)));
    }
  }

  Future<void> removeCartItem(String productId) async {
    final token = SharedPrefHelper.getData(SharedPrefKeys.token);
    if (token == null) return;

    try {
      final response = await _apiService.deleteData(
        endpoint: '${Endpoints.cart}/$productId',
        token: token,
      );
      final cartModel = CartModel.fromJson(response.data);
      emit(CartSuccess(cartModel));
    } catch (e) {
      emit(CartUpdateError(ApiErrorHandler.getMessage(e)));
    }
  }

  Future<void> clearCart() async {
    final token = SharedPrefHelper.getData(SharedPrefKeys.token);
    if (token == null) return;

    emit(CartLoading());
    try {
      final response = await _apiService.deleteData(
        endpoint: Endpoints.cart,
        token: token,
      );
      if (response.data['status'] == 'success') {
        emit(
          CartSuccess(
            CartModel(
              numOfCartItems: 0,
              data: CartData(products: [], totalCartPrice: 0),
            ),
          ),
        );
      } else {
        getCart();
      }
    } catch (e) {
      emit(CartError(ApiErrorHandler.getMessage(e)));
    }
  }

  void resetState() {
    emit(CartInitial());
  }
}
