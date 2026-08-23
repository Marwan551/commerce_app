import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/utils/widgets/buttons/custom_button.dart';
import 'package:commerce_app/core/utils/widgets/text_fields/custom_text_field.dart';
import 'package:commerce_app/core/utils/validation/app_validator.dart';
import 'package:commerce_app/features/auth/controllers/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:commerce_app/features/auth/controllers/cubit/forgot_password/forgot_password_state.dart';

class ForgotPasswordBody extends StatelessWidget {
  const ForgotPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: cubit.forgotPasswordFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('forgot_password'.tr(), style: theme.textTheme.displayMedium),
            const SizedBox(height: 8),
            Text(
              'forgot_password_msg'.tr(),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.secondary.withAlpha(200),
              ),
            ),
            const SizedBox(height: 32),
            CustomTextField(
              labelText: 'email'.tr(),
              hintText: 'email_hint'.tr(),
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
                  text: 'send_code'.tr(),
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
