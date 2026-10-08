import 'dart:async';

import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/data/models/generic_response.dart';
import 'package:manawanui/data/repository/repository.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';

class MainViewModel {
  late final Repository _repository;

  MainViewModel({required Repository repository}) {
    _repository = repository;
  }

  final _responseGetLatestVersionController =
      StreamController<ApiResult<GenericResponse>>.broadcast();

  Stream<ApiResult<GenericResponse>> get responseGetLatestVersionStream =>
      _responseGetLatestVersionController.stream;

  Future<void> getLatestVersion(Map<String, dynamic> body) async {
    try {
      final response = await _repository.getLatestVersion(body);
      _responseGetLatestVersionController.sink.add(response);
    } catch (e) {
      console('getLatestVersion - Error fetching data: $e');
      _responseGetLatestVersionController.sink
          .add(ApiResult<GenericResponse>(error: 'Failed to load data: $e'));
    }
  }

  void dispose() {
    _responseGetLatestVersionController.close();
  }
}
