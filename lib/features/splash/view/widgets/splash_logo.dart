import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/constants/assets/assets.gen.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Assets.images.imgs.appLogo.svg(
      width: 134,
      height: 133,
    );
  }
}
