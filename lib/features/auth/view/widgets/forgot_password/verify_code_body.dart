import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_button.dart';
import 'package:commerce_app/features/auth/controllers/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:commerce_app/features/auth/controllers/cubit/forgot_password/forgot_password_state.dart';

class VerifyCodeBody extends StatelessWidget {
  const VerifyCodeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();
    final theme = Theme.of(context);
    
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: theme.textTheme.displayMedium,
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.secondary),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Enter 6 Digit Code', style: theme.textTheme.displayMedium),
          const SizedBox(height: 8),
          Text(
            'Enter the 6 digit code that you received on your email.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.secondary.withAlpha(200),
            ),
          ),
          const SizedBox(height: 32),
          Center(
            child: Pinput(
              length: 6,
              controller: cubit.otpController,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: defaultPinTheme.copyDecorationWith(
                border: Border.all(color: theme.colorScheme.primary),
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
              child: Text(
                'Resend code',
                style: theme.textTheme.bodyLarge?.copyWith(
                  decoration: TextDecoration.underline,
                  color: theme.colorScheme.primary,
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
