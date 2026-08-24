import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:commerce_app/core/utils/widgets/loading/blurry_loading_overlay.dart';
import 'package:commerce_app/features/wishlist/controllers/cubit/wishlist_cubit.dart';
import 'package:commerce_app/features/wishlist/controllers/cubit/wishlist_state.dart';
import 'package:commerce_app/core/utils/navigation/screen_navigation.dart';
import 'package:commerce_app/features/wishlist/view/widgets/wishlist_view_body.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WishlistCubit>().getWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.tr('saved_items'),
        showBackButton: true,
        onBackTap: () {
          ScreenNavigation.navigateToHome(context);
        },
      ),
      body: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          return BlurryLoadingOverlay(
            isLoading: state is WishlistLoading,
            child: _buildBody(state),
          );
        },
      ),
    );
  }

  Widget _buildBody(WishlistState state) {
    if (state is WishlistSuccess) {
      return WishlistViewBody(wishlistItems: state.wishlistItems);
    } else if (state is WishlistError) {
      return Center(child: Text(state.message));
    } else if (state is WishlistLoading) {
      return const SizedBox.shrink(); // Show nothing behind the blur initially
    }
    return const SizedBox.shrink();
  }
}
