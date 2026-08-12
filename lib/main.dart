import 'package:flutter/material.dart';
import 'package:commerce_app/config/routing/app_router.dart';
import 'package:commerce_app/config/theming/app_theme.dart';
import 'package:commerce_app/core/services/network_service/local/shared_pref_service.dart';
import 'package:commerce_app/core/services/database/sqflite_helper.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/features/wishlist/controllers/cubit/wishlist_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper.init();
  await SqfliteHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishlistCubit(SqfliteHelper())..loadWishlistIds(),
      child: MaterialApp.router(
        title: 'E-commerce App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
