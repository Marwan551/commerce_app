import 'package:commerce_app/core/utils/constants/strings/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/services/network_service/remote/base_client_service.dart';
import 'package:commerce_app/core/services/network_service/remote/endpoints.dart';
import 'package:commerce_app/core/services/network_service/local/shared_pref_service.dart';
import 'package:commerce_app/core/services/network_service/remote/api_error_handler.dart';
import 'package:commerce_app/features/cart/models/cart_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final ApiService _apiService;
  CartModel? _cartModel;

  CartCubit(this._apiService) : super(CartInitial());

  Future<void> getCart() async {
    final token = SharedPrefHelper.getData(SharedPrefKeys.token);
    if (token == null) {
      emit(CartError(AppStrings.pleaseLogin.tr()));
      return;
    }

    emit(CartLoading());
    try {
      final response = await _apiService.getData(endpoint: Endpoints.cart);
      _handleCartResponse(response.data);
    } catch (e) {
      emit(CartError(ApiErrorHandler.getMessage(e).tr()));
    }
  }

  Future<void> addItem(String productId) async {
    _emitUpdating();
    try {
      final response = await _apiService.postData(
        endpoint: Endpoints.cart,
        data: {'productId': productId},
      );
      _handleCartResponse(response.data);
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
      _handleCartResponse(response.data);
    } catch (e) {
      _handleUpdateError(e);
    }
  }

  Future<void> updateProductQuantity(String productId, int count) async {
    if (count < 1) return;
    _emitUpdating();

    try {
      final response = await _apiService.putData(
        endpoint: '${Endpoints.cart}/$productId',
        data: {'count': count.toString()},
      );
      _handleCartResponse(response.data);
    } catch (e) {
      _handleUpdateError(e);
    }
  }

  Future<void> clearCart() async {
    emit(CartLoading());
    try {
      final response = await _apiService.deleteData(endpoint: Endpoints.cart);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _cartModel = CartModel(
          numOfCartItems: 0,
          data: CartData(products: [], totalCartPrice: 0),
        );
        emit(CartUpdated([], _cartModel!));
      } else {
        await getCart();
      }
    } catch (e) {
      emit(CartError(ApiErrorHandler.getMessage(e).tr()));
    }
  }

  void _handleCartResponse(Map<String, dynamic> data) {
    _cartModel = CartModel.fromJson(data);
    emit(CartUpdated(_cartModel?.data?.products ?? [], _cartModel!));
  }

  void _emitUpdating() {
    if (_cartModel != null) {
      emit(CartUpdating(_cartModel!));
    }
  }

  void _handleUpdateError(dynamic e) {
    emit(CartUpdateError(ApiErrorHandler.getMessage(e).tr()));
    if (_cartModel != null) {
      emit(CartUpdated(_cartModel?.data?.products ?? [], _cartModel!));
    }
  }

  void resetState() {
    _cartModel = null;
    emit(CartInitial());
  }
}
