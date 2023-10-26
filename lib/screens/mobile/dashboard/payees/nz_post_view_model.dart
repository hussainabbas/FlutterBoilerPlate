import 'dart:async';

import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/data/models/get_nz_post_auth_token_response.dart';
import 'package:manawanui/data/repository/repository_nz.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';

class NZPostViewModel {
  late final RepositoryNZPost _repository;

  NZPostViewModel({required RepositoryNZPost repository}) {
    _repository = repository;
  }

  final _responseGetNZAuthTokenController =
      StreamController<ApiResult<GetNZPostAuthTokenResponse>>.broadcast();

  Stream<ApiResult<GetNZPostAuthTokenResponse>>
      get responseGetNZAuthTokenStream =>
          _responseGetNZAuthTokenController.stream;

  Future<void> getNzPostAuthToken(Map<String, dynamic> body) async {
    try {
      final response = await _repository.getNzPostAuthToken(body);
      _responseGetNZAuthTokenController.sink.add(response);
    } catch (e) {
      console('getNzPostAuthToken - Error fetching data: $e');
      _responseGetNZAuthTokenController.sink.add(
          ApiResult<GetNZPostAuthTokenResponse>(
              error: 'Failed to load data: $e'));
    }
  }

  void dispose() {
    _responseGetNZAuthTokenController.close();
  }
}
