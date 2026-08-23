import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/services/network_service/remote/base_client_service.dart';
import 'package:commerce_app/core/utils/widgets/toast/app_toast.dart';
import 'package:commerce_app/features/auth/controllers/cubit/login/login_cubit.dart';
import 'package:commerce_app/features/auth/controllers/cubit/login/login_state.dart';
import 'package:commerce_app/features/auth/view/widgets/login/login_view_body.dart';
import 'package:commerce_app/core/utils/navigation/screen_navigation.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(ApiService()),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            AppToast.show(
              context,
              message: 'login_success'.tr(),
              type: ToastificationType.success,
            );
            ScreenNavigation.navigateToHome();
          } else if (state is LoginError) {
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
              child: LoginViewBody(),
            ),
          );
        },
      ),
    );
  }
}
