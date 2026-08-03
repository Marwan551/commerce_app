import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_button.dart';
import 'package:commerce_app/core/utils/widgets/text_fields/custom_text_field.dart';
import 'package:commerce_app/core/utils/constants/styles/app_text_styles.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/features/auth/controllers/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:commerce_app/features/auth/controllers/cubit/forgot_password/forgot_password_state.dart';

class ForgotPasswordBody extends StatefulWidget {
  const ForgotPasswordBody({super.key});

  @override
  State<ForgotPasswordBody> createState() => _ForgotPasswordBodyState();
}

class _ForgotPasswordBodyState extends State<ForgotPasswordBody> {
  final _emailController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled = CustomTextField.validateEmail(_emailController.text) == null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Forgot password', style: AppTextStyles.bold24),
          const SizedBox(height: 8),
          Text(
            'Enter your email for the verification process. We will send a digits code to your email.',
            style: AppTextStyles.regular16.copyWith(color: AppColors.greyB3B3B3),
          ),
          const SizedBox(height: 32),
          CustomTextField(
            labelText: 'Email',
            hintText: 'Enter your email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: CustomTextField.validateEmail,
            onChanged: (_) => _validateForm(),
          ),
          const Spacer(),
          BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
            builder: (context, state) {
              return CustomButton(
                text: 'Send Code',
                isLoading: state is ForgotPasswordLoading,
                onPressed: _isButtonEnabled
                    ? () {
                        context
                            .read<ForgotPasswordCubit>()
                            .forgotPassword(_emailController.text);
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
