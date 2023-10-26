import 'package:manawanui/core/network/api_endpoints.dart';
import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/core/network/network_operations.dart';
import 'package:manawanui/data/models/get_nz_post_auth_token_response.dart';
import 'package:manawanui/data/repository/repository_nz.dart';

class RepositoryNZPostImpl implements RepositoryNZPost {
  final NetworkOperations _networkOperations;

  RepositoryNZPostImpl(this._networkOperations);

  @override
  Future<ApiResult<GetNZPostAuthTokenResponse>> getNzPostAuthToken(
      Map<String, dynamic> body) async {
    return await _networkOperations.post(
      ApiEndPoints.GET_NZ_TOKEN,
      body,
      GetNZPostAuthTokenResponse.fromJson,
    );
  }
}
