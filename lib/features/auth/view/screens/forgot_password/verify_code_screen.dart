import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/services/network_service/remote/base_client_service.dart';
import 'package:commerce_app/core/utils/widgets/toast/app_toast.dart';
import 'package:commerce_app/features/auth/controllers/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:commerce_app/features/auth/controllers/cubit/forgot_password/forgot_password_state.dart';
import 'package:commerce_app/features/auth/view/widgets/forgot_password/verify_code_body.dart';
import 'package:commerce_app/features/auth/auth_navigation.dart';
import 'package:toastification/toastification.dart';

class VerifyCodeScreen extends StatelessWidget {
  final String email;
  const VerifyCodeScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(ApiService())..emailController.text = email,
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is VerifyCodeSuccess) {
            AppToast.show(
              context,
              message: state.message,
              type: ToastificationType.success,
            );
            AuthNavigation.navigateToResetPassword(
              email: context.read<ForgotPasswordCubit>().emailController.text,
            );
          } else if (state is VerifyCodeError) {
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
              title: Text('forgot_password'.tr()),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: const SafeArea(
              child: VerifyCodeBody(),
            ),
          );
        },
      ),
    );
  }
}
