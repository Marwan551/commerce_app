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
      final response = await _apiService.getData(endpoint: Endpoints.cart);
      final cartModel = CartModel.fromJson(response.data);
      emit(CartUpdated(cartModel.data?.products ?? [], cartModel));
    } catch (e) {
      emit(CartError(ApiErrorHandler.getMessage(e)));
    }
  }

  Future<void> addItem(String productId) async {
    final token = SharedPrefHelper.getData(SharedPrefKeys.token);
    if (token == null) return;

    try {
      final response = await _apiService.postData(
        endpoint: Endpoints.cart,
        data: {'productId': productId},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final cartModel = CartModel.fromJson(response.data);
        emit(CartUpdated(cartModel.data?.products ?? [], cartModel));
      }
    } catch (e) {
      emit(CartUpdateError(ApiErrorHandler.getMessage(e)));
    }
  }

  Future<void> removeItem(String productId) async {
    final token = SharedPrefHelper.getData(SharedPrefKeys.token);
    if (token == null) return;

    final currentState = state;
    CartModel? currentModel;
    if (currentState is CartUpdated) {
      currentModel = currentState.cartModel;
      emit(CartUpdating(currentModel));
    }

    try {
      final response = await _apiService.deleteData(
        endpoint: '${Endpoints.cart}/$productId',
      );
      final cartModel = CartModel.fromJson(response.data);
      emit(CartUpdated(cartModel.data?.products ?? [], cartModel));
    } catch (e) {
      emit(CartUpdateError(ApiErrorHandler.getMessage(e)));
      if (currentModel != null) {
        emit(CartUpdated(currentModel.data?.products ?? [], currentModel));
      }
    }
  }

  Future<void> updateProductQuantity(String productId, int count) async {
    if (count < 1) return;

    final currentState = state;
    CartModel? currentModel;
    if (currentState is CartUpdated) {
      currentModel = currentState.cartModel;
      emit(CartUpdating(currentModel));
    }

    try {
      final response = await _apiService.putData(
        endpoint: '${Endpoints.cart}/$productId',
        data: {'count': count.toString()},
      );
      final cartModel = CartModel.fromJson(response.data);
      emit(CartUpdated(cartModel.data?.products ?? [], cartModel));
    } catch (e) {
      emit(CartUpdateError(ApiErrorHandler.getMessage(e)));
      if (currentModel != null) {
        emit(CartUpdated(currentModel.data?.products ?? [], currentModel));
      }
    }
  }

  Future<void> clearCart() async {
    emit(CartLoading());
    try {
      final response = await _apiService.deleteData(endpoint: Endpoints.cart);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final emptyModel = CartModel(
          numOfCartItems: 0,
          data: CartData(products: [], totalCartPrice: 0),
        );
        emit(CartUpdated([], emptyModel));
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
