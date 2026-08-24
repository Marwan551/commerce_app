import 'package:commerce_app/core/utils/constants/assets/assets.gen.dart';
import 'package:flutter/material.dart';

class QuantityButton extends StatelessWidget {
  final SvgGenImage svg;
  final VoidCallback onPressed;
  final bool enabled;

  const QuantityButton({
    super.key,
    required this.svg,
    required this.onPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onPressed : null,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.5,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: svg.svg(width: 15, height: 15),
        ),
      ),
    );
  }
}
