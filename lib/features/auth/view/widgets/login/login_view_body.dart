import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_button.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_text_button.dart';
import 'package:commerce_app/core/utils/widgets/text_fields/custom_text_field.dart';
import 'package:commerce_app/core/utils/constants/styles/app_text_styles.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/core/utils/validation/app_validator.dart';
import 'package:commerce_app/features/auth/controllers/cubit/login/login_cubit.dart';
import 'package:commerce_app/features/auth/controllers/cubit/login/login_state.dart';
import 'package:commerce_app/features/auth/auth_navigation.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: cubit.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Login', style: AppTextStyles.bold24),
            const SizedBox(height: 8),
            Text('Welcome back! Please login to your account.',
                style: AppTextStyles.regular16.copyWith(color: AppColors.grey707070)),
            const SizedBox(height: 32),
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
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: CustomTextButton(
                text: 'Forgot Password?',
                onPressed: () => AuthNavigation.navigateToForgotPassword(),
                textStyle: AppTextStyles.regular16.copyWith(color: AppColors.black1A1A1A),
              ),
            ),
            const SizedBox(height: 32),
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                return CustomButton(
                  text: 'Login',
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
                  const Text('Don\'t have an account?', style: AppTextStyles.regular16),
                  CustomTextButton(
                    text: 'Join',
                    onPressed: () => AuthNavigation.navigateToRegister(),
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
