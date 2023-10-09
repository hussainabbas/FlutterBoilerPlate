import 'package:manawanui/data/models/client_model.dart';
import 'package:manawanui/data/models/funder_model.dart';
import 'package:manawanui/data/models/funder_start_date_model.dart';

class GetBudgetNewResponse {
  bool? status;
  String? message;
  BudgetNewModel? response;

  GetBudgetNewResponse({this.status, this.message, this.response});

  GetBudgetNewResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    response = json['Response'] != null
        ? BudgetNewModel.fromJson(json['Response'])
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

class BudgetNewModel {
  bool? multiFamily;
  ClientModel? client;
  FunderModel? funder;
  FunderStartDateModel? funderStartDate;
  double? currentSpend;
  double? budgetLeft;
  int? employerId;
  int? clientReportId;
  String? fundingStartDate;
  double? accumulativeFundRemaining;
  String? budgetStartsBlurb;
  SupportPlanModel? supportPlan;
  List<BudgetEmployeesModel>? budgetEmployees;
  List<BudgetExpensesModel>? budgetExpenses;

  BudgetNewModel(
      {this.multiFamily,
      this.client,
      this.funder,
      this.funderStartDate,
      this.currentSpend,
      this.budgetLeft,
      this.employerId,
      this.clientReportId,
      this.fundingStartDate,
      this.accumulativeFundRemaining,
      this.budgetStartsBlurb,
      this.supportPlan,
      this.budgetEmployees,
      this.budgetExpenses});

  BudgetNewModel.fromJson(Map<String, dynamic> json) {
    multiFamily = json['MultiFamily'];
    client =
        json['Client'] != null ? ClientModel.fromJson(json['Client']) : null;
    funder =
        json['Funder'] != null ? FunderModel.fromJson(json['Funder']) : null;
    funderStartDate = json['FunderStartDate'] != null
        ? FunderStartDateModel.fromJson(json['FunderStartDate'])
        : null;
    currentSpend = json['CurrentSpend'];
    budgetLeft = json['BudgetLeft'];
    employerId = json['EmployerId'];
    clientReportId = json['ClientReportId'];
    fundingStartDate = json['FundingStartDate'];
    accumulativeFundRemaining = json['AccumulativeFundRemaining'];
    budgetStartsBlurb = json['BudgetStartsBlurb'];
    supportPlan = json['SupportPlan'] != null
        ? SupportPlanModel.fromJson(json['SupportPlan'])
        : null;
    if (json['BudgetEmployees'] != null) {
      budgetEmployees = <BudgetEmployeesModel>[];
      json['BudgetEmployees'].forEach((v) {
        budgetEmployees!.add(BudgetEmployeesModel.fromJson(v));
      });
    }
    if (json['BudgetExpenses'] != null) {
      budgetExpenses = <BudgetExpensesModel>[];
      json['BudgetExpenses'].forEach((v) {
        budgetExpenses!.add(BudgetExpensesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MultiFamily'] = multiFamily;
    if (client != null) {
      data['Client'] = client!.toJson();
    }
    if (funder != null) {
      data['Funder'] = funder!.toJson();
    }
    if (funderStartDate != null) {
      data['FunderStartDate'] = funderStartDate!.toJson();
    }
    data['CurrentSpend'] = currentSpend;
    data['BudgetLeft'] = budgetLeft;
    data['EmployerId'] = employerId;
    data['ClientReportId'] = clientReportId;
    data['FundingStartDate'] = fundingStartDate;
    data['AccumulativeFundRemaining'] = accumulativeFundRemaining;
    data['BudgetStartsBlurb'] = budgetStartsBlurb;
    if (supportPlan != null) {
      data['SupportPlan'] = supportPlan!.toJson();
    }
    if (budgetEmployees != null) {
      data['BudgetEmployees'] =
          budgetEmployees!.map((v) => v.toJson()).toList();
    }
    if (budgetExpenses != null) {
      data['BudgetExpenses'] = budgetExpenses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupportPlanModel {
  int? supportPlanId;
  double? totalBudget;
  int? clientId;
  String? clientName;
  int? funderId;
  String? funderName;
  String? startDate;
  String? endDate;

  SupportPlanModel(
      {this.supportPlanId,
      this.totalBudget,
      this.clientId,
      this.clientName,
      this.funderId,
      this.funderName,
      this.startDate,
      this.endDate});

  SupportPlanModel.fromJson(Map<String, dynamic> json) {
    supportPlanId = json['SupportPlanId'];
    totalBudget = json['TotalBudget'];
    clientId = json['ClientId'];
    clientName = json['ClientName'];
    funderId = json['FunderId'];
    funderName = json['FunderName'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SupportPlanId'] = supportPlanId;
    data['TotalBudget'] = totalBudget;
    data['ClientId'] = clientId;
    data['ClientName'] = clientName;
    data['FunderId'] = funderId;
    data['FunderName'] = funderName;
    data['StartDate'] = startDate;
    data['EndDate'] = endDate;
    return data;
  }
}

class BudgetEmployeesModel {
  int? budgetEmployeeId;
  int? employeeId;
  String? startDate;
  String? endDate;
  int? hours;
  String? frequencyCode;
  String? employeeTypeCode;
  String? frequencyDisplay;
  String? employeeName;
  double? standardPayRate;
  int? hourlyRate;
  double? inclusiveRate;
  double? inclusiveWeekendRate;
  double? inclusiveNightRate;
  int? weekendHours;
  double? weekendRate;
  int? nightHours;
  double? nightRate;
  double? inclusiveAmountForPeriod;

  BudgetEmployeesModel(
      {this.budgetEmployeeId,
      this.employeeId,
      this.startDate,
      this.endDate,
      this.hours,
      this.frequencyCode,
      this.employeeTypeCode,
      this.frequencyDisplay,
      this.employeeName,
      this.standardPayRate,
      this.hourlyRate,
      this.inclusiveRate,
      this.inclusiveWeekendRate,
      this.inclusiveNightRate,
      this.weekendHours,
      this.weekendRate,
      this.nightHours,
      this.nightRate,
      this.inclusiveAmountForPeriod});

  BudgetEmployeesModel.fromJson(Map<String, dynamic> json) {
    budgetEmployeeId = json['BudgetEmployeeId'];
    employeeId = json['EmployeeId'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    hours = json['Hours'];
    frequencyCode = json['FrequencyCode'];
    employeeTypeCode = json['EmployeeTypeCode'];
    frequencyDisplay = json['FrequencyDisplay'];
    employeeName = json['EmployeeName'];
    standardPayRate = json['StandardPayRate'];
    hourlyRate = json['HourlyRate'];
    inclusiveRate = json['InclusiveRate'];
    inclusiveWeekendRate = json['InclusiveWeekendRate'];
    inclusiveNightRate = json['InclusiveNightRate'];
    weekendHours = json['WeekendHours'];
    weekendRate = json['WeekendRate'];
    nightHours = json['NightHours'];
    nightRate = json['NightRate'];
    inclusiveAmountForPeriod = json['InclusiveAmountForPeriod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BudgetEmployeeId'] = budgetEmployeeId;
    data['EmployeeId'] = employeeId;
    data['StartDate'] = startDate;
    data['EndDate'] = endDate;
    data['Hours'] = hours;
    data['FrequencyCode'] = frequencyCode;
    data['EmployeeTypeCode'] = employeeTypeCode;
    data['FrequencyDisplay'] = frequencyDisplay;
    data['EmployeeName'] = employeeName;
    data['StandardPayRate'] = standardPayRate;
    data['HourlyRate'] = hourlyRate;
    data['InclusiveRate'] = inclusiveRate;
    data['InclusiveWeekendRate'] = inclusiveWeekendRate;
    data['InclusiveNightRate'] = inclusiveNightRate;
    data['WeekendHours'] = weekendHours;
    data['WeekendRate'] = weekendRate;
    data['NightHours'] = nightHours;
    data['NightRate'] = nightRate;
    data['InclusiveAmountForPeriod'] = inclusiveAmountForPeriod;
    return data;
  }
}

class BudgetExpensesModel {
  int? budgetExpenseId;
  int? userId;
  int? employerId;
  int? employeeId;
  String? employeeName;
  String? supportPlanId;
  String? startDate;
  String? endDate;
  int? amount;
  String? description;
  String? frequencyCode;
  String? frequencyDisplay;
  double? inclusiveAmount;
  String? createdBy;
  String? modifiedBy;
  String? periodStartDate;
  String? periodEndDate;

  BudgetExpensesModel(
      {this.budgetExpenseId,
      this.userId,
      this.employerId,
      this.employeeId,
      this.employeeName,
      this.supportPlanId,
      this.startDate,
      this.endDate,
      this.amount,
      this.description,
      this.frequencyCode,
      this.frequencyDisplay,
      this.inclusiveAmount,
      this.createdBy,
      this.modifiedBy,
      this.periodStartDate,
      this.periodEndDate});

  BudgetExpensesModel.fromJson(Map<String, dynamic> json) {
    budgetExpenseId = json['BudgetExpenseId'];
    userId = json['UserId'];
    employerId = json['EmployerId'];
    employeeId = json['EmployeeId'];
    employeeName = json['EmployeeName'];
    supportPlanId = json['SupportPlanId'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    amount = json['Amount'];
    description = json['Description'];
    frequencyCode = json['FrequencyCode'];
    frequencyDisplay = json['FrequencyDisplay'];
    inclusiveAmount = json['InclusiveAmount'];
    createdBy = json['CreatedBy'];
    modifiedBy = json['ModifiedBy'];
    periodStartDate = json['PeriodStartDate'];
    periodEndDate = json['PeriodEndDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BudgetExpenseId'] = budgetExpenseId;
    data['UserId'] = userId;
    data['EmployerId'] = employerId;
    data['EmployeeId'] = employeeId;
    data['EmployeeName'] = employeeName;
    data['SupportPlanId'] = supportPlanId;
    data['StartDate'] = startDate;
    data['EndDate'] = endDate;
    data['Amount'] = amount;
    data['Description'] = description;
    data['FrequencyCode'] = frequencyCode;
    data['FrequencyDisplay'] = frequencyDisplay;
    data['InclusiveAmount'] = inclusiveAmount;
    data['CreatedBy'] = createdBy;
    data['ModifiedBy'] = modifiedBy;
    data['PeriodStartDate'] = periodStartDate;
    data['PeriodEndDate'] = periodEndDate;
    return data;
  }
}
