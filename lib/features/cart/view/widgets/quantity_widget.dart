import 'package:commerce_app/core/utils/constants/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:commerce_app/features/cart/view/widgets/quantity_button.dart';

class QuantitySelect extends StatelessWidget {
  final int count;
  final bool isUpdating;
  final TextEditingController controller;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final Function(String) onSubmitted;

  const QuantitySelect({
    super.key,
    required this.count,
    required this.isUpdating,
    required this.controller,
    required this.onIncrement,
    required this.onDecrement,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        QuantityButton(
          svg: Assets.images.imgs.minus,
          onPressed: onDecrement,
          enabled: !isUpdating,
        ),
        const Padding(padding: EdgeInsets.only(left: 10)),
        SizedBox(
          width: 35,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            enabled: !isUpdating,
            style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
            onSubmitted: onSubmitted,
            onTapOutside: (_) => onSubmitted(controller.text),
          ),
        ),
        const Padding(padding: EdgeInsets.only(left: 10)),
        QuantityButton(
          svg: Assets.images.imgs.plus,
          onPressed: onIncrement,
          enabled: !isUpdating,
        ),
      ],
    );
  }
}
