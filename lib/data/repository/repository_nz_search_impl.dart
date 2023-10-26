import 'package:manawanui/core/network/api_endpoints.dart';
import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/core/network/network_operations_headers.dart';
import 'package:manawanui/data/models/get_nz_addresses_response.dart';
import 'package:manawanui/data/repository/repository_nz_search.dart';

class RepositoryNZSearchImpl implements RepositoryNZSearch {
  final NetworkOperationsWithHeaders _networkOperations;

  RepositoryNZSearchImpl(this._networkOperations);

  @override
  Future<ApiResult<GetNZAddressResponse>> getNzAddressesResponse(
      String search, Map<String, String> headers) async {
    return await _networkOperations.get(
        "${ApiEndPoints.GET_NZ_ADDRESSES}?search=$search",
        GetNZAddressResponse.fromJson,
        headers);
  }
}
