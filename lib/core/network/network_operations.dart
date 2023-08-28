import 'package:app_name/core/network/api_result.dart';

abstract class NetworkOperations {
  Future<ApiResult<T>> get<T>(
      String endpoint, T Function(Map<String, dynamic>) fromJson);

  Future<ApiResult<T>> post<T>(String endpoint, Map<String, dynamic> body,
      T Function(Map<String, dynamic>) fromJson);
}
