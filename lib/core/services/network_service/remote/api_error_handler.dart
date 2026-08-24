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
              'somethingWentWrong';
        }
      }

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return 'connection_timeout';
        case DioExceptionType.connectionError:
          return 'no_internet';
        case DioExceptionType.cancel:
          return 'request_cancelled';
        default:
          return 'network_error';
      }
    }

    return 'unexpected_error';
  }
}
