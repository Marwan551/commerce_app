import 'package:commerce_app/core/services/database/sqflite_helper.dart';
import 'package:commerce_app/core/services/network_service/local/shared_pref_service.dart';
import 'package:commerce_app/core/utils/constants/assets/assets.gen.dart';
import 'package:commerce_app/core/utils/widgets/loading/blurry_loading_overlay.dart';
import 'package:commerce_app/features/account/controllers/cubit/language_cubit.dart';
import 'package:commerce_app/features/account/controllers/cubit/language_state.dart';
import 'package:commerce_app/features/cart/controllers/cubit/cart_cubit.dart';
import 'package:commerce_app/features/wishlist/controllers/cubit/wishlist_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:commerce_app/core/utils/navigation/screen_navigation.dart';
import 'package:commerce_app/features/account/view/widgets/logout_dialog.dart';
import 'package:commerce_app/features/account/view/widgets/build_option.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => LogoutDialog(
        onLogout: () async {
          await context.read<CartCubit>().clearCart();
          context.read<CartCubit>().resetState();
          context.read<WishlistCubit>().resetState();
          await SharedPrefHelper.clearAllData();
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
    final theme = Theme.of(context);

    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        final isArabic = state.locale.languageCode == 'ar';
        return Scaffold(
          appBar: CustomAppBar(
            title: 'account'.tr(),
            showBackButton: false,
          ),
          body: BlurryLoadingOverlay(
            isLoading: state is LanguageChanging,
            child: SingleChildScrollView(
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
                      final newLocale =
                          isArabic ? const Locale('en') : const Locale('ar');
                      context.read<LanguageCubit>().changeLanguage(
                            newLocale,
                            context.setLocale,
                          );
                    },
                  ),
                  const Divider(
                    height: 0,
                    color: AppColors.greyFFE6E6E6,
                    indent: 30,
                    endIndent: 30,
                  ),
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
          ),
        );
      },
    );
  }
}
