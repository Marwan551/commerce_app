import 'package:commerce_app/core/utils/constants/strings/app_strings.dart';
import 'package:dio/dio.dart';

class ApiErrorHandler {
  ApiErrorHandler._();

  static String getMessage(dynamic error) {
    if (error is DioException) {
      if (error.response != null && error.response?.data != null) {
        final data = error.response?.data;
        if (data is Map<String, dynamic>) {
          return data['message'] ??
              data['statusMsg'] ??
              data['errors']?['msg'] ??
              AppStrings.somethingWentWrong;
        }
      }

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return AppStrings.connectionTimeout;
        case DioExceptionType.connectionError:
          return AppStrings.noInternet;
        case DioExceptionType.cancel:
          return AppStrings.requestCancelled;
        default:
          return AppStrings.networkError;
      }
    }

    return AppStrings.unexpectedError;
  }
}
