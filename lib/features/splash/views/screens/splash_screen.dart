import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/features/splash/controllers/cubit/splash_cubit.dart';
import 'package:commerce_app/features/splash/views/navigation/screen_navigation.dart';
import 'package:commerce_app/features/splash/views/widgets/splash_view_body.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..startTimer(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is Authenticated) {
            ScreenNavigation.navigateToHome();
          } else if (state is Unauthenticated) {
            ScreenNavigation.navigateToLogin();
          }
        },
        child: const SplashViewBody(),
      ),
    );
  }
}
