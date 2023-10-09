import 'package:manawanui/core/network/api_endpoints.dart';
import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/core/network/network_operations.dart';
import 'package:manawanui/data/models/generic_response.dart';
import 'package:manawanui/data/models/get_budget_new_response.dart';
import 'package:manawanui/data/models/get_category_support_plan_response.dart';
import 'package:manawanui/data/models/get_employ_by_response.dart';
import 'package:manawanui/data/models/get_funding_support_plan_start_date_response.dart';
import 'package:manawanui/data/models/get_mail_count_response.dart';
import 'package:manawanui/data/models/get_statement_new_response.dart';
import 'package:manawanui/data/models/login_response.dart';
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
  Future<ApiResult<GetEmployByResponse>> getEmployBy(
      Map<String, dynamic> body) async {
    return await _networkOperations.post(
      ApiEndPoints.GET_EMPLOY_BY,
      body,
      GetEmployByResponse.fromJson,
    );
  }
}
