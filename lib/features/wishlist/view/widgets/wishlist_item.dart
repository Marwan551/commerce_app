import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:commerce_app/features/home/models/product_model.dart';
import 'package:commerce_app/core/utils/constants/styles/app_text_styles.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';

class WishlistItem extends StatelessWidget {
  final ProductData product;
  final VoidCallback onRemove;

  const WishlistItem({
    super.key,
    required this.product,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: AppColors.greyB3B3B3,
                  highlightColor: AppColors.greyB3B3B3.withAlpha(100),
                  child: Container(color: AppColors.whiteFFFFFF),
                ),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(20),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: SvgPicture.asset(
                    'assets/images/imgs/red_heart.svg',
                    width: 15,
                    height: 15,
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
          style: AppTextStyles.bold20,
        ),
        const SizedBox(height: 4),
        Text(
          '\$ ${product.price}',
          style: AppTextStyles.regular18.copyWith(color: AppColors.grey707070),
        ),
      ],
    );
  }
}
