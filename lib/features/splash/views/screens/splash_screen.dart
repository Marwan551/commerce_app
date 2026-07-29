import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controllers/cubit/splash_cubit.dart';
import '../navigation/screen_navigation.dart';
import '../widgets/SplashViewBody.dart';
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
