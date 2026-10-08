import 'dart:async';

import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/data/models/generic_response.dart';
import 'package:manawanui/data/models/login_response.dart';
import 'package:manawanui/data/repository/repository.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';

class LoginViewModel {
  late final Repository _repository;

  LoginViewModel({required Repository repository}) {
    _repository = repository;
  }

  final _responseLoginController =
      StreamController<ApiResult<LoginResponse>>.broadcast();

  Stream<ApiResult<LoginResponse>> get responseLoginStream =>
      _responseLoginController.stream;

  final _responseUpdateUserSessionController =
      StreamController<ApiResult<GenericResponse>>.broadcast();

  Stream<ApiResult<GenericResponse>> get responseUpdateUserSessionStream =>
      _responseUpdateUserSessionController.stream;

  Future<void> getLoginResponse(Map<String, dynamic> body) async {
    try {
      final response = await _repository.login(body);
      _responseLoginController.sink.add(response);
    } catch (e) {
      console('getLoginResponse - Error fetching data: $e');
      _responseLoginController.sink
          .add(ApiResult<LoginResponse>(error: 'Failed to load data: $e'));
    }
  }

  Future<void> updateUserSession(Map<String, dynamic> body) async {
    try {
      final response = await _repository.updateUserSession(body);
      _responseUpdateUserSessionController.sink.add(response);
    } catch (e) {
      console('updateUserSession - Error fetching data: $e');
      _responseUpdateUserSessionController.sink
          .add(ApiResult<GenericResponse>(error: 'Failed to load data: $e'));
    }
  }

  void dispose() {
    _responseLoginController.close();
    _responseUpdateUserSessionController.close();
  }
}
