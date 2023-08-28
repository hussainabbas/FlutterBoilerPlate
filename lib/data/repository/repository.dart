import 'package:app_name/core/network/api_result.dart';
import 'package:app_name/data/models/generic_response.dart';

abstract class Repository {
  Future<ApiResult<GenericResponse>> testApiCall();
}
