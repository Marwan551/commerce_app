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
            Text('Create an account', style: theme.textTheme.displayMedium),
            const SizedBox(height: 8),
            Text('Let\'s create your account.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.secondary.withAlpha(200),
                )),
            const SizedBox(height: 32),
            CustomTextField(
              labelText: 'Full Name',
              hintText: 'Enter your full name',
              controller: cubit.nameController,
              validator: AppValidator.validateFullName,
              onChanged: (_) => cubit.formKey.currentState?.validate(),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Email',
              hintText: 'Enter your email address',
              controller: cubit.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: AppValidator.validateEmail,
              onChanged: (_) => cubit.formKey.currentState?.validate(),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Password',
              hintText: 'Enter your password',
              controller: cubit.passwordController,
              isPassword: true,
              validator: AppValidator.validatePassword,
              onChanged: (_) => cubit.formKey.currentState?.validate(),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Confirm Password',
              hintText: 'Re-enter your password',
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
                  text: 'Create an Account',
                  isLoading: state is RegisterLoading,
                  onPressed: () => cubit.register(),
                );
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'By signing up you agree to our Terms, Privacy Policy, and Cookie Use',
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
                  Text('Already have an account?', style: theme.textTheme.bodyLarge),
                  CustomTextButton(
                    text: 'Log In',
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
