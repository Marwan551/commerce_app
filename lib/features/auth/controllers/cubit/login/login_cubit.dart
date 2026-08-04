import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/features/auth/models/request/login_request_model.dart';
import 'package:commerce_app/features/auth/models/response/login_response_model.dart';
import 'package:commerce_app/core/services/remote/base_client_service.dart';
import 'package:commerce_app/core/services/remote/endpoints.dart';
import 'package:commerce_app/core/services/network_service/local/shared_pref_service.dart';
import 'package:commerce_app/features/auth/controllers/cubit/login/login_state.dart';
import 'package:commerce_app/core/services/remote/api_error_handler.dart';

class LoginCubit extends Cubit<LoginState> {
  final ApiService _apiService;

  LoginCubit(this._apiService) : super(LoginInitial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void login() async {
    if (formKey.currentState?.validate() ?? false) {
      emit(LoginLoading());
      try {
        final response = await _apiService.postData(
          endpoint: Endpoints().login,
          data: LoginRequestModel(
            email: emailController.text,
            password: passwordController.text,
          ).toJson(),
        );

        final loginResponse = LoginResponseModel.fromJson(response.data);

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (loginResponse.token != null) {
            await SharedPrefHelper().setData(SharedPrefKeys.token, loginResponse.token);
            if (loginResponse.user != null) {
              await SharedPrefHelper().setData(SharedPrefKeys.user, loginResponse.user!.toJson());
            }
          }
          emit(LoginSuccess(loginResponse));
        } else {
          emit(LoginError(loginResponse.message ?? 'Login failed'));
        }
      } catch (e) {
        emit(LoginError(ApiErrorHandler.getMessage(e)));
      }
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
