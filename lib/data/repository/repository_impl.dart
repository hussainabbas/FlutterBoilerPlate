import 'package:app_name/core/network/api_endpoints.dart';
import 'package:app_name/core/network/api_result.dart';
import 'package:app_name/core/network/network_operations.dart';
import 'package:app_name/data/models/generic_response.dart';
import 'package:app_name/data/repository/repository.dart';

class RepositoryImpl implements Repository {
  final NetworkOperations _networkOperations;

  RepositoryImpl(this._networkOperations);

  @override
  Future<ApiResult<GenericResponse>> testApiCall() async {
    return await _networkOperations.get(
      ApiEndPoints.LOGIN,
      GenericResponse.fromJson,
    );
  }
}
