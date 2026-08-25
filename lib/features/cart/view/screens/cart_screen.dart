import 'package:commerce_app/core/utils/constants/strings/app_strings.dart';
import 'package:commerce_app/core/utils/navigation/screen_navigation.dart';
import 'package:commerce_app/features/cart/view/widgets/cart_body.dart';
import 'package:commerce_app/features/cart/view/widgets/cart_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:commerce_app/core/utils/widgets/toast/app_toast.dart';
import 'package:commerce_app/core/utils/widgets/loading/blurry_loading_overlay.dart';
import 'package:toastification/toastification.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:commerce_app/features/cart/controllers/cubit/cart_cubit.dart';
import 'package:commerce_app/features/cart/controllers/cubit/cart_state.dart';

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
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: AppStrings.myCart.tr(),
        showBackButton: true,
        onBackTap: () {
          ScreenNavigation.navigateToHome(context);
        },
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartUpdateError) {
              AppToast.show(context,
                  message: state.message.tr(), type: ToastificationType.error);
            }
          },
          builder: (context, state) {
            return BlurryLoadingOverlay(
              isLoading: state is CartLoading || state is CartUpdating,
              child: _buildBody(state),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(CartState state) {
    if (state is CartUpdated) {
      return CartBody(cartModel: state.cartModel);
    } else if (state is CartUpdating) {
      return CartBody(cartModel: state.cartModel, isUpdating: true);
    } else if (state is CartError) {
      return Center(child: Text(state.message));
    } else if (state is CartLoading) {
      return const SizedBox.shrink();
    }
    return const CartEmptyState();
  }
}
