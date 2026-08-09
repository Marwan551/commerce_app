import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/services/remote/base_client_service.dart';
import 'package:commerce_app/core/services/remote/endpoints.dart';
import 'package:commerce_app/features/auth/models/request/forgot_password_request_model.dart';
import 'package:commerce_app/features/auth/models/request/verify_code_request_model.dart';
import 'package:commerce_app/features/auth/models/request/reset_password_request_model.dart';
import 'package:commerce_app/features/auth/models/response/auth_response_model.dart';
import 'package:commerce_app/core/services/remote/api_error_handler.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ApiService _apiService;

  ForgotPasswordCubit(this._apiService) : super(ForgotPasswordInitial());

  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final forgotPasswordFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();

  void forgotPassword() async {
    if (forgotPasswordFormKey.currentState?.validate() ?? false) {
      emit(ForgotPasswordLoading());
      try {
        final response = await _apiService.postData(
          endpoint: Endpoints.forgotPassword,
          data: ForgotPasswordRequestModel(email: emailController.text).toJson(),
        );

        final authResponse = AuthResponseModel.fromJson(response.data);

        if (response.statusCode == 200 || response.statusCode == 201) {
          final message = authResponse.message ?? 'Success';
          emit(ForgotPasswordSuccess(message));
        } else {
          emit(ForgotPasswordError(authResponse.message ?? 'Error occurred'));
        }
      } catch (e) {
        emit(ForgotPasswordError(ApiErrorHandler.getMessage(e)));
      }
    }
  }

  void verifyResetCode() async {
    if (otpController.text.length == 6) {
      emit(VerifyCodeLoading());
      try {
        final response = await _apiService.postData(
          endpoint: Endpoints.verifyResetCode,
          data: VerifyCodeRequestModel(resetCode: otpController.text).toJson(),
        );

        final authResponse = AuthResponseModel.fromJson(response.data);

        if (response.statusCode == 200 || response.statusCode == 201) {
          emit(VerifyCodeSuccess(authResponse.message ?? 'Code verified'));
        } else {
          emit(VerifyCodeError(authResponse.message ?? 'Invalid code'));
        }
      } catch (e) {
        emit(VerifyCodeError(ApiErrorHandler.getMessage(e)));
      }
    }
  }

  void resetPassword() async {
    if (resetPasswordFormKey.currentState?.validate() ?? false) {
      emit(ResetPasswordLoading());
      try {
        final response = await _apiService.putData(
          endpoint: Endpoints.resetPassword,
          data: ResetPasswordRequestModel(
            email: emailController.text,
            newPassword: passwordController.text,
          ).toJson(),
        );

        final authResponse = AuthResponseModel.fromJson(response.data);

        if (response.statusCode == 200 || response.statusCode == 201) {
          emit(ResetPasswordSuccess(authResponse.message ?? 'Password reset successful'));
        } else {
          emit(ResetPasswordError(authResponse.message ?? 'Reset failed'));
        }
      } catch (e) {
        emit(ResetPasswordError(ApiErrorHandler.getMessage(e)));
      }
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    otpController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
