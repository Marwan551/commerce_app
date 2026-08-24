import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/features/splash/controllers/cubit/splash_cubit.dart';
import 'package:commerce_app/features/splash/splash_navigation.dart';
import 'package:commerce_app/features/splash/view/widgets/splash_view_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..startTimer(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is Authenticated) {
            SplashNavigation.navigateToHome(context);
          } else if (state is Unauthenticated) {
            SplashNavigation.navigateToLogin();
          }
        },
        child: const SplashViewBody(),
      ),
    );
  }
}
