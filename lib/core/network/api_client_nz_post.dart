import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/core/network/network_operations.dart';

class ApiClientNZPost implements NetworkOperations {
  final Dio _dio;

  // Private constructor
  ApiClientNZPost._(this._dio);

  factory ApiClientNZPost() {
    final options = BaseOptions(
      baseUrl: "https://oauth.nzpost.co.nz/",
      headers: {
        // Your headers here
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );

    final dio = Dio(options)
      ..interceptors.add(
        AwesomeDioInterceptor(
          logRequestTimeout: true,
          logRequestHeaders: true,
          logResponseHeaders: true,
          logger: debugPrint,
        ),
      );
    return ApiClientNZPost._(dio).._init();
  }

  Future<void> _init() async {
    _dio.options.headers['content-Type'] = "application/x-www-form-urlencoded";
    _dio.options.headers['accept'] = "application/json";
  }

  @override
  void setHeaders(Map<String, String> headers) {}

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

  @override
  void setNzHeaders(Map<String, String> headers) {
    _dio.options.headers.addAll(headers);
  }
}
