import 'package:flutter/material.dart';
import 'package:commerce_app/features/home/models/brand_model.dart';
import 'brand_item.dart';

class BrandGridView extends StatelessWidget {
  final List<BrandData> brands;
  const BrandGridView({super.key, required this.brands});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.5,
      ),
      itemCount: brands.length,
      itemBuilder: (context, index) {
        return BrandItem(brand: brands[index]);
      },
    );
  }
}
