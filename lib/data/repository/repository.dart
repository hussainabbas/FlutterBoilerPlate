import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/data/models/generic_response.dart';
import 'package:manawanui/data/models/get_budget_new_response.dart';
import 'package:manawanui/data/models/get_category_support_plan_response.dart';
import 'package:manawanui/data/models/get_employ_by_response.dart';
import 'package:manawanui/data/models/get_funding_support_plan_start_date_response.dart';
import 'package:manawanui/data/models/get_mail_count_response.dart';
import 'package:manawanui/data/models/get_statement_new_response.dart';
import 'package:manawanui/data/models/login_response.dart';

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

  Future<ApiResult<GetCategorySupportPlanResponse>> getCategorySupportPlanList(
      Map<String, dynamic> body);

  Future<ApiResult<GetFundingSupportPlanStartDateResponse>>
      getFundingSupportPlanStartDate(Map<String, dynamic> body);

  Future<ApiResult<GetBudgetNewResponse>> getBudgetNew(
      Map<String, dynamic> body);

  Future<ApiResult<GetEmployByResponse>> getEmployBy(Map<String, dynamic> body);
}
