import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_button.dart';
import 'package:commerce_app/core/utils/widgets/text_fields/custom_text_field.dart';
import 'package:commerce_app/core/utils/validation/app_validator.dart';
import 'package:commerce_app/features/auth/controllers/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:commerce_app/features/auth/controllers/cubit/forgot_password/forgot_password_state.dart';

class ResetPasswordViewBody extends StatelessWidget {
  const ResetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: cubit.resetPasswordFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('reset_password'.tr(), style: theme.textTheme.displayMedium),
            const SizedBox(height: 8),
            Text(
              'reset_password_msg'.tr(),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.secondary.withAlpha(200),
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'password'.tr(),
              hintText: 'new_password_hint'.tr(),
              controller: cubit.passwordController,
              isPassword: true,
              validator: AppValidator.validatePassword,
              onChanged: (_) {
                cubit.resetPasswordFormKey.currentState?.validate();
              },
            ),
            const SizedBox(height: 2),
            CustomTextField(
              labelText: 'confirm_password'.tr(),
              hintText: 'confirm_password_hint'.tr(),
              controller: cubit.confirmPasswordController,
              isPassword: true,
              validator: (value) => AppValidator.validateConfirmPassword(
                value,
                cubit.passwordController.text,
              ),
              onChanged: (_) {
                cubit.resetPasswordFormKey.currentState?.validate();
              },
            ),
            const Spacer(),
            BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
              builder: (context, state) {
                return CustomButton(
                  text: 'continue_btn'.tr(),
                  isLoading: state is ResetPasswordLoading,
                  onPressed: () {
                    cubit.resetPassword();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
