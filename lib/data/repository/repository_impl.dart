import 'package:manawanui/core/network/api_endpoints.dart';
import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/core/network/network_operations.dart';
import 'package:manawanui/data/models/generic_response.dart';
import 'package:manawanui/data/models/get_budget_allocation_response.dart';
import 'package:manawanui/data/models/get_budget_new_response.dart';
import 'package:manawanui/data/models/get_category_support_plan_response.dart';
import 'package:manawanui/data/models/get_employ_by_response.dart';
import 'package:manawanui/data/models/get_employee_documents_response.dart';
import 'package:manawanui/data/models/get_employee_payee_initials_response.dart';
import 'package:manawanui/data/models/get_employer_client_list_response.dart';
import 'package:manawanui/data/models/get_funding_support_plan_start_date_response.dart';
import 'package:manawanui/data/models/get_mail_count_response.dart';
import 'package:manawanui/data/models/get_statement_new_response.dart';
import 'package:manawanui/data/models/get_timesheet_initials_er_response.dart';
import 'package:manawanui/data/models/get_timesheet_response.dart';
import 'package:manawanui/data/models/get_timesheet_transaction_periods_response.dart';
import 'package:manawanui/data/models/get_update_timesheet_response.dart';
import 'package:manawanui/data/models/login_response.dart';
import 'package:manawanui/data/models/timesheet_employee_dropdown_response.dart';
import 'package:manawanui/data/repository/repository.dart';

class RepositoryImpl implements Repository {
  final NetworkOperations _networkOperations;

  RepositoryImpl(this._networkOperations);

  @override
  Future<ApiResult<GenericResponse>> getLatestVersion(
      Map<String, dynamic> body) async {
    return await _networkOperations.post(
      ApiEndPoints.GET_LATEST_VERSION,
      body,
      GenericResponse.fromJson,
    );
  }

  @override
  Future<ApiResult<LoginResponse>> login(Map<String, dynamic> body) async {
    return await _networkOperations.post(
      ApiEndPoints.LOGIN,
      body,
      LoginResponse.fromJson,
    );
  }

  @override
  Future<ApiResult<GenericResponse>> updateUserSession(
      Map<String, dynamic> body) async {
    return await _networkOperations.post(
      ApiEndPoints.UPDATE_USER_SESSION,
      body,
      GenericResponse.fromJson,
    );
  }

  @override
  Future<ApiResult<GetMailCountResponse>> getMailCount(
      Map<String, dynamic> body) async {
    return await _networkOperations.post(
      ApiEndPoints.GET_MAIL_COUNT,
      body,
      GetMailCountResponse.fromJson,
    );
  }

  @override
  Future<ApiResult<GetStatementNewResponse>> getStatementNew(
      Map<String, dynamic> body) async {
    return await _networkOperations.post(
      ApiEndPoints.GET_STATEMENT_NEW,
      body,
      GetStatementNewResponse.fromJson,
    );
  }

  @override
  Future<ApiResult<GetEmployerClientListResponse>> getEmployeeClientList(
      Map<String, dynamic> body) async {
    return await _networkOperations.post(
      ApiEndPoints.GET_EMPLOYER_CLIENT_LIST,
      body,
      GetEmployerClientListResponse.fromJson,
    );
  }

  @override
  Future<ApiResult<GetCategorySupportPlanResponse>> getCategorySupportPlanList(
      Map<String, dynamic> body) async {
    return await _networkOperations.post(
      ApiEndPoints.GET_CATEGORY_SUPPORT_PLAN,
      body,
      GetCategorySupportPlanResponse.fromJson,
    );
  }

  @override
  Future<ApiResult<GetFundingSupportPlanStartDateResponse>>
      getFundingSupportPlanStartDate(Map<String, dynamic> body) async {
    return await _networkOperations.post(
      ApiEndPoints.GET_FUNDING_SUPPORT_PLAN_STAR_DATE,
      body,
      GetFundingSupportPlanStartDateResponse.fromJson,
    );
  }

  @override
  Future<ApiResult<GetBudgetNewResponse>> getBudgetNew(
      Map<String, dynamic> body) async {
    return await _networkOperations.post(
      ApiEndPoints.GET_BUDGET_NEW,
      body,
      GetBudgetNewResponse.fromJson,
    );
  }

  @override
  Future<ApiResult<GetBudgetAllocationResponse>> getBudgetAllocation(
      Map<String, dynamic> body) async {
    return await _networkOperations.post(
      ApiEndPoints.GET_BUDGET_ALLOCATION,
      body,
      GetBudgetAllocationResponse.fromJson,
    );
  }

  @override
  Future<ApiResult<GetEmployByResponse>> getEmployBy(
      Map<String, dynamic> body) async {
    return await _networkOperations.post(
      ApiEndPoints.GET_EMPLOY_BY,
      body,
      GetEmployByResponse.fromJson,
    );
  }

  @override
  Future<ApiResult<GetEmployeePayeeInitialsResponse>> getEmployeePayeeInitials(
      Map<String, dynamic> body) async {
    return await _networkOperations.post(
      ApiEndPoints.GET_EMPLOYEE_PAYEE_INITIALS,
      body,
      GetEmployeePayeeInitialsResponse.fromJson,
    );
  }

  @override
  Future<ApiResult<GetEmployeeDocumentsResponse>> getEmployeeDocumentTypeBy(
      Map<String, dynamic> body) async {
    return await _networkOperations.post(
      ApiEndPoints.GET_EMPLOYEE_DOCUMENT_TYPE_BY,
      body,
      GetEmployeeDocumentsResponse.fromJson,
    );
  }

  @override
  Future<ApiResult<GenericResponse>> addUpdateEmployee(
      Map<String, dynamic> body) async {
    return await _networkOperations.post(
      ApiEndPoints.ADD_UPDATE_EMPLOYEE,
      body,
      GenericResponse.fromJson,
    );
  }

  @override
  Future<ApiResult<GetTimesheetResponse>> getTimeSheets(
      Map<String, dynamic> body) async {
    return await _networkOperations.post(
      ApiEndPoints.GET_TIMESHEET,
      body,
      GetTimesheetResponse.fromJson,
    );
  }

  @override
  Future<ApiResult<TimesheetEmployeeDropdownResponse>>
      getTimesheetEmployeeDropdown(Map<String, dynamic> body) async {
    return await _networkOperations.post(
      ApiEndPoints.GET_TIMESHEET_EMPLOYEE_DROPDOWN,
      body,
      TimesheetEmployeeDropdownResponse.fromJson,
    );
  }

  @override
  Future<ApiResult<GetTimesheetTransactionPeriodResponse>>
      getTimesheetTransactionPeriod(Map<String, dynamic> body) async {
    return await _networkOperations.post(
      ApiEndPoints.GET_TIMESHEET_TRANSACTIONS_PERIODS,
      body,
      GetTimesheetTransactionPeriodResponse.fromJson,
    );
  }

  @override
  Future<ApiResult<GetUpdateTimesheetResponse>> updateTimesheet(
      Map<String, dynamic> body) async {
    return await _networkOperations.post(
      ApiEndPoints.UPDATE_TIMESHEET,
      body,
      GetUpdateTimesheetResponse.fromJson,
    );
  }

  @override
  Future<ApiResult<GetTimesheetInitialErResponse>> getTimesheetInitialsEr(
      Map<String, dynamic> body) async {
    return await _networkOperations.post(
      ApiEndPoints.GET_TIMESHEET_INITIALS_ER,
      body,
      GetTimesheetInitialErResponse.fromJson,
    );
  }
}
