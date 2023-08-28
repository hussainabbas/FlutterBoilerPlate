import 'package:app_name/core/network/api_result.dart';
import 'package:app_name/core/network/network_operations.dart';
import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiClient implements NetworkOperations {
  final Dio _dio;

  ApiClient(String baseUrl)
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ))
          ..interceptors.add(
            AwesomeDioInterceptor(
              logRequestTimeout: true,
              logRequestHeaders: false,
              logResponseHeaders: false,
              logger: debugPrint,
            ),
          );

  @override
  Future<ApiResult<T>> get<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final Response response = await _dio.get(endpoint);
      return ApiResult<T>.fromJson(response.data, fromJson);
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.connectionTimeout) {
        return ApiResult<T>(
            error: 'Connection timeout. Please try again later.');
      } else {
        return ApiResult<T>(error: 'Failed to load data: $e');
      }
    }
  }

  @override
  Future<ApiResult<T>> post<T>(
    String endpoint,
    Map<String, dynamic> body,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final Response response = await _dio.post(endpoint, data: body);
      return ApiResult<T>.fromJson(response.data, fromJson);
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.connectionTimeout) {
        return ApiResult<T>(
            error: 'Connection timeout. Please try again later.');
      } else {
        return ApiResult<T>(error: 'Failed to load data: $e');
      }
    }
  }
}
