import 'package:manawanui/core/network/api_result.dart';
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

abstract class Repository {
  Future<ApiResult<GenericResponse>> getLatestVersion(
      Map<String, dynamic> body);

  Future<ApiResult<LoginResponse>> login(Map<String, dynamic> body);

  Future<ApiResult<GenericResponse>> updateUserSession(
      Map<String, dynamic> body);

  Future<ApiResult<GetMailCountResponse>> getMailCount(
      Map<String, dynamic> body);

  Future<ApiResult<GetStatementNewResponse>> getStatementNew(
      Map<String, dynamic> body);

  Future<ApiResult<GetEmployerClientListResponse>> getEmployeeClientList(
      Map<String, dynamic> body);

  Future<ApiResult<GetCategorySupportPlanResponse>> getCategorySupportPlanList(
      Map<String, dynamic> body);

  Future<ApiResult<GetFundingSupportPlanStartDateResponse>>
      getFundingSupportPlanStartDate(Map<String, dynamic> body);

  Future<ApiResult<GetBudgetNewResponse>> getBudgetNew(
      Map<String, dynamic> body);

  Future<ApiResult<GetBudgetAllocationResponse>> getBudgetAllocation(
      Map<String, dynamic> body);

  Future<ApiResult<GetEmployByResponse>> getEmployBy(Map<String, dynamic> body);

  Future<ApiResult<GetEmployeePayeeInitialsResponse>> getEmployeePayeeInitials(
      Map<String, dynamic> body);

  Future<ApiResult<GetEmployeeDocumentsResponse>> getEmployeeDocumentTypeBy(
      Map<String, dynamic> body);

  Future<ApiResult<GenericResponse>> addUpdateEmployee(
      Map<String, dynamic> body);

  Future<ApiResult<GetTimesheetResponse>> getTimeSheets(
      Map<String, dynamic> body);

  Future<ApiResult<TimesheetEmployeeDropdownResponse>>
      getTimesheetEmployeeDropdown(Map<String, dynamic> body);

  Future<ApiResult<GetTimesheetTransactionPeriodResponse>>
      getTimesheetTransactionPeriod(Map<String, dynamic> body);

  Future<ApiResult<GetUpdateTimesheetResponse>> updateTimesheet(
      Map<String, dynamic> body);

  Future<ApiResult<GetTimesheetInitialErResponse>> getTimesheetInitialsEr(
      Map<String, dynamic> body);
}
