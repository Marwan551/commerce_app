import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/services/remote/base_client_service.dart';
import 'package:commerce_app/core/utils/widgets/toast/app_toast.dart';
import 'package:commerce_app/core/utils/widgets/dialogs/success_dialog.dart';
import 'package:commerce_app/features/auth/controllers/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:commerce_app/features/auth/controllers/cubit/forgot_password/forgot_password_state.dart';
import 'package:commerce_app/features/auth/view/widgets/forgotPassword/reset_password_view_body.dart';
import 'package:commerce_app/core/utils/navigation/screen_navigation.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(ApiService()),
      child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => SuccessDialog(
                title: 'Password Changed!',
                message: 'Your can now use your new password to login to your account.',
                buttonText: 'Login',
                onButtonPressed: () {
                  Navigator.pop(context);
                  ScreenNavigation.navigateToLogin();
                },
              ),
            );
          } else if (state is ResetPasswordError) {
            AppToast.showError(context, state.message);
          }
        },
        child: Scaffold(
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
        ),
      ),
    );
  }
}
