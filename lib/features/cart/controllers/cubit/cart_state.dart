import 'package:commerce_app/features/cart/models/cart_model.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartSuccess extends CartState {
  final CartModel cartModel;
  CartSuccess(this.cartModel);
}

final class CartError extends CartState {
  final String message;
  CartError(this.message);
}

final class CartUpdateError extends CartState {
  final String message;
  CartUpdateError(this.message);
}
