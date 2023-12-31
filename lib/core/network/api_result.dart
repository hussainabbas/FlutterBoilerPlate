import 'package:manawanui/helpers/utils/util_functions.dart';

class ApiResult<T> {
  final T? data;
  final String? error;

  ApiResult({this.data, this.error});

  factory ApiResult.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    try {
      if (json is String) {
        final Map<String, dynamic> responseData = {'response': json}; //
        final T data = fromJson(responseData);
        return ApiResult<T>(data: data);
      } else {
        final T data = fromJson(json);
        return ApiResult<T>(data: data);
      }
    } catch (e) {
      console('Error: ApiResult parsing data: $e');
      return ApiResult<T>(error: 'Failed to load data');
    }
  }
}
