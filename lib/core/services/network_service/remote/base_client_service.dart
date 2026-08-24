import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:commerce_app/core/services/network_service/remote/endpoints.dart';
import 'package:commerce_app/core/services/network_service/local/shared_pref_service.dart';

class ApiService {
  final Dio _dio;

  ApiService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: Endpoints.baseUrl,
            receiveDataWhenStatusError: true,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
          ),
        ) {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = SharedPrefHelper.getData(SharedPrefKeys.token);
          if (token != null) {
            options.headers['token'] = token;
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<Response> getData({
    required String endpoint,
    Map<String, dynamic>? query,
  }) async {
    return await _dio.get(endpoint, queryParameters: query);
  }

  Future<Response> postData({
    required String endpoint,
    required dynamic data,
    Map<String, dynamic>? query,
  }) async {
    return await _dio.post(endpoint, data: data, queryParameters: query);
  }

  Future<Response> putData({
    required String endpoint,
    required dynamic data,
    Map<String, dynamic>? query,
  }) async {
    return await _dio.put(endpoint, data: data, queryParameters: query);
  }

  Future<Response> deleteData({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? query,
  }) async {
    return await _dio.delete(endpoint, data: data, queryParameters: query);
  }
}
