import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/services/remote/base_client_service.dart';
import 'package:commerce_app/core/services/remote/endpoints.dart';
import 'package:commerce_app/core/services/local_notifications/local_notification_service.dart';
import 'package:commerce_app/features/auth/models/request/forgot_password_request_model.dart';
import 'package:commerce_app/features/auth/models/request/verify_code_request_model.dart';
import 'package:commerce_app/features/auth/models/request/reset_password_request_model.dart';
import 'package:commerce_app/features/auth/models/response/auth_response_model.dart';
import 'package:commerce_app/core/services/remote/api_error_handler.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ApiService _apiService;

  ForgotPasswordCubit(this._apiService) : super(ForgotPasswordInitial());

  void forgotPassword(String email) async {
    emit(ForgotPasswordLoading());
    try {
      final response = await _apiService.postData(
        endpoint: Endpoints.forgotPassword,
        data: ForgotPasswordRequestModel(email: email).toJson(),
      );

      final authResponse = AuthResponseModel.fromJson(response.data);

      if (authResponse.statusMsg == 'success' || authResponse.message != null) {
        final message = authResponse.message ?? 'Success';
        await LocalNotificationService().showNotification(
          'Forgot Password',
          message,
        );
        emit(ForgotPasswordSuccess(message));
      } else {
        emit(ForgotPasswordError(authResponse.message ?? 'Error occurred'));
      }
    } catch (e) {
      emit(ForgotPasswordError(ApiErrorHandler.getMessage(e)));
    }
  }

  void verifyResetCode(String code) async {
    emit(VerifyCodeLoading());
    try {
      final response = await _apiService.postData(
        endpoint: Endpoints.verifyResetCode,
        data: VerifyCodeRequestModel(resetCode: code).toJson(),
      );

      final authResponse = AuthResponseModel.fromJson(response.data);

      if (authResponse.statusMsg == 'success' || response.statusCode == 200) {
        emit(VerifyCodeSuccess(authResponse.message ?? 'Code verified'));
      } else {
        emit(VerifyCodeError(authResponse.message ?? 'Invalid code'));
      }
    } catch (e) {
      emit(VerifyCodeError(ApiErrorHandler.getMessage(e)));
    }
  }

  void resetPassword(String email, String newPassword) async {
    emit(ResetPasswordLoading());
    try {
      final response = await _apiService.putData(
        endpoint: Endpoints.resetPassword,
        data: ResetPasswordRequestModel(email: email, newPassword: newPassword).toJson(),
      );

      final authResponse = AuthResponseModel.fromJson(response.data);

      if (authResponse.statusMsg == 'success' || response.statusCode == 200) {
        emit(ResetPasswordSuccess(authResponse.message ?? 'Password reset successful'));
      } else {
        emit(ResetPasswordError(authResponse.message ?? 'Reset failed'));
      }
    } catch (e) {
      emit(ResetPasswordError(ApiErrorHandler.getMessage(e)));
    }
  }
}
