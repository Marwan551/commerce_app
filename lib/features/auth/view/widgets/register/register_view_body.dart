import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_button.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_text_button.dart';
import 'package:commerce_app/core/utils/widgets/text_fields/custom_text_field.dart';
import 'package:commerce_app/core/utils/constants/styles/app_text_styles.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/features/auth/controllers/cubit/register/register_cubit.dart';
import 'package:commerce_app/features/auth/controllers/cubit/register/register_state.dart';
import 'package:commerce_app/features/auth/models/request/register_request_model.dart';
import 'package:commerce_app/core/utils/navigation/screen_navigation.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final isNameValid = CustomTextField.validateFullName(_nameController.text) == null;
    final isEmailValid = CustomTextField.validateEmail(_emailController.text) == null;
    final isPasswordValid = CustomTextField.validatePassword(_passwordController.text) == null;

    setState(() {
      _isButtonEnabled = isNameValid && isEmailValid && isPasswordValid;
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
            const Text('Create an account', style: AppTextStyles.bold24),
            const SizedBox(height: 8),
            Text('Let\'s create your account.',
                style: AppTextStyles.regular16.copyWith(color: AppColors.greyB3B3B3)),
            const SizedBox(height: 32),
            CustomTextField(
              labelText: 'Full Name',
              hintText: 'Enter your full name',
              controller: _nameController,
              validator: CustomTextField.validateFullName,
              onChanged: (_) => _validateForm(),
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 32),
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return CustomButton(
                  text: 'Create an Account',
                  isLoading: state is RegisterLoading,
                  onPressed: _isButtonEnabled
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            context.read<RegisterCubit>().register(
                                  RegisterRequestModel(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    rePassword: _passwordController.text,
                                    phone: '01234567890',
                                  ),
                                );
                          }
                        }
                      : null,
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
            const SizedBox(height: 24),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?', style: AppTextStyles.regular16),
                  CustomTextButton(
                    text: 'Log In',
                    onPressed: () => ScreenNavigation.navigateToLogin(),
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
