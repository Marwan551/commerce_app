import 'package:easy_localization/easy_localization.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/services/network_service/remote/base_client_service.dart';
import 'package:commerce_app/core/utils/widgets/toast/app_toast.dart';
import 'package:commerce_app/features/home/controllers/cubit/home_cubit.dart';
import 'package:commerce_app/features/home/controllers/cubit/home_state.dart';
import 'package:commerce_app/features/home/view/widgets/home_view_body.dart';
import 'package:commerce_app/core/utils/widgets/loading/blurry_loading_overlay.dart';
import 'package:toastification/toastification.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(ApiService())..getHomeData(),
      child: Scaffold(
        backgroundColor: AppColors.whiteFFFFFF,
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is HomeError) {
                  AppToast.show(
                    context,
                    message: state.message.tr(),
                    type: ToastificationType.error,
                  );
                }
              },
              builder: (context, state) {
                final cubit = context.read<HomeCubit>();
                return BlurryLoadingOverlay(
                  isLoading: state is HomeLoading || (state is HomeSuccess && state.isFetching),
                  child: _buildBody(context, state, cubit),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeState state, HomeCubit cubit) {
    if (state is HomeSuccess) {
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
            Text('somethingWentWrong'.tr()),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => cubit.getHomeData(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: Text('retry'.tr(),
                  style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
