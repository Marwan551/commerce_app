import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/features/auth/models/request/register_request_model.dart';
import 'package:commerce_app/features/auth/models/response/register_response_model.dart';
import 'package:commerce_app/core/services/remote/base_client_service.dart';
import 'package:commerce_app/core/services/remote/endpoints.dart';
import 'package:commerce_app/features/auth/controllers/cubit/register/register_state.dart';
import 'package:commerce_app/core/services/remote/api_error_handler.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final ApiService _apiService;

  RegisterCubit(this._apiService) : super(RegisterInitial());

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void register() async {
    if (formKey.currentState?.validate() ?? false) {
      emit(RegisterLoading());
      try {
        final response = await _apiService.postData(
          endpoint: Endpoints.register,
          data: RegisterRequestModel(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
            rePassword: rePasswordController.text,
            phone: phoneController.text,
          ).toJson(),
        );

        final registerResponse = RegisterResponseModel.fromJson(response.data);

        if (response.statusCode == 200 || response.statusCode == 201) {
          emit(RegisterSuccess(registerResponse));
        } else {
          emit(RegisterError(registerResponse.message ?? 'Registration failed'));
        }
      } catch (e) {
        emit(RegisterError(ApiErrorHandler.getMessage(e)));
      }
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
