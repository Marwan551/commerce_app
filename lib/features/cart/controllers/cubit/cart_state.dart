import 'package:commerce_app/features/cart/models/cart_model.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartUpdated extends CartState {
  final List<CartProduct> items;
  final CartModel cartModel;
  CartUpdated(this.items, this.cartModel);
}

final class CartError extends CartState {
  final String message;
  CartError(this.message);
}

final class CartUpdating extends CartState {
  final CartModel cartModel;
  CartUpdating(this.cartModel);
}

final class CartUpdateError extends CartState {
  final String message;
  CartUpdateError(this.message);
}
