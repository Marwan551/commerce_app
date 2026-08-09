import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/services/remote/base_client_service.dart';
import 'package:commerce_app/core/utils/widgets/toast/app_toast.dart';
import 'package:commerce_app/core/utils/constants/strings/app_strings.dart';
import 'package:commerce_app/features/home/controllers/cubit/home_cubit.dart';
import 'package:commerce_app/features/home/controllers/cubit/home_state.dart';
import 'package:commerce_app/features/home/view/widgets/home_view_body.dart';
import 'package:commerce_app/features/home/view/widgets/home_shimmer_loading.dart';
import 'package:toastification/toastification.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(ApiService())..getHomeData(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is HomeError) {
                AppToast.show(
                  context,
                  message: state.message,
                  type: ToastificationType.error,
                );
              }
            },
            builder: (context, state) {
              final cubit = context.read<HomeCubit>();
              if (state is HomeLoading) {
                return const HomeShimmerLoading();
              } else if (state is HomeSuccess) {
                return HomeViewBody(
                  categories: state.categories,
                  products: state.products,
                  currentPage: state.currentPage,
                  totalPageCount: state.totalPageCount,
                  selectedCategoryId: state.selectedCategoryId,
                  sortBy: state.sortBy,
                  minPrice: state.minPrice,
                  maxPrice: state.maxPrice,
                  isFetching: state.isFetching,
                  onSearchChanged: cubit.updateSearch,
                  onCategorySelected: cubit.selectCategory,
                  onPageChanged: cubit.changePage,
                  onFiltersApplied: (sortBy, min, max) => cubit.applyFilters(
                    sortBy: sortBy,
                    minPrice: min,
                    maxPrice: max,
                  ),
                );
              } else if (state is HomeError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 80, color: Colors.red),
                      const SizedBox(height: 16),
                      const Text(AppStrings.somethingWentWrong),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => cubit.getHomeData(),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                        child: const Text(AppStrings.retry, style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
