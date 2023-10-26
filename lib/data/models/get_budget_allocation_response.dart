class GetBudgetAllocationResponse {
  bool? status;
  String? message;
  BudgetAllocationModel? response;

  GetBudgetAllocationResponse({this.status, this.message, this.response});

  GetBudgetAllocationResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    response = json['Response'] != null
        ? BudgetAllocationModel.fromJson(json['Response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Message'] = message;
    if (response != null) {
      data['Response'] = response!.toJson();
    }
    return data;
  }
}

class BudgetAllocationModel {
  double? budgetTotal;
  double? accumTotal;
  int? total;
  String? fundRemaining;
  String? allocatedBudget;

  BudgetAllocationModel(
      {this.budgetTotal,
      this.accumTotal,
      this.total,
      this.fundRemaining,
      this.allocatedBudget});

  BudgetAllocationModel.fromJson(Map<String, dynamic> json) {
    budgetTotal = json['BudgetTotal'];
    accumTotal = json['AccumTotal'];
    total = json['Total'];
    fundRemaining = json['FundRemaining'];
    allocatedBudget = json['AllocatedBudget'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BudgetTotal'] = budgetTotal;
    data['AccumTotal'] = accumTotal;
    data['Total'] = total;
    data['FundRemaining'] = fundRemaining;
    data['AllocatedBudget'] = allocatedBudget;
    return data;
  }
}
