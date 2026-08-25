import 'package:commerce_app/core/utils/widgets/loading/blurry_loading_overlay.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/services/network_service/remote/base_client_service.dart';
import 'package:commerce_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:commerce_app/core/utils/widgets/toast/app_toast.dart';
import 'package:commerce_app/features/home/models/product_model.dart';
import 'package:commerce_app/features/product_details/controllers/cubit/product_details_cubit.dart';
import 'package:commerce_app/features/product_details/controllers/cubit/product_details_state.dart';
import 'package:commerce_app/features/product_details/view/widgets/product_images.dart';
import 'package:commerce_app/features/product_details/view/widgets/product_info_section.dart';
import 'package:commerce_app/features/product_details/view/widgets/product_attributes_section.dart';
import 'package:commerce_app/features/product_details/view/widgets/sticky_bottom_action_bar.dart';
import 'package:commerce_app/core/utils/navigation/screen_navigation.dart';
import 'package:commerce_app/features/cart/controllers/cubit/cart_cubit.dart';
import 'package:toastification/toastification.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductData product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDetailsCubit(ApiService())..getProductDetails(product.id!),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, cartState) {
          return BlurryLoadingOverlay(
            isLoading: cartState is CartLoading || cartState is CartUpdating,
            child: MultiBlocListener(
              listeners: [
                BlocListener<CartCubit, CartState>(
                  listener: (context, state) {
                    if (state is CartActionSuccess) {
                      AppToast.show(context,
                          message: state.message.tr(),
                          type: ToastificationType.success);
                    } else if (state is CartUpdateError) {
                      AppToast.show(context,
                          message: state.message.tr(), type: ToastificationType.error);
                    }
                  },
                ),
              ],
              child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                builder: (context, state) {
                  ProductData currentProduct = product;

                  if (state is ProductDetailsSuccess) {
                    currentProduct = state.product;
                  }

                  return Scaffold(
                    appBar: CustomAppBar(
                      title: 'details'.tr(),
                      showBackButton: true,
                    ),
                    body: Stack(
                      children: [
                        Positioned.fill(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.only(bottom: 100),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProductImagesSlider(product: currentProduct),
                                const SizedBox(height: 24),
                                ProductInfoSection(
                                  product: currentProduct,
                                  onReviewsTap: () {
                                    ScreenNavigation.navigateToReviews(
                                        currentProduct);
                                  },
                                ),
                                const SizedBox(height: 24),
                                ProductAttributesSection(product: currentProduct),
                                const SizedBox(height: 24),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: StickyBottomActionBar(
                            price: currentProduct.price ?? 0,
                            onAddToCart: () => context
                                .read<CartCubit>()
                                .addItem(currentProduct.id!),
                            isAddingToCart: cartState is CartLoading || cartState is CartUpdating,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
