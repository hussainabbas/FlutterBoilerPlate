import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/data/models/get_nz_post_auth_token_response.dart';

abstract class RepositoryNZPost {
  Future<ApiResult<GetNZPostAuthTokenResponse>> getNzPostAuthToken(
      Map<String, dynamic> body);
}
