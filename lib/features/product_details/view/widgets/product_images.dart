import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/features/wishlist/controllers/cubit/wishlist_cubit.dart';
import 'package:commerce_app/features/home/models/product_model.dart';

class ProductImagesSlider extends StatefulWidget {
  final ProductData product;
  const ProductImagesSlider({super.key, required this.product});

  @override
  State<ProductImagesSlider> createState() => _ProductImagesSliderState();
}

class _ProductImagesSliderState extends State<ProductImagesSlider> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final images = widget.product.images ?? [widget.product.imageCover ?? ''];
    final bool isFavorite = context.watch<WishlistCubit>().isFavorite(widget.product.id!);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 400,
              child: PageView.builder(
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: images[index],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: theme.colorScheme.secondary,
                      highlightColor: theme.colorScheme.secondary.withAlpha(100),
                      child: Container(color: AppColors.whiteFFFFFF),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: GestureDetector(
              onTap: () => context.read<WishlistCubit>().toggleFavorite(widget.product),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                      : ColorFilter.mode(theme.colorScheme.primary, BlendMode.srcIn),
                  width: 22,
                  height: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
