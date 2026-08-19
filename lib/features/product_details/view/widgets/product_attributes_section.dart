import 'package:flutter/material.dart';
import 'package:commerce_app/features/home/models/product_model.dart';

class ProductAttributesSection extends StatelessWidget {
  final ProductData product;

  const ProductAttributesSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text('Category', style: theme.textTheme.headlineMedium),
          ),
          _attributeChip(context, product.category?.name ?? 'N/A'),

          Padding(
            padding: const EdgeInsetsDirectional.only(top: 24,bottom: 12),
            child: Text('Brand', style: theme.textTheme.headlineMedium),
          ),

          _attributeChip(context, product.brand?.name ?? 'N/A'),
        ],
      ),
    );
  }

  Widget _attributeChip(BuildContext context, String label, {bool isSelected = false}) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? theme.colorScheme.primary : theme.colorScheme.surface,
        border: Border.all(color: theme.colorScheme.secondary),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: theme.textTheme.titleMedium?.copyWith(
          color: isSelected
              ? theme.colorScheme.onPrimary
              : theme.colorScheme.primary,
        ),
      ),
    );
  }
}
