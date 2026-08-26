import 'package:commerce_app/core/utils/constants/strings/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/services/network_service/remote/base_client_service.dart';
import 'package:commerce_app/core/services/network_service/remote/endpoints.dart';
import 'package:commerce_app/core/services/network_service/remote/api_error_handler.dart';
import 'package:commerce_app/features/cart/models/cart_model.dart';
import 'cart_state.dart';
export 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final ApiService _apiService;
  CartModel? _cartModel;

  CartCubit(this._apiService) : super(CartInitial());

  // Public Methods
  Future<void> fetchCart() async {
    _emitLoading();
    try {
      final response = await _apiService.getData(endpoint: Endpoints.cart);
      _handleSuccessResponse(response.data);
    } catch (e) {
      _emitError(e);
    }
  }

  Future<void> addItem(String productId) async {
    _emitUpdating();
    try {
      final response = await _apiService.postData(
        endpoint: Endpoints.cart,
        data: {'productId': productId},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchCart();
        _emitActionSuccess(AppStrings.addToCartSuccess);
      }
    } catch (e) {
      _handleUpdateError(e);
    }
  }

  Future<void> removeItem(String productId) async {
    _emitUpdating();
    try {
      final response = await _apiService.deleteData(
        endpoint: '${Endpoints.cart}/$productId',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchCart();
      }
    } catch (e) {
      _handleUpdateError(e);
    }
  }

  Future<void> updateQuantity(String productId, int count) async {
    if (count < 1) return;
    _emitUpdating();

    try {
      final response = await _apiService.putData(
        endpoint: '${Endpoints.cart}/$productId',
        data: {'count': count.toString()},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchCart();
      }
    } catch (e) {
      _handleUpdateError(e);
    }
  }

  Future<void> clearCart() async {
    _emitLoading();
    try {
      final response = await _apiService.deleteData(endpoint: Endpoints.cart);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _cartModel = null;
        _emitUpdated();
      }
    } catch (e) {
      _emitError(e);
    }
  }

  Future<void> checkout() async {
    if (_cartModel != null) {
      emit(CartUpdating(_cartModel!));
    } else {
      _emitLoading();
    }
    
    await Future.delayed(const Duration(seconds: 1));
    
    _emitActionSuccess(AppStrings.checkoutSuccessful);
    await clearCart();
  }

  void resetState() {
    _cartModel = null;
    emit(CartInitial());
  }

  void _handleSuccessResponse(Map<String, dynamic> data) {
    _cartModel = CartModel.fromJson(data);
    _emitUpdated();
  }

  void _emitLoading() => emit(CartLoading());

  void _emitUpdated() {
    if (_cartModel != null) {
      emit(CartUpdated(_cartModel!.data?.products ?? [], _cartModel!));
    } else {
      emit(CartInitial());
    }
  }

  void _emitUpdating() {
    if (_cartModel != null) {
      emit(CartUpdating(_cartModel!));
    } else {
      _emitLoading();
    }
  }

  void _emitError(dynamic e) {
    emit(CartError(ApiErrorHandler.getMessage(e)));
  }

  void _emitActionSuccess(String message) {
    if (_cartModel != null) {
      emit(CartActionSuccess(message, _cartModel!));
    }
  }

  void _handleUpdateError(dynamic e) {
    emit(CartUpdateError(ApiErrorHandler.getMessage(e)));
    _emitUpdated();
  }
}
