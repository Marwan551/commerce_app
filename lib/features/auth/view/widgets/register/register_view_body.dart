import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_button.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_text_button.dart';
import 'package:commerce_app/core/utils/widgets/text_fields/custom_text_field.dart';
import 'package:commerce_app/core/utils/validation/app_validator.dart';
import 'package:commerce_app/features/auth/controllers/cubit/register/register_cubit.dart';
import 'package:commerce_app/features/auth/controllers/cubit/register/register_state.dart';
import 'package:commerce_app/features/auth/auth_navigation.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: cubit.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('create_account'.tr(), style: theme.textTheme.displayMedium),
            const SizedBox(height: 8),
            Text('lets_create'.tr(),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.secondary.withAlpha(200),
                )),
            const SizedBox(height: 32),
            CustomTextField(
              labelText: 'full_name'.tr(),
              hintText: 'full_name_hint'.tr(),
              controller: cubit.nameController,
              validator: AppValidator.validateFullName,
              onChanged: (_) => cubit.formKey.currentState?.validate(),
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'confirm_password'.tr(),
              hintText: 'confirm_password_hint'.tr(),
              controller: cubit.rePasswordController,
              isPassword: true,
              validator: (value) => AppValidator.validateConfirmPassword(
                value,
                cubit.passwordController.text,
              ),
              onChanged: (_) => cubit.formKey.currentState?.validate(),
            ),
            const SizedBox(height: 32),
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return CustomButton(
                  text: 'create_account'.tr(),
                  isLoading: state is RegisterLoading,
                  onPressed: () => cubit.register(),
                );
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'by_signing_up'.tr(),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.secondary.withAlpha(200),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('already_have_account'.tr(), style: theme.textTheme.bodyLarge),
                  CustomTextButton(
                    text: 'log_in'.tr(),
                    onPressed: () => AuthNavigation.navigateToLogin(),
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
