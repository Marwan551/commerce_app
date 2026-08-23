import 'package:commerce_app/core/utils/constants/assets/assets.gen.dart';
import 'package:commerce_app/features/cart/controllers/cubit/cart_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:commerce_app/core/services/database/sqflite_helper.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:commerce_app/core/utils/navigation/screen_navigation.dart';
import 'package:commerce_app/features/account/view/widgets/logout_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/features/account/view/widgets/build_option.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          LogoutDialog(
            onLogout: () async {
              await context.read<CartCubit>().clearCart();
              await SqfliteHelper.clear('wishlist');
              if (context.mounted) {
                Navigator.pop(context);
                ScreenNavigation.navigateToLogin();
              }
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'account'.tr(),
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            buildOption(
              context,
              svg: Assets.images.imgs.language,
              title: 'language'.tr(),
              trailing: Text(
                isArabic ? 'arabic'.tr() : 'english'.tr(),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.grey707070,
                ),
              ),
              onTap: () {
                if (isArabic) {
                  context.setLocale(const Locale('en'));
                } else {
                  context.setLocale(const Locale('ar'));
                }
              },
            ),
            const Divider(height: 0,
              color: AppColors.greyFFE6E6E6,
              indent: 30,
              endIndent: 30,),
            buildOption(
              context,
              svg: Assets.images.imgs.logout,
              title: 'logout'.tr(),
              titleColor: AppColors.redFFED1010,
              onTap: () => _showLogoutDialog(context),
            ),
          ],
        ),
      ),
    );
  }
}