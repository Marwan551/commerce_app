import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/Utils/Constants/assets/assets.gen.dart';
import '../../../../core/Utils/Constants/color/app_colors.dart';
import '../../../../core/Utils/widgets/loading_animation.dart';
import '../../controllers/cubit/splash_cubit.dart';
import '../navigation/screen_navigation.dart';
import '../widgets/splash_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()
        ..startTimer(
          onSuccess: () => ScreenNavigation.navigateToHome(),
        ),
      child: const SplashViewBody(),
    );
  }
}

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
            child: Assets.images.imgs.group21.svg(
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
