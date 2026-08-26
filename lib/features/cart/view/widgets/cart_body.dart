import 'package:commerce_app/features/cart/view/widgets/delete_cart_item_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/features/cart/controllers/cubit/cart_cubit.dart';
import 'package:commerce_app/features/cart/models/cart_model.dart';
import 'cart_item.dart';
import 'summary_section.dart';
import 'checkout_section.dart';

class CartBody extends StatefulWidget {
  final CartModel cartModel;
  final bool isUpdating;

  const CartBody({
    super.key,
    required this.cartModel,
    this.isUpdating = false,
  });

  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> with WidgetsBindingObserver {
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = View.of(context).viewInsets.bottom;
    if (mounted) {
      setState(() {
        _isKeyboardVisible = bottomInset > 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = widget.cartModel.data?.products ?? [];
    final cart = widget.cartModel.data;

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                children: [
                  ...products.map((cartProduct) => CartItem(
                        key: ValueKey(cartProduct.product!.id),
                        cartProduct: cartProduct,
                        isUpdating: widget.isUpdating,
                        onQuantityChanged: (count) {
                          context.read<CartCubit>().updateQuantity(
                                cartProduct.product!.id!,
                                count,
                              );
                        },
                        onRemove: () {
                          showDialog(
                            context: context,
                            builder: (context) => DeleteCartItemDialog(
                              onConfirm: () {
                                context.read<CartCubit>().removeItem(
                                      cartProduct.product!.id!,
                                    );
                              },
                            ),
                          );
                        },
                      )),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _isKeyboardVisible ? 0.0 : 1.0,
                    child: SummarySection(
                      totalCartPrice: cart?.totalCartPrice ?? 0,
                      itemCount: products.length,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          bottom: _isKeyboardVisible ? -150 : 0,
          left: 0,
          right: 0,
          child: CheckoutSection(itemCount: products.length),
        ),
      ],
    );
  }
}
