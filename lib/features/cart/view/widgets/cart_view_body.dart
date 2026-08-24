import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/features/cart/controllers/cubit/cart_cubit.dart';
import 'package:commerce_app/features/cart/models/cart_model.dart';
import 'cart_item_widget.dart';
import 'summary_widget.dart';
import 'checkout_section.dart';
import 'cart_empty_state.dart';

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
    // final cart = cartModel.data;// ////////////////
    final products = cartModel.data?.products ?? [];
    
    if (products.isEmpty) {
      return const CartEmptyState();
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: products.length + 1,
            itemBuilder: (context, index) {
              if (index == products.length) {
                return buildSummarySection(
                  context,
                  totalCartPrice: cartModel.data?.totalCartPrice ?? 0,
                  itemCount: products.length,
                );
              }

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
        buildCheckoutSection(context, itemCount: products.length),
      ],
    );
  }
}
