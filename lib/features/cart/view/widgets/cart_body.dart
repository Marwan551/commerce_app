import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/features/cart/controllers/cubit/cart_cubit.dart';
import 'package:commerce_app/features/cart/models/cart_model.dart';
import 'cart_item.dart';
import 'summary_section.dart';
import 'checkout_section.dart';

class CartBody extends StatelessWidget {
  final CartModel cartModel;
  final bool isUpdating;

  const CartBody({
    super.key,
    required this.cartModel,
    this.isUpdating = false,
  });

  @override
  Widget build(BuildContext context) {
    final products = cartModel.data?.products ?? [];
    final cart = cartModel.data;

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: products.length + 1,
            itemBuilder: (context, index) {
              if (index == products.length) {
                return SummarySection(
                  totalCartPrice: cart?.totalCartPrice ?? 0,
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
                  context.read<CartCubit>().removeItem(
                        cartProduct.product?.id ?? '',
                      );
                },
              );
            },
          ),
        ),
        CheckoutSection(itemCount: products.length),
      ],
    );
  }
}
