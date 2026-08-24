import 'package:commerce_app/core/controllers/navigation_cubit/navigation_cubit.dart';
import 'package:commerce_app/core/utils/constants/strings/app_strings.dart';
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

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  final List<Widget> _screens = const [
    HomeScreen(),
    SearchPlaceholder(),
    WishlistScreen(),
    CartScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final String localeKey = context.locale.toString();

    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          body: IndexedStack(
            key: ValueKey('stack_$localeKey'),
            index: currentIndex,
            children: _screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              if (index == 2) {
                context.read<WishlistCubit>().getWishlist();
              } else if (index == 3) {
                context.read<CartCubit>().getCart();
              }
              context.read<NavigationCubit>().changeIndex(index);
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
                label: AppStrings.home.tr(),
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
                label: AppStrings.search.tr(),
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
                label: AppStrings.savedItems.tr(),
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
                label: AppStrings.myCart.tr(),
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
                label: AppStrings.account.tr(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SearchPlaceholder extends StatelessWidget {
  const SearchPlaceholder({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(AppStrings.search.tr()));
  }
}
