import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_button.dart';
import 'package:commerce_app/core/utils/widgets/text_fields/custom_text_field.dart';
import 'package:commerce_app/core/utils/constants/styles/app_text_styles.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/features/auth/controllers/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:commerce_app/features/auth/controllers/cubit/forgot_password/forgot_password_state.dart';

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody({super.key});

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled = _passwordController.text.length >= 6 &&
          _passwordController.text == _confirmPasswordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Reset Password', style: AppTextStyles.bold24),
          const SizedBox(height: 8),
          Text(
            'Set the new password for your account so you can login and access all the features.',
            style: AppTextStyles.regular16.copyWith(color: AppColors.greyB3B3B3),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            labelText: 'Password',
            hintText: 'Enter new password',
            controller: _passwordController,
            isPassword: true,
            validator: CustomTextField.validatePassword,
            onChanged: (_) => _validateForm(),
          ),
          const SizedBox(height: 2),
          CustomTextField(
            labelText: 'Confirm Password',
            hintText: 'Re-enter new password',
            controller: _confirmPasswordController,
            isPassword: true,
            validator: (value) {
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
            onChanged: (_) => _validateForm(),
          ),
          const Spacer(),
          BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
            builder: (context, state) {
              return CustomButton(
                text: 'Continue',
                isLoading: state is ResetPasswordLoading,
                onPressed: _isButtonEnabled
                    ? () {
                        context.read<ForgotPasswordCubit>().resetPassword(
                              'placeholder@example.com', 
                              _passwordController.text,
                            );
                      }
                    : null,
              );
            },
          ),
        ],
      ),
    );
  }
}
