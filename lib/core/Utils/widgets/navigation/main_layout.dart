import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/features/home/view/screens/home_screen.dart';
import 'package:commerce_app/features/account/view/screens/account_screen.dart';
import 'package:commerce_app/features/cart/controllers/cubit/cart_cubit.dart';
import 'package:commerce_app/features/cart/view/screens/cart_screen.dart';
import 'package:commerce_app/features/wishlist/view/screens/wishlist_screen.dart';
import 'package:commerce_app/features/wishlist/controllers/cubit/wishlist_cubit.dart';
import 'package:easy_localization/easy_localization.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final String localeKey = context.locale.toString();
    final List<Widget> screens = [
      HomeScreen(key: ValueKey('home_$localeKey')),
      Center(child: Text('search'.tr(), key: ValueKey('search_$localeKey'))),
      WishlistScreen(key: ValueKey('wishlist_$localeKey')),
      CartScreen(key: ValueKey('cart_$localeKey')),
      AccountScreen(key: ValueKey('account_$localeKey')),
    ];

    return Scaffold(
      body: IndexedStack(
        key: ValueKey('stack_$localeKey'),
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) {
            context.read<WishlistCubit>().getWishlist();
          } else if (index == 3) {
            context.read<CartCubit>().getCart();
          }
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.black1A1A1A,
        unselectedItemColor: AppColors.grey707070,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/imgs/home_icon.svg',
              colorFilter: const ColorFilter.mode(AppColors.grey707070, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/images/imgs/home_icon.svg',
              colorFilter: const ColorFilter.mode(AppColors.black1A1A1A, BlendMode.srcIn),
            ),
            label: 'home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/imgs/search_icon.svg',
              colorFilter: const ColorFilter.mode(AppColors.grey707070, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/images/imgs/search_icon.svg',
              colorFilter: const ColorFilter.mode(AppColors.black1A1A1A, BlendMode.srcIn),
            ),
            label: 'search'.tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/imgs/saved_icon.svg',
              colorFilter: const ColorFilter.mode(AppColors.grey707070, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/images/imgs/saved_icon.svg',
              colorFilter: const ColorFilter.mode(AppColors.black1A1A1A, BlendMode.srcIn),
            ),
            label: 'saved_items'.tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/imgs/cart_icon.svg',
              colorFilter: const ColorFilter.mode(AppColors.grey707070, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/images/imgs/cart_icon.svg',
              colorFilter: const ColorFilter.mode(AppColors.black1A1A1A, BlendMode.srcIn),
            ),
            label: 'my_cart'.tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/imgs/account_icon.svg',
              colorFilter: const ColorFilter.mode(AppColors.grey707070, BlendMode.srcIn),
            ),
            activeIcon:
            SvgPicture.asset(
              'assets/images/imgs/account_icon.svg',
              colorFilter: const ColorFilter.mode(AppColors.black1A1A1A, BlendMode.srcIn),
            ),
            label: 'account'.tr(),
          ),
        ],
      ),
    );
  }
}
