import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:commerce_app/core/services/remote/endpoints.dart';

class ApiService {
  final Dio _dio;

  ApiService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: Endpoints().baseUrl,
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
  }

  Future<Response> getData({
    required String endpoint,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'token': token,
    };
    return await _dio.get(endpoint, queryParameters: query);
  }

  Future<Response> postData({
    required String endpoint,
    required dynamic data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'token': token,
    };
    return await _dio.post(endpoint, data: data, queryParameters: query);
  }

  Future<Response> putData({
    required String endpoint,
    required dynamic data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'token': token,
    };
    return await _dio.put(endpoint, data: data, queryParameters: query);
  }

  Future<Response> deleteData({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'token': token,
    };
    return await _dio.delete(endpoint, data: data, queryParameters: query);
  }
}
