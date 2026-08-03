import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_button.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_text_button.dart';
import 'package:commerce_app/core/utils/widgets/text_fields/custom_text_field.dart';
import 'package:commerce_app/core/utils/constants/styles/app_text_styles.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/features/auth/controllers/cubit/login/login_cubit.dart';
import 'package:commerce_app/features/auth/controllers/cubit/login/login_state.dart';
import 'package:commerce_app/features/auth/models/request/login_request_model.dart';
import 'package:commerce_app/core/utils/navigation/screen_navigation.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final isEmailValid = CustomTextField.validateEmail(_emailController.text) == null;
    final isPasswordValid = CustomTextField.validatePassword(_passwordController.text) == null;

    setState(() {
      _isButtonEnabled = isEmailValid && isPasswordValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Login', style: AppTextStyles.bold24),
            const SizedBox(height: 8),
            Text('Welcome back! Please login to your account.',
                style: AppTextStyles.regular16.copyWith(color: AppColors.greyB3B3B3)),
            const SizedBox(height: 32),
            CustomTextField(
              labelText: 'Email',
              hintText: 'Enter your email address',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: CustomTextField.validateEmail,
              onChanged: (_) => _validateForm(),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Password',
              hintText: 'Enter your password',
              controller: _passwordController,
              isPassword: true,
              validator: CustomTextField.validatePassword,
              onChanged: (_) => _validateForm(),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: CustomTextButton(
                text: 'Forgot Password?',
                onPressed: () => ScreenNavigation.navigateToForgotPassword(),
                textStyle: AppTextStyles.regular16.copyWith(color: AppColors.black1A1A1A),
              ),
            ),
            const SizedBox(height: 32),
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                return CustomButton(
                  text: 'Login',
                  isLoading: state is LoginLoading,
                  onPressed: _isButtonEnabled
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            context.read<LoginCubit>().login(
                                  LoginRequestModel(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                          }
                        }
                      : null,
                );
              },
            ),
            const SizedBox(height: 24),
            const SizedBox(height: 24),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?', style: AppTextStyles.regular16),
                  CustomTextButton(
                    text: 'Join',
                    onPressed: () => ScreenNavigation.navigateToRegister(),
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
