import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/data/models/get_nz_addresses_response.dart';

abstract class RepositoryNZSearch {
  Future<ApiResult<GetNZAddressResponse>> getNzAddressesResponse(
      String search, Map<String, String> headers);
}
