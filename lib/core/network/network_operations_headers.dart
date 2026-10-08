import 'package:manawanui/core/network/api_result.dart';

abstract class NetworkOperationsWithHeaders {
  Future<ApiResult<T>> get<T>(String endpoint,
      T Function(Map<String, dynamic>) fromJson, Map<String, String> headers);
}
