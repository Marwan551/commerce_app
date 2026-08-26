import 'package:commerce_app/core/services/network_service/local/shared_pref_service.dart';
import 'package:commerce_app/core/utils/constants/assets/assets.gen.dart';
import 'package:commerce_app/core/utils/constants/strings/app_strings.dart';
import 'package:commerce_app/core/utils/widgets/dividers/custom_divider.dart';
import 'package:commerce_app/core/utils/widgets/loading/blurry_loading_overlay.dart';
import 'package:commerce_app/features/account/controllers/cubit/language_cubit.dart';
import 'package:commerce_app/features/account/controllers/cubit/language_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:commerce_app/core/utils/navigation/screen_navigation.dart';
import 'package:commerce_app/features/account/view/widgets/logout_dialog.dart';
import 'package:commerce_app/features/account/view/widgets/build_account_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => LogoutDialog(
        onLogout: () async {
          await SharedPrefHelper.clearAllData();
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
        final isArabic = state.locale.languageCode == AppStrings.arTrans;
        return Scaffold(
          appBar: CustomAppBar(
            title: AppStrings.account.tr(),
            showBackButton: false,
          ),
          body: BlurryLoadingOverlay(
            isLoading: state is LanguageChanging,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  buildAccountOption(
                    context,
                    svg: Assets.images.imgs.language,
                    title: AppStrings.language.tr(),
                    trailing: Text(
                      isArabic ? AppStrings.arabic.tr() : AppStrings.english.tr(),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.grey707070,
                      ),
                    ),
                    onTap: () {
                      final newLocale =
                          isArabic ? const Locale(AppStrings.enTrans) : const Locale(AppStrings.arTrans);
                      context.read<LanguageCubit>().changeLanguage(
                            newLocale,
                            context.setLocale,
                          );
                    },
                  ),
                  const CustomDivider(
                    height: 0,
                    indent: 30,
                    endIndent: 30,
                  ),
                  buildAccountOption(
                    context,
                    svg: Assets.images.imgs.logout,
                    title: AppStrings.logout.tr(),
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
