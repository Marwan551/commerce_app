import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/features/cart/controllers/cubit/cart_cubit.dart';
import 'package:commerce_app/features/cart/models/cart_model.dart';
import 'cart_item_widget.dart';
import 'cart_empty_state.dart';
import 'summary_widget.dart';
import 'checkout_section.dart';

class CartViewBody extends StatelessWidget {
  final CartModel cartModel;

  const CartViewBody({super.key, required this.cartModel});

  @override
  Widget build(BuildContext context) {
    final cart = cartModel.data;
    if (cart == null || cart.products == null || cart.products!.isEmpty) {
      return const CartEmptyState();
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cart.products!.length,
            itemBuilder: (context, index) {
              final cartProduct = cart.products![index];
              return CartItemWidget(
                cartProduct: cartProduct,
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
        buildSummarySection(context, cart.totalCartPrice ?? 0),
        buildCheckoutSection(context),
      ],
    );
  }
}
