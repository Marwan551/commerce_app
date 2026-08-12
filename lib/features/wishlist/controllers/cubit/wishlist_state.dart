import 'package:commerce_app/features/home/models/product_model.dart';

sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}

final class WishlistLoading extends WishlistState {}

final class WishlistSuccess extends WishlistState {
  final List<ProductData> wishlistItems;
  WishlistSuccess(this.wishlistItems);
}

final class WishlistError extends WishlistState {
  final String message;
  WishlistError(this.message);
}
