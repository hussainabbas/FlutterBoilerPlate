import 'dart:async';

import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/data/models/get_employ_by_response.dart';
import 'package:manawanui/data/repository/repository.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';

class PayeesViewModel {
  late final Repository _repository;

  PayeesViewModel({required Repository repository}) {
    _repository = repository;
  }

  final _responseGetEmployByController =
      StreamController<ApiResult<GetEmployByResponse>>.broadcast();

  Stream<ApiResult<GetEmployByResponse>> get responseGetEmployByStream =>
      _responseGetEmployByController.stream;

  Future<void> getEmployBy(Map<String, dynamic> body) async {
    try {
      final response = await _repository.getEmployBy(body);
      _responseGetEmployByController.sink.add(response);
    } catch (e) {
      console('getEmployBy - Error fetching data: $e');
      _responseGetEmployByController.sink.add(
          ApiResult<GetEmployByResponse>(error: 'Failed to load data: $e'));
    }
  }

  void dispose() {
    _responseGetEmployByController.close();
  }
}
