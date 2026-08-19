import 'package:commerce_app/core/utils/navigation/screen_navigation.dart';
import 'package:commerce_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/utils/widgets/toast/app_toast.dart';
import 'package:commerce_app/features/cart/controllers/cubit/cart_cubit.dart';
import 'package:commerce_app/features/cart/controllers/cubit/cart_state.dart';
import 'package:commerce_app/features/cart/view/widgets/cart_view_body.dart';
import 'package:commerce_app/features/cart/view/widgets/cart_shimmer_loading.dart';
import 'package:toastification/toastification.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Cart',
        showBackButton: true,
        onBackTap: () {
          ScreenNavigation.navigateToHome();
        },
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartUpdateError) {
            AppToast.show(context, message: state.message, type: ToastificationType.error);
          }
        },
        builder: (context, state) {
          if (state is CartLoading) {
            return const CartShimmerLoading();
          } else if (state is CartSuccess) {
            return CartViewBody(cartModel: state.cartModel);
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
