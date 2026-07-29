import 'package:flutter/material.dart';

import '../Constants/assets/assets.gen.dart';

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
