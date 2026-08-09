import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_button.dart';
import 'package:commerce_app/core/utils/widgets/text_fields/custom_text_field.dart';
import 'package:commerce_app/core/utils/constants/styles/app_text_styles.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/core/utils/validation/app_validator.dart';
import 'package:commerce_app/features/auth/controllers/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:commerce_app/features/auth/controllers/cubit/forgot_password/forgot_password_state.dart';

class ForgotPasswordBody extends StatelessWidget {
  const ForgotPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: cubit.forgotPasswordFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Forgot password', style: AppTextStyles.bold24),
            const SizedBox(height: 8),
            Text(
              'Enter your email for the verification process. We will send a 6-digit code to your email.',
              style: AppTextStyles.regular16.copyWith(color: AppColors.grey707070),
            ),
            const SizedBox(height: 32),
            CustomTextField(
              labelText: 'Email',
              hintText: 'Enter your email',
              controller: cubit.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: AppValidator.validateEmail,
              onChanged: (_) {
                cubit.forgotPasswordFormKey.currentState?.validate();
              },
            ),
            const Spacer(),
            BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
              builder: (context, state) {
                return CustomButton(
                  text: 'Send Code',
                  isLoading: state is ForgotPasswordLoading,
                  onPressed: () {
                    cubit.forgotPassword();
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
