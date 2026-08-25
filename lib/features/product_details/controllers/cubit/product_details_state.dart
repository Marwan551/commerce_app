import 'package:commerce_app/features/home/models/product_model.dart';

sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsSuccess extends ProductDetailsState {
  final ProductData product;
  ProductDetailsSuccess(this.product);
}

final class ProductDetailsError extends ProductDetailsState {
  final String message;
  ProductDetailsError(this.message);
}
