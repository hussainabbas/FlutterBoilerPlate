import 'dart:async';

import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/data/models/get_category_support_plan_response.dart';
import 'package:manawanui/data/models/get_funding_support_plan_start_date_response.dart';
import 'package:manawanui/data/models/get_mail_count_response.dart';
import 'package:manawanui/data/models/get_statement_new_response.dart';
import 'package:manawanui/data/repository/repository.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';

class DashboardViewModel {
  late final Repository _repository;

  DashboardViewModel({required Repository repository}) {
    _repository = repository;
  }

  final _responseGetMailCountController =
      StreamController<ApiResult<GetMailCountResponse>>.broadcast();

  Stream<ApiResult<GetMailCountResponse>> get responseGetMailCountStream =>
      _responseGetMailCountController.stream;

  final _responseGetStatementNewController =
      StreamController<ApiResult<GetStatementNewResponse>>.broadcast();

  Stream<ApiResult<GetStatementNewResponse>>
      get responseGetStatementNewStream =>
          _responseGetStatementNewController.stream;

  final _responseGetCategorySupportPlanListController =
      StreamController<ApiResult<GetCategorySupportPlanResponse>>.broadcast();

  Stream<ApiResult<GetCategorySupportPlanResponse>>
      get responseGetCategorySupportPlanListStream =>
          _responseGetCategorySupportPlanListController.stream;

  final _responseGetFundingSupportPlanStartDateController = StreamController<
      ApiResult<GetFundingSupportPlanStartDateResponse>>.broadcast();

  Stream<ApiResult<GetFundingSupportPlanStartDateResponse>>
      get responseGetFundingSupportPlanStartDateListStream =>
          _responseGetFundingSupportPlanStartDateController.stream;

  Future<void> getMailCount(Map<String, dynamic> body) async {
    try {
      final response = await _repository.getMailCount(body);
      _responseGetMailCountController.sink.add(response);
    } catch (e) {
      console('getStatementNew - Error fetching data: $e');
      _responseGetMailCountController.sink.add(
          ApiResult<GetMailCountResponse>(error: 'Failed to load data: $e'));
    }
  }

  Future<void> getStatementNew(Map<String, dynamic> body) async {
    try {
      final response = await _repository.getStatementNew(body);
      _responseGetStatementNewController.sink.add(response);
    } catch (e) {
      console('getStatementNew - Error fetching data: $e');
      _responseGetStatementNewController.sink.add(
          ApiResult<GetStatementNewResponse>(error: 'Failed to load data: $e'));
    }
  }

  Future<void> getCategorySupportPlanList(Map<String, dynamic> body) async {
    try {
      final response = await _repository.getCategorySupportPlanList(body);
      _responseGetCategorySupportPlanListController.sink.add(response);
    } catch (e) {
      console('getCategorySupportPlanList - Error fetching data: $e');
      _responseGetCategorySupportPlanListController.sink.add(
          ApiResult<GetCategorySupportPlanResponse>(
              error: 'Failed to load data: $e'));
    }
  }

  Future<void> getFundingSupportPlanStartDate(Map<String, dynamic> body) async {
    try {
      final response = await _repository.getFundingSupportPlanStartDate(body);
      _responseGetFundingSupportPlanStartDateController.sink.add(response);
    } catch (e) {
      console('getFundingSupportPlanStartDate - Error fetching data: $e');
      _responseGetFundingSupportPlanStartDateController.sink.add(
          ApiResult<GetFundingSupportPlanStartDateResponse>(
              error: 'Failed to load data: $e'));
    }
  }

  void dispose() {
    _responseGetMailCountController.close();
    _responseGetStatementNewController.close();
    _responseGetCategorySupportPlanListController.close();
    _responseGetFundingSupportPlanStartDateController.close();
  }
}
