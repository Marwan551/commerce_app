import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/constants/assets/assets.gen.dart';

class LoadingAnimation extends StatelessWidget {
  final double? width;
  final double? height;

  const LoadingAnimation({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Assets.images.animations.loading.lottie(
      width: width ?? 200,
      height: height ?? 200,
    );
  }
}
