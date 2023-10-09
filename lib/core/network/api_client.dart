import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/core/network/network_operations.dart';
import 'package:manawanui/helpers/resources/api_param_keys.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ApiClient implements NetworkOperations {
  final Dio _dio;

  // Private constructor
  ApiClient._(this._dio);

  factory ApiClient(String baseUrl) {
    final options = BaseOptions(
      baseUrl: baseUrl,
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
    return ApiClient._(dio).._init();
  }

  // Asynchronous initialization method
  Future<void> _init() async {
    // You can use 'await' here for asynchronous operations
    final deviceInfo = await getDeviceInfo();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    _dio.options.headers['DeviceInfo'] = deviceInfo;
    _dio.options.headers[ApiParamKeys.KEY_APP_VERSION] = packageInfo.version;
    _dio.options.headers['content-Type'] = "application/x-www-form-urlencoded";
    _dio.options.headers['Access-Control-Allow-Origin'] = "*";
    _dio.options.headers['Access-Control-Allow-Credentials'] = true;
    _dio.options.headers['Access-Control-Allow-Methods'] =
        "GET, HEAD, POST, OPTIONS";
    _dio.options.headers['Access-Control-Allow-Headers'] =
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale,Access-Control-Allow-Origin, Accept";
  }

  // ApiClient(String baseUrl)
  //     : _dio = Dio(BaseOptions(
  //         baseUrl: baseUrl,
  //         headers: {
  //           "content-Type": "application/x-www-form-urlencoded",
  //           "Access-Control-Allow-Origin": "*",
  //           "Access-Control-Allow-Credentials": true,
  //           "Access-Control-Allow-Methods": "GET, HEAD, POST, OPTIONS",
  //           "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale,Access-Control-Allow-Origin, Accept",
  //           "DeviceInfo": "${await getDeviceInfo()}"
  //         },
  //         connectTimeout: const Duration(seconds: 30),
  //         receiveTimeout: const Duration(seconds: 30),
  //       ))
  //         ..interceptors.add(
  //           AwesomeDioInterceptor(
  //             logRequestTimeout: true,
  //             logRequestHeaders: true,
  //             logResponseHeaders: true,
  //             logger: debugPrint,
  //           ),
  //         );

  @override
  void setHeaders(Map<String, String> headers) {
    _dio.options.headers.addAll(headers);
  }

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
