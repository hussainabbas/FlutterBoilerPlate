import 'dart:async';

import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/data/models/generic_response.dart';
import 'package:manawanui/data/models/get_employ_by_response.dart';
import 'package:manawanui/data/models/get_employee_documents_response.dart';
import 'package:manawanui/data/models/get_employee_payee_initials_response.dart';
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

  final _responseGetEmployPayeeInitialsController =
      StreamController<ApiResult<GetEmployeePayeeInitialsResponse>>.broadcast();

  Stream<ApiResult<GetEmployeePayeeInitialsResponse>>
      get responseGetEmployPayeeInitialsStream =>
          _responseGetEmployPayeeInitialsController.stream;

  final _responseGetEmployeeDocumentTypeByController =
      StreamController<ApiResult<GetEmployeeDocumentsResponse>>.broadcast();

  Stream<ApiResult<GetEmployeeDocumentsResponse>>
      get responseGetEmployeeDocumentTypeByStream =>
          _responseGetEmployeeDocumentTypeByController.stream;

  final _responseAddUpdateEmployeeController =
      StreamController<ApiResult<GenericResponse>>.broadcast();

  Stream<ApiResult<GenericResponse>> get responseAddUpdateEmployeeStream =>
      _responseAddUpdateEmployeeController.stream;

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

  Future<void> getEmployeePayeeInitials(Map<String, dynamic> body) async {
    try {
      final response = await _repository.getEmployeePayeeInitials(body);
      _responseGetEmployPayeeInitialsController.sink.add(response);
    } catch (e) {
      console('getEmployeePayeeInitials - Error fetching data: $e');
      _responseGetEmployPayeeInitialsController.sink.add(
          ApiResult<GetEmployeePayeeInitialsResponse>(
              error: 'Failed to load data: $e'));
    }
  }

  Future<void> getEmployeeDocumentTypeBy(Map<String, dynamic> body) async {
    try {
      final response = await _repository.getEmployeeDocumentTypeBy(body);
      _responseGetEmployeeDocumentTypeByController.sink.add(response);
    } catch (e) {
      console('getEmployeePayeeInitials - Error fetching data: $e');
      _responseGetEmployeeDocumentTypeByController.sink.add(
          ApiResult<GetEmployeeDocumentsResponse>(
              error: 'Failed to load data: $e'));
    }
  }

  Future<void> addUpdateEmployee(Map<String, dynamic> body) async {
    try {
      final response = await _repository.addUpdateEmployee(body);
      _responseAddUpdateEmployeeController.sink.add(response);
    } catch (e) {
      console('addUpdateEmployee - Error fetching data: $e');
      _responseAddUpdateEmployeeController.sink
          .add(ApiResult<GenericResponse>(error: 'Failed to load data: $e'));
    }
  }

  void dispose() {
    _responseGetEmployByController.close();
    _responseGetEmployPayeeInitialsController.close();
    _responseGetEmployeeDocumentTypeByController.close();
    _responseAddUpdateEmployeeController.close();
  }
}
