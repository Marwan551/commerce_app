import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/services/network_service/remote/base_client_service.dart';
import 'package:commerce_app/core/utils/widgets/toast/app_toast.dart';
import 'package:commerce_app/core/utils/widgets/dialogs/success_dialog.dart';
import 'package:commerce_app/features/auth/controllers/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:commerce_app/features/auth/controllers/cubit/forgot_password/forgot_password_state.dart';
import 'package:commerce_app/features/auth/view/widgets/forgot_password/reset_password_view_body.dart';
import 'package:commerce_app/features/auth/auth_navigation.dart';
import 'package:toastification/toastification.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(ApiService())..emailController.text = email,
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => SuccessDialog(
                title: 'password_changed'.tr(),
                message: 'password_changed_msg'.tr(),
                buttonText: 'login'.tr(),
                onButtonPressed: () {
                  Navigator.pop(context);
                  AuthNavigation.navigateToLogin();
                },
              ),
            );
          } else if (state is ResetPasswordError) {
            AppToast.show(
              context,
              message: state.message,
              type: ToastificationType.error,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: const SafeArea(
              child: ResetPasswordViewBody(),
            ),
          );
        },
      ),
    );
  }
}
