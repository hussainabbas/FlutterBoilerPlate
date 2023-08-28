import 'dart:async';

import 'package:app_name/core/network/api_result.dart';
import 'package:app_name/data/models/generic_response.dart';
import 'package:app_name/data/repository/repository.dart';
import 'package:app_name/helpers/utils/util_functions.dart';

class LoginViewModel {
  late final Repository _repository;

  LoginViewModel({required Repository repository}) {
    _repository = repository;
  }

  final _responseLoginController =
      StreamController<ApiResult<GenericResponse>>.broadcast();

  Stream<ApiResult<GenericResponse>> get responseLoginStream =>
      _responseLoginController.stream;

  Future<void> getLoginResponse(String username, String password) async {
    try {
      final response = await _repository.testApiCall();
      _responseLoginController.sink.add(response);
    } catch (e) {
      console('getLoginResponse - Error fetching data: $e');
      _responseLoginController.sink
          .add(ApiResult<GenericResponse>(error: 'Failed to load data: $e'));
    }
  }

  void dispose() {
    _responseLoginController.close();
  }
}
