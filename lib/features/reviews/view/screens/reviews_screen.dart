import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/services/network_service/remote/base_client_service.dart';
import 'package:commerce_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:commerce_app/core/utils/widgets/loading/app_loading_indicator.dart';
import 'package:commerce_app/core/utils/widgets/toast/app_toast.dart';
import 'package:commerce_app/core/utils/constants/strings/app_strings.dart';
import 'package:commerce_app/features/home/models/product_model.dart';
import 'package:commerce_app/features/product_details/controllers/cubit/product_details_cubit.dart';
import 'package:commerce_app/features/product_details/controllers/cubit/product_details_state.dart';
import 'package:commerce_app/features/reviews/controllers/cubit/reviews_cubit.dart';
import 'package:commerce_app/features/reviews/controllers/cubit/reviews_state.dart';
import 'package:commerce_app/features/reviews/view/widgets/overall_rating_section.dart';
import 'package:commerce_app/features/reviews/view/widgets/ratings_breakdown_list.dart';
import 'package:commerce_app/features/reviews/view/widgets/review_item_widget.dart';
import 'package:commerce_app/features/cart/controllers/cubit/cart_cubit.dart';
import 'package:toastification/toastification.dart';

class ReviewsScreen extends StatelessWidget {
  final ProductData product;
  const ReviewsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ReviewsCubit(ApiService())..getProductReviews(product.id!),
        ),
        BlocProvider(
          create: (context) => ProductDetailsCubit(ApiService()),
        ),
      ],
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: const CustomAppBar(
          title: AppStrings.reviews,
          showBackButton: true,
        ),
        body: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
          listener: (context, state) {
            if (state is AddToCartSuccess) {
              context.read<CartCubit>().getCart();
              AppToast.show(context,
                  message: state.message, type: ToastificationType.success);
            } else if (state is AddToCartError) {
              AppToast.show(context,
                  message: state.message, type: ToastificationType.error);
            }
          },
          builder: (context, detailsState) {
            return Stack(
              children: [
                Positioned.fill(
                  child: BlocBuilder<ReviewsCubit, ReviewsState>(
                    builder: (context, state) {
                      if (state is ReviewsLoading) {
                        return const AppLoadingIndicator();
                      } else if (state is ReviewsSuccess) {
                        return ListView.builder(
                          padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
                          itemCount: state.reviews.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  OverallRatingSection(
                                    averageRating:
                                        product.ratingsAverage ?? 0.0,
                                    totalReviews: product.ratingsQuantity ?? 0,
                                  ),
                                  const SizedBox(height: 32),
                                  RatingsBreakdownList(
                                      percentages: state.ratingPercentages),
                                  const SizedBox(height: 48),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${state.totalReviews} ${AppStrings.reviews}',
                                        style: theme.textTheme.headlineMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              );
                            }
                            return ReviewItemWidget(
                                review: state.reviews[index - 1]);
                          },
                        );
                      } else if (state is ReviewsError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.error_outline,
                                  size: 80, color: Colors.red),
                              const SizedBox(height: 16),
                              Text(state.message, textAlign: TextAlign.center),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () => context
                                    .read<ReviewsCubit>()
                                    .getProductReviews(product.id!),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black),
                                child: const Text(AppStrings.retry,
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
