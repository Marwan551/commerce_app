import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:commerce_app/features/home/models/product_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/features/wishlist/controllers/cubit/wishlist_cubit.dart';
import 'package:commerce_app/features/wishlist/controllers/cubit/wishlist_state.dart';
import 'package:commerce_app/core/utils/navigation/screen_navigation.dart';

class ProductItem extends StatelessWidget {
  final ProductData product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        final bool isFavorite =
            context.read<WishlistCubit>().isFavorite(product.id!);
        return GestureDetector(
          onTap: () => ScreenNavigation.navigateToProductDetails(product),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: CachedNetworkImage(
                      imageUrl: product.imageCover ?? '',
                      height: 185,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        height: 185,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary.withAlpha(50),
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () =>
                          context.read<WishlistCubit>().toggleFavorite(product),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(20),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          isFavorite
                              ? 'assets/images/imgs/red_heart.svg'
                              : 'assets/images/imgs/Heart.svg',
                          colorFilter: isFavorite
                              ? null
                              : ColorFilter.mode(
                                  theme.colorScheme.primary, BlendMode.srcIn),
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                product.title ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.displaySmall,
              ),
              const SizedBox(height: 4),
              Text(
                '\$ ${product.price}',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.textTheme.bodyLarge?.color?.withAlpha(180),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
