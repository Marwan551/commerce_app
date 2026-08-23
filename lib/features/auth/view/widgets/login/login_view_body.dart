import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_button.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_text_button.dart';
import 'package:commerce_app/core/utils/widgets/text_fields/custom_text_field.dart';
import 'package:commerce_app/core/utils/validation/app_validator.dart';
import 'package:commerce_app/features/auth/controllers/cubit/login/login_cubit.dart';
import 'package:commerce_app/features/auth/controllers/cubit/login/login_state.dart';
import 'package:commerce_app/features/auth/auth_navigation.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: cubit.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('login'.tr(), style: theme.textTheme.displayMedium),
            const SizedBox(height: 8),
            Text('welcome_back'.tr(),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.secondary.withAlpha(200),
                )),
            const SizedBox(height: 32),
            CustomTextField(
              labelText: 'email'.tr(),
              hintText: 'email_hint'.tr(),
              controller: cubit.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: AppValidator.validateEmail,
              onChanged: (_) => cubit.formKey.currentState?.validate(),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'password'.tr(),
              hintText: 'password_hint'.tr(),
              controller: cubit.passwordController,
              isPassword: true,
              validator: AppValidator.validatePassword,
              onChanged: (_) => cubit.formKey.currentState?.validate(),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: CustomTextButton(
                text: 'forgot_password_q'.tr(),
                onPressed: () => AuthNavigation.navigateToForgotPassword(),
                textStyle: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 32),
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                return CustomButton(
                  text: 'login'.tr(),
                  isLoading: state is LoginLoading,
                  onPressed: () => cubit.login(),
                );
              },
            ),
            const SizedBox(height: 24),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('dont_have_account'.tr(), style: theme.textTheme.bodyLarge),
                  CustomTextButton(
                    text: 'join'.tr(),
                    onPressed: () => AuthNavigation.navigateToRegister(),
                    textStyle: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
