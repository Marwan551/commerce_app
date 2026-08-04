import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_button.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_text_button.dart';
import 'package:commerce_app/core/utils/widgets/text_fields/custom_text_field.dart';
import 'package:commerce_app/core/utils/constants/styles/app_text_styles.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/core/utils/validation/app_validator.dart';
import 'package:commerce_app/features/auth/controllers/cubit/register/register_cubit.dart';
import 'package:commerce_app/features/auth/controllers/cubit/register/register_state.dart';
import 'package:commerce_app/features/auth/auth_navigation.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: cubit.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Create an account', style: AppTextStyles.bold24),
            const SizedBox(height: 8),
            Text('Let\'s create your account.',
                style: AppTextStyles.regular16.copyWith(color: AppColors.greyB3B3B3)),
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
            const Center(
              child: Text(
                'By signing up you agree to our Terms, Privacy Policy, and Cookie Use',
                textAlign: TextAlign.center,
                style: AppTextStyles.regular16,
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?', style: AppTextStyles.regular16),
                  CustomTextButton(
                    text: 'Log In',
                    onPressed: () => AuthNavigation.navigateToLogin(),
                    textStyle: AppTextStyles.medium18.copyWith(
                      color: AppColors.black1A1A1A,
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
