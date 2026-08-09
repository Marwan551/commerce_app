import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_button.dart';
import 'package:commerce_app/core/utils/constants/styles/app_text_styles.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/features/auth/controllers/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:commerce_app/features/auth/controllers/cubit/forgot_password/forgot_password_state.dart';

class VerifyCodeBody extends StatelessWidget {
  const VerifyCodeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();
    
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: AppTextStyles.bold24,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyB3B3B3),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Enter 6 Digit Code', style: AppTextStyles.bold24),
          const SizedBox(height: 8),
          Text(
            'Enter the 6 digit code that you received on your email.',
            style: AppTextStyles.regular16.copyWith(color: AppColors.grey707070),
          ),
          const SizedBox(height: 32),
          Center(
            child: Pinput(
              length: 6,
              controller: cubit.otpController,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: defaultPinTheme.copyDecorationWith(
                border: Border.all(color: AppColors.black1A1A1A),
                borderRadius: BorderRadius.circular(8),
              ),
              onCompleted: (pin) {
                cubit.verifyResetCode();
              },
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: TextButton(
              onPressed: () {
              },
              child: const Text(
                'Resend code',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: AppColors.black1A1A1A,
                ),
              ),
            ),
          ),
          const Spacer(),
          BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
            builder: (context, state) {
              return CustomButton(
                text: 'Continue',
                isLoading: state is VerifyCodeLoading,
                onPressed: () {
                  cubit.verifyResetCode();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
