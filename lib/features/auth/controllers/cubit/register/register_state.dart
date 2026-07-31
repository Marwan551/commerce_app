import 'package:commerce_app/features/auth/models/response/register_response_model.dart';

sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final RegisterResponseModel response;
  RegisterSuccess(this.response);
}

final class RegisterError extends RegisterState {
  final String message;
  RegisterError(this.message);
}
