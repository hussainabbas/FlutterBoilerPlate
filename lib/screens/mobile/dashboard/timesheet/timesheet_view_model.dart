import 'dart:async';

import 'package:manawanui/core/network/api_result.dart';
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

  final _responseUpdateTimesheetController =
      StreamController<ApiResult<GetUpdateTimesheetResponse>>.broadcast();

  Stream<ApiResult<GetUpdateTimesheetResponse>>
      get responseUpdateTimesheetStream =>
          _responseUpdateTimesheetController.stream;

  final _responseTimesheetInitialsErController =
      StreamController<ApiResult<GetTimesheetInitialErResponse>>.broadcast();

  Stream<ApiResult<GetTimesheetInitialErResponse>>
      get responseTimesheetInitialsErStream =>
          _responseTimesheetInitialsErController.stream;

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

  Future<void> updateTimesheet(Map<String, dynamic> body) async {
    try {
      final response = await _repository.updateTimesheet(body);
      _responseUpdateTimesheetController.sink.add(response);
    } catch (e) {
      console('updateTimesheet - Error fetching data: $e');
      _responseUpdateTimesheetController.sink.add(
          ApiResult<GetUpdateTimesheetResponse>(
              error: 'Failed to load data: $e'));
    }
  }

  Future<void> getTimesheetInitialsEr(Map<String, dynamic> body) async {
    try {
      final response = await _repository.getTimesheetInitialsEr(body);
      _responseTimesheetInitialsErController.sink.add(response);
    } catch (e) {
      console('getTimesheetInitialsEr - Error fetching data: $e');
      _responseTimesheetInitialsErController.sink.add(
          ApiResult<GetTimesheetInitialErResponse>(
              error: 'Failed to load data: $e'));
    }
  }

  void dispose() {
    _responseGetTimesheetController.close();
    _responseGetTimesheetEmployeeDropDownController.close();
    _responseGetTimesheetTransactionPeriodController.close();
    _responseUpdateTimesheetController.close();
    _responseTimesheetInitialsErController.close();
  }
}
