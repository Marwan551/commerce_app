import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/features/auth/models/request/register_request_model.dart';
import 'package:commerce_app/features/auth/models/response/register_response_model.dart';
import 'package:commerce_app/core/services/remote/base_client_service.dart';
import 'package:commerce_app/core/services/remote/endpoints.dart';
import 'package:commerce_app/features/auth/controllers/cubit/register/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final ApiService _apiService;

  RegisterCubit(this._apiService) : super(RegisterInitial());

  void register(RegisterRequestModel request) async {
    emit(RegisterLoading());
    try {
      final response = await _apiService.postData(
        endpoint: Endpoints.register,
        data: request.toJson(),
      );

      final registerResponse = RegisterResponseModel.fromJson(response.data);

      if (registerResponse.message == 'success') {
        emit(RegisterSuccess(registerResponse));
      } else {
        emit(RegisterError(registerResponse.message ?? 'Registration failed'));
      }
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
