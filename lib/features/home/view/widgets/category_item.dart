import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:commerce_app/features/home/models/category_model.dart';
import 'package:commerce_app/core/utils/constants/styles/app_text_styles.dart';

class CategoryItem extends StatelessWidget {
  final CategoryData category;
  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: category.image ?? '',
          imageBuilder: (context, imageProvider) => CircleAvatar(
            radius: 40,
            backgroundImage: imageProvider,
            backgroundColor: Colors.transparent,
          ),
          placeholder: (context, url) => CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[200],
          ),
          errorWidget: (context, url, error) => const CircleAvatar(
            radius: 40,
            child: Icon(Icons.error),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          category.name ?? '',
          style: AppTextStyles.medium14,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
