import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/services/network_service/remote/base_client_service.dart';
import 'package:commerce_app/core/utils/widgets/toast/app_toast.dart';
import 'package:commerce_app/features/auth/controllers/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:commerce_app/features/auth/controllers/cubit/forgot_password/forgot_password_state.dart';
import 'package:commerce_app/features/auth/view/widgets/forgot_password/forgot_password_body.dart';
import 'package:commerce_app/features/auth/auth_navigation.dart';
import 'package:toastification/toastification.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(ApiService()),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            AppToast.show(
              context,
              message: state.message,
              type: ToastificationType.success,
            );
            AuthNavigation.navigateToVerifyCode(
              email: context.read<ForgotPasswordCubit>().emailController.text,
            );
          } else if (state is ForgotPasswordError) {
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
              child: ForgotPasswordBody(),
            ),
          );
        },
      ),
    );
  }
}
