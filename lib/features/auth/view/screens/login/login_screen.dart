import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/services/remote/base_client_service.dart';
import 'package:commerce_app/core/utils/widgets/toast/app_toast.dart';
import 'package:commerce_app/features/auth/controllers/cubit/login/login_cubit.dart';
import 'package:commerce_app/features/auth/controllers/cubit/login/login_state.dart';
import 'package:commerce_app/features/auth/view/widgets/login/login_view_body.dart';
import 'package:commerce_app/core/utils/navigation/screen_navigation.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(ApiService()),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            AppToast.showSuccess(context, 'Login Successful');
            ScreenNavigation.navigateToHome();
          } else if (state is LoginError) {
            AppToast.showError(context, state.message);
          }
        },
        child: const Scaffold(
          body: SafeArea(
            child: LoginViewBody(),
          ),
        ),
      ),
    );
  }
}
