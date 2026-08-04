import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/constants/assets/assets.gen.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/core/utils/widgets/loading_animation.dart';
import 'package:commerce_app/features/splash/view/widgets/splash_logo.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black1A1A1A,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Assets.images.imgs.waves.svg(
              fit: BoxFit.cover,
            ),
          ),
          const Center(
            child: SplashLogo(),
          ),
          const Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: LoadingAnimation(),
            ),
          ),
        ],
      ),
    );
  }
}
