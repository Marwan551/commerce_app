import 'package:flutter/material.dart';
import 'package:commerce_app/config/routing/app_router.dart';
import 'package:commerce_app/config/theming/app_theme.dart';
import 'package:commerce_app/core/services/network_service/local/shared_pref_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'E-commerce App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
