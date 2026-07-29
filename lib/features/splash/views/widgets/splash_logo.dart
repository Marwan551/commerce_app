import 'package:flutter/material.dart';
import '../../../../core/Utils/Constants/assets/assets.gen.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Assets.images.imgs.vector.svg(
      width: 134,
      height: 133,
    );
  }
}
