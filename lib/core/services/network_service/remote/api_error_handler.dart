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
                 'Something went wrong. Please try again.';
        }
      }
      
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return 'Connection timeout. Please check your internet.';
        case DioExceptionType.connectionError:
          return 'No internet connection.';
        case DioExceptionType.cancel:
          return 'Request cancelled.';
        default:
          return 'Network error occurred. Please try again.';
      }
    }
    
    return error?.toString() ?? 'Unexpected error occurred.';
  }
}
