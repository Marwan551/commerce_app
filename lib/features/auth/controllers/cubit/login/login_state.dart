import 'package:commerce_app/features/auth/models/response/login_response_model.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final LoginResponseModel response;
  LoginSuccess(this.response);
}

final class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}
