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
            Text('Reset Password', style: theme.textTheme.displayMedium),
            const SizedBox(height: 8),
            Text(
              'Set the new password for your account so you can login and access all the features.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.secondary.withAlpha(200),
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Password',
              hintText: 'Enter new password',
              controller: cubit.passwordController,
              isPassword: true,
              validator: AppValidator.validatePassword,
              onChanged: (_) {
                cubit.resetPasswordFormKey.currentState?.validate();
              },
            ),
            const SizedBox(height: 2),
            CustomTextField(
              labelText: 'Confirm Password',
              hintText: 'Re-enter new password',
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
                  text: 'Continue',
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
