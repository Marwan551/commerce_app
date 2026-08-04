import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/constants/assets/assets.gen.dart';

class AppLoadingIndicator extends StatelessWidget {
  final double size;

  const AppLoadingIndicator({
    super.key,
    this.size = 150.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Assets.images.animations.loading.lottie(
        width: size,
        height: size,
      ),
    );
  }
}
