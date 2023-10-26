import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/core/network/network_operations_headers.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';

class ApiClientNZSearch implements NetworkOperationsWithHeaders {
  final Dio _dio;

  // Private constructor
  ApiClientNZSearch._(this._dio);

  factory ApiClientNZSearch() {
    final options = BaseOptions(
      baseUrl: "https://api.nzpost.co.nz/",
      headers: {'Accept': 'application/json'},
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
    return ApiClientNZSearch._(dio).._init();
  }

  // Asynchronous initialization method
  Future<void> _init() async {
    _dio.options.headers['Accept'] = "application/json";
  }

  @override
  Future<ApiResult<T>> get<T>(
      String endpoint,
      T Function(Map<String, dynamic>) fromJson,
      Map<String, dynamic> headers) async {
    _dio.options.headers.addAll(headers);
    console("setNzHeaders2 -> ${_dio.options.headers}");
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
}
