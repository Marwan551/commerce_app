import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/features/cart/controllers/cubit/cart_cubit.dart';
import 'package:commerce_app/features/cart/models/cart_model.dart';
import 'cart_item_widget.dart';
import 'summary_widget.dart';
import 'checkout_section.dart';

class CartViewBody extends StatelessWidget {
  final CartModel cartModel;
  final bool isUpdating;

  const CartViewBody({
    super.key,
    required this.cartModel,
    this.isUpdating = false,
  });

  @override
  Widget build(BuildContext context) {
    final cart = cartModel.data;
    final products = cart?.products ?? [];

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final cartProduct = products[index];
              return CartItemWidget(
                cartProduct: cartProduct,
                isUpdating: isUpdating,
                onQuantityChanged: (count) {
                  context.read<CartCubit>().updateProductQuantity(
                        cartProduct.product?.id ?? '',
                        count,
                      );
                },
                onRemove: () {
                  context.read<CartCubit>().removeCartItem(
                        cartProduct.product?.id ?? '',
                      );
                },
              );
            },
          ),
        ),
        buildSummarySection(context, cart?.totalCartPrice ?? 0),
        buildCheckoutSection(context),
      ],
    );
  }
}
