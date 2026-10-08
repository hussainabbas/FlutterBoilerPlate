import 'dart:async';

import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/data/models/get_timesheet_detail_response.dart';
import 'package:manawanui/data/models/get_timesheet_initials_er_response.dart';
import 'package:manawanui/data/models/get_timesheet_response.dart';
import 'package:manawanui/data/models/get_timesheet_transaction_periods_response.dart';
import 'package:manawanui/data/models/get_update_timesheet_response.dart';
import 'package:manawanui/data/models/timesheet_employee_dropdown_response.dart';
import 'package:manawanui/data/repository/repository.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';

class TimesheetViewModel {
  late final Repository _repository;

  TimesheetViewModel({required Repository repository}) {
    _repository = repository;
  }

  final _responseGetTimesheetController =
      StreamController<ApiResult<GetTimesheetResponse>>.broadcast();

  Stream<ApiResult<GetTimesheetResponse>> get responseGetTimesheetStream =>
      _responseGetTimesheetController.stream;

  final _responseGetTimesheetEmployeeDropDownController = StreamController<
      ApiResult<TimesheetEmployeeDropdownResponse>>.broadcast();

  Stream<ApiResult<TimesheetEmployeeDropdownResponse>>
      get responseGetTimesheetEmployeeDropDownStream =>
          _responseGetTimesheetEmployeeDropDownController.stream;

  final _responseGetTimesheetTransactionPeriodController = StreamController<
      ApiResult<GetTimesheetTransactionPeriodResponse>>.broadcast();

  Stream<ApiResult<GetTimesheetTransactionPeriodResponse>>
      get responseGetTimesheetTransactionPeriodStream =>
          _responseGetTimesheetTransactionPeriodController.stream;

  final _responseUpdateTimesheetTimesheetController =
      StreamController<ApiResult<GetUpdateTimesheetResponse>>.broadcast();

  Stream<ApiResult<GetUpdateTimesheetResponse>>
      get responseUpdateTimesheetTimesheetStream =>
          _responseUpdateTimesheetTimesheetController.stream;

  final _responseUpdateTimesheetExpenseController =
      StreamController<ApiResult<GetUpdateTimesheetResponse>>.broadcast();

  Stream<ApiResult<GetUpdateTimesheetResponse>>
      get responseUpdateTimesheetExpenseStream =>
          _responseUpdateTimesheetExpenseController.stream;

  final _responseTimesheetInitialsErTimesheetController =
      StreamController<ApiResult<GetTimesheetInitialErResponse>>.broadcast();

  Stream<ApiResult<GetTimesheetInitialErResponse>>
      get responseTimesheetInitialsErTimesheetStream =>
          _responseTimesheetInitialsErTimesheetController.stream;

  final _responseUpdateTimesheetPaymentController =
      StreamController<ApiResult<GetUpdateTimesheetResponse>>.broadcast();

  Stream<ApiResult<GetUpdateTimesheetResponse>>
      get responseUpdateTimesheetPaymentStream =>
          _responseUpdateTimesheetPaymentController.stream;

  final _responseTimesheetInitialsErExpenseController =
      StreamController<ApiResult<GetTimesheetInitialErResponse>>.broadcast();

  Stream<ApiResult<GetTimesheetInitialErResponse>>
      get responseTimesheetInitialsErExpenseStream =>
          _responseTimesheetInitialsErExpenseController.stream;

  final _responseTimesheetInitialsErExpensePayment =
      StreamController<ApiResult<GetTimesheetInitialErResponse>>.broadcast();

  Stream<ApiResult<GetTimesheetInitialErResponse>>
      get responseTimesheetInitialsExpensePaymentStream =>
          _responseTimesheetInitialsErExpensePayment.stream;

  final _responseTimesheetDetailsPayment =
      StreamController<ApiResult<GetTimesheetDetailResponse>>.broadcast();

  Stream<ApiResult<GetTimesheetDetailResponse>>
      get responseTimesheetDetailsStream =>
          _responseTimesheetDetailsPayment.stream;

  Future<void> getTimeSheets(Map<String, dynamic> body) async {
    try {
      final response = await _repository.getTimeSheets(body);
      _responseGetTimesheetController.sink.add(response);
    } catch (e) {
      console('getTimeSheets - Error fetching data: $e');
      _responseGetTimesheetController.sink.add(
          ApiResult<GetTimesheetResponse>(error: 'Failed to load data: $e'));
    }
  }

  Future<void> getTimesheetEmployeeDropdown(Map<String, dynamic> body) async {
    try {
      final response = await _repository.getTimesheetEmployeeDropdown(body);
      _responseGetTimesheetEmployeeDropDownController.sink.add(response);
    } catch (e) {
      console('getTimesheetEmployeeDropdown - Error fetching data: $e');
      _responseGetTimesheetEmployeeDropDownController.sink.add(
          ApiResult<TimesheetEmployeeDropdownResponse>(
              error: 'Failed to load data: $e'));
    }
  }

  Future<void> getTimesheetTransactionPeriod(Map<String, dynamic> body) async {
    try {
      final response = await _repository.getTimesheetTransactionPeriod(body);
      _responseGetTimesheetTransactionPeriodController.sink.add(response);
    } catch (e) {
      console('getTimesheetTransactionPeriod - Error fetching data: $e');
      _responseGetTimesheetTransactionPeriodController.sink.add(
          ApiResult<GetTimesheetTransactionPeriodResponse>(
              error: 'Failed to load data: $e'));
    }
  }

  Future<void> updateTimesheetTimesheet(Map<String, dynamic> body) async {
    try {
      final response = await _repository.updateTimesheet(body);
      _responseUpdateTimesheetTimesheetController.sink.add(response);
    } catch (e) {
      console('updateTimesheet - Error fetching data: $e');
      _responseUpdateTimesheetTimesheetController.sink.add(
          ApiResult<GetUpdateTimesheetResponse>(
              error: 'Failed to load data: $e'));
    }
  }

  Future<void> updateTimesheetExpense(Map<String, dynamic> body) async {
    try {
      final response = await _repository.updateTimesheet(body);
      _responseUpdateTimesheetExpenseController.sink.add(response);
    } catch (e) {
      console('updateTimesheet - Error fetching data: $e');
      _responseUpdateTimesheetExpenseController.sink.add(
          ApiResult<GetUpdateTimesheetResponse>(
              error: 'Failed to load data: $e'));
    }
  }

  Future<void> updateTimesheetPayment(Map<String, dynamic> body) async {
    try {
      final response = await _repository.updateTimesheet(body);
      _responseUpdateTimesheetPaymentController.sink.add(response);
    } catch (e) {
      console('updateTimesheet - Error fetching data: $e');
      _responseUpdateTimesheetPaymentController.sink.add(
          ApiResult<GetUpdateTimesheetResponse>(
              error: 'Failed to load data: $e'));
    }
  }

  Future<void> getTimesheetInitialsErTimesheet(
      Map<String, dynamic> body) async {
    try {
      final response = await _repository.getTimesheetInitialsEr(body);
      _responseTimesheetInitialsErTimesheetController.sink.add(response);
    } catch (e) {
      console('getTimesheetInitialsEr - Error fetching data: $e');
      _responseTimesheetInitialsErTimesheetController.sink.add(
          ApiResult<GetTimesheetInitialErResponse>(
              error: 'Failed to load data: $e'));
    }
  }

  Future<void> getTimesheetInitialsErExpense(Map<String, dynamic> body) async {
    try {
      final response = await _repository.getTimesheetInitialsEr(body);
      _responseTimesheetInitialsErExpenseController.sink.add(response);
    } catch (e) {
      console('getTimesheetInitialsEr - Error fetching data: $e');
      _responseTimesheetInitialsErExpenseController.sink.add(
          ApiResult<GetTimesheetInitialErResponse>(
              error: 'Failed to load data: $e'));
    }
  }

  Future<void> getTimesheetInitialsErPayment(Map<String, dynamic> body) async {
    try {
      final response = await _repository.getTimesheetInitialsEr(body);
      _responseTimesheetInitialsErExpensePayment.sink.add(response);
    } catch (e) {
      console('getTimesheetInitialsEr - Error fetching data: $e');
      _responseTimesheetInitialsErExpensePayment.sink.add(
          ApiResult<GetTimesheetInitialErResponse>(
              error: 'Failed to load data: $e'));
    }
  }

  Future<void> getTimesheetDetails(Map<String, dynamic> body) async {
    try {
      final response = await _repository.getTimesheetDetails(body);
      _responseTimesheetDetailsPayment.sink.add(response);
    } catch (e) {
      console('getTimesheetDetails - Error fetching data: $e');
      _responseTimesheetDetailsPayment.sink.add(
          ApiResult<GetTimesheetDetailResponse>(
              error: 'Failed to load data: $e'));
    }
  }

  void dispose() {
    _responseGetTimesheetController.close();
    _responseGetTimesheetEmployeeDropDownController.close();
    _responseGetTimesheetTransactionPeriodController.close();
    _responseUpdateTimesheetTimesheetController.close();
    _responseUpdateTimesheetExpenseController.close();
    _responseUpdateTimesheetPaymentController.close();
    _responseTimesheetInitialsErTimesheetController.close();
    _responseTimesheetInitialsErExpenseController.close();
    _responseTimesheetInitialsErExpensePayment.close();
    _responseTimesheetDetailsPayment.close();
  }
}
