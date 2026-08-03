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

  void login(LoginRequestModel request) async {
    emit(LoginLoading());
    try {
      final response = await _apiService.postData(
        endpoint: Endpoints.login,
        data: request.toJson(),
      );

      final loginResponse = LoginResponseModel.fromJson(response.data);

      if (loginResponse.message == 'success') {
        if (loginResponse.token != null) {
          await SharedPrefHelper.setData('token', loginResponse.token);
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
