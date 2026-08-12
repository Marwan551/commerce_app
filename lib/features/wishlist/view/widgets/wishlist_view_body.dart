import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/features/home/models/product_model.dart';
import 'package:commerce_app/features/wishlist/controllers/cubit/wishlist_cubit.dart';
import 'wishlist_item.dart';
import 'wishlist_empty_state.dart';

class WishlistViewBody extends StatelessWidget {
  final List<ProductData> wishlistItems;

  const WishlistViewBody({super.key, required this.wishlistItems});

  @override
  Widget build(BuildContext context) {
    if (wishlistItems.isEmpty) {
      return const WishlistEmptyState();
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemCount: wishlistItems.length,
      itemBuilder: (context, index) {
        final product = wishlistItems[index];
        return WishlistItem(
          product: product,
          onRemove: () => context.read<WishlistCubit>().toggleFavorite(product),
        );
      },
    );
  }
}
