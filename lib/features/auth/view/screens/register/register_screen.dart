import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/services/network_service/remote/base_client_service.dart';
import 'package:commerce_app/core/utils/widgets/toast/app_toast.dart';
import 'package:commerce_app/features/auth/controllers/cubit/register/register_cubit.dart';
import 'package:commerce_app/features/auth/controllers/cubit/register/register_state.dart';
import 'package:commerce_app/features/auth/view/widgets/register/register_view_body.dart';
import 'package:commerce_app/features/auth/auth_navigation.dart';
import 'package:toastification/toastification.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(ApiService()),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            AppToast.show(
              context,
              message: 'Registration Successful',
              type: ToastificationType.success,
            );
            AuthNavigation.navigateToLogin();
          } else if (state is RegisterError) {
            AppToast.show(
              context,
              message: state.message,
              type: ToastificationType.error,
            );
          }
        },
        builder: (context, state) {
          return const Scaffold(
            body: SafeArea(
              child: RegisterViewBody(),
            ),
          );
        },
      ),
    );
  }
}
