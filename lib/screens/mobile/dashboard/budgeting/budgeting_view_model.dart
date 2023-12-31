import 'dart:async';

import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/data/models/get_budget_allocation_response.dart';
import 'package:manawanui/data/models/get_budget_new_response.dart';
import 'package:manawanui/data/repository/repository.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';

class BudgetingViewModel {
  late final Repository _repository;

  BudgetingViewModel({required Repository repository}) {
    _repository = repository;
  }

  final _responseGetBudgetingNewController =
      StreamController<ApiResult<GetBudgetNewResponse>>.broadcast();

  Stream<ApiResult<GetBudgetNewResponse>> get responseGetBudgetingNewStream =>
      _responseGetBudgetingNewController.stream;

  final _responseGetBudgetingAllocationController =
      StreamController<ApiResult<GetBudgetAllocationResponse>>.broadcast();

  Stream<ApiResult<GetBudgetAllocationResponse>>
      get responseGetBudgetingAllocationStream =>
          _responseGetBudgetingAllocationController.stream;

  Future<void> getBudgetingNew(Map<String, dynamic> body) async {
    try {
      final response = await _repository.getBudgetNew(body);
      _responseGetBudgetingNewController.sink.add(response);
    } catch (e) {
      console('getBudgetingNew - Error fetching data: $e');
      _responseGetBudgetingNewController.sink.add(
          ApiResult<GetBudgetNewResponse>(error: 'Failed to load data: $e'));
    }
  }

  Future<void> getBudgetAllocation(Map<String, dynamic> body) async {
    try {
      final response = await _repository.getBudgetAllocation(body);
      _responseGetBudgetingAllocationController.sink.add(response);
    } catch (e) {
      console('getBudgetAllocation - Error fetching data: $e');
      _responseGetBudgetingAllocationController.sink.add(
          ApiResult<GetBudgetAllocationResponse>(
              error: 'Failed to load data: $e'));
    }
  }

  void dispose() {
    _responseGetBudgetingNewController.close();
    _responseGetBudgetingAllocationController.close();
  }
}
