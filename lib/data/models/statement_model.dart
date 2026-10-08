import 'package:manawanui/data/models/dynamics_statement_model.dart';
import 'package:manawanui/data/models/get_employee_payee_initials_response.dart';
import 'package:manawanui/data/models/report_headers_model.dart';
import 'package:manawanui/data/models/report_items_model.dart';

class StatementResponseModel {
  DynamicsStatementModel? dynamicsStatement;
  double? averagedFunding;
  String? displayType;
  int? spendType;
  String? spendTypeCode;
  String? htmlText;
  String? mainText;
  String? detailText;
  bool? newFormat;
  String? statementDate;
  String? nASCReviewDate;
  int? employerId;
  int? clientReportId;
  int? supportPlanId;
  bool? showWarning;
  String? clientServiceCategoryName;
  bool? multiFamily;
  GenericIdValueModel? client;
  GenericIdValueModel? funder;
  GenericIdValueModel? funderStartDate;
  List<ReportItemsModel>? reportItems;
  List<ReportHeadersModel>? reportHeaders;
  String? clientCategorySupportPlanList;
  String? holidayPayAmount;
  String? holidayPayDate;
  String? cutOffDate;
  double? totalBudgetSupprotPlan;
  double? totalSpend;
  double? totalFundsRemaining;
  int? totalSpentPercentage;
  int? averagedFundingPercentage;

  StatementResponseModel(
      {this.dynamicsStatement,
      this.averagedFunding,
      this.displayType,
      this.spendType,
      this.spendTypeCode,
      this.htmlText,
      this.newFormat,
      this.statementDate,
      this.nASCReviewDate,
      this.employerId,
      this.clientReportId,
      this.supportPlanId,
      this.showWarning,
      this.clientServiceCategoryName,
      this.multiFamily,
      this.client,
      this.funder,
      this.funderStartDate,
      this.reportItems,
      this.reportHeaders,
      this.clientCategorySupportPlanList,
      this.holidayPayAmount,
      this.holidayPayDate,
      this.cutOffDate,
      this.totalBudgetSupprotPlan,
      this.totalSpend,
      this.totalFundsRemaining,
      this.totalSpentPercentage,
      this.mainText,
      this.detailText,
      this.averagedFundingPercentage});

  StatementResponseModel.fromJson(Map<String, dynamic> json) {
    dynamicsStatement = json['DynamicsStatement'] != null
        ? DynamicsStatementModel.fromJson(json['DynamicsStatement'])
        : null;
    averagedFunding = json['AveragedFunding'];
    displayType = json['DisplayType'];
    spendType = json['SpendType'];
    spendTypeCode = json['SpendTypeCode'];
    htmlText = json['HtmlText'];
    newFormat = json['NewFormat'];
    statementDate = json['StatementDate'];
    nASCReviewDate = json['NASCReviewDate'];
    employerId = json['EmployerId'];
    clientReportId = json['ClientReportId'];
    supportPlanId = json['SupportPlanId'];
    mainText = json['MainText'];
    detailText = json['DetailText'];
    showWarning = json['ShowWarning'];
    clientServiceCategoryName = json['ClientServiceCategoryName'];
    multiFamily = json['MultiFamily'];
    client = json['Client'] != null
        ? GenericIdValueModel.fromJson(json['Client'])
        : null;
    funder = json['Funder'] != null
        ? GenericIdValueModel.fromJson(json['Funder'])
        : null;
    funderStartDate = json['FunderStartDate'] != null
        ? GenericIdValueModel.fromJson(json['FunderStartDate'])
        : null;
    if (json['ReportItems'] != null) {
      reportItems = <ReportItemsModel>[];
      json['ReportItems'].forEach((v) {
        reportItems!.add(ReportItemsModel.fromJson(v));
      });
    }
    if (json['ReportHeaders'] != null) {
      reportHeaders = <ReportHeadersModel>[];
      json['ReportHeaders'].forEach((v) {
        reportHeaders!.add(ReportHeadersModel.fromJson(v));
      });
    }
    clientCategorySupportPlanList = json['ClientCategorySupportPlanList'];
    holidayPayAmount = json['HolidayPayAmount'];
    holidayPayDate = json['HolidayPayDate'];
    cutOffDate = json['CutOffDate'];
    totalBudgetSupprotPlan = json['TotalBudgetSupprotPlan'];
    totalSpend = json['TotalSpend'];
    totalFundsRemaining = json['TotalFundsRemaining'];
    totalSpentPercentage = json['TotalSpentPercentage'];
    averagedFundingPercentage = json['AveragedFundingPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dynamicsStatement != null) {
      data['DynamicsStatement'] = dynamicsStatement!.toJson();
    }
    data['AveragedFunding'] = averagedFunding;
    data['DisplayType'] = displayType;
    data['SpendType'] = spendType;
    data['SpendTypeCode'] = spendTypeCode;
    data['HtmlText'] = htmlText;
    data['NewFormat'] = newFormat;
    data['StatementDate'] = statementDate;
    data['NASCReviewDate'] = nASCReviewDate;
    data['EmployerId'] = employerId;
    data['ClientReportId'] = clientReportId;
    data['SupportPlanId'] = supportPlanId;
    data['MainText'] = mainText;
    data['DetailText'] = detailText;
    data['ShowWarning'] = showWarning;
    data['ClientServiceCategoryName'] = clientServiceCategoryName;
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
    if (reportItems != null) {
      data['ReportItems'] = reportItems!.map((v) => v.toJson()).toList();
    }
    if (reportHeaders != null) {
      data['ReportHeaders'] = reportHeaders!.map((v) => v.toJson()).toList();
    }
    data['ClientCategorySupportPlanList'] = clientCategorySupportPlanList;
    data['HolidayPayAmount'] = holidayPayAmount;
    data['HolidayPayDate'] = holidayPayDate;
    data['CutOffDate'] = cutOffDate;
    data['TotalBudgetSupprotPlan'] = totalBudgetSupprotPlan;
    data['TotalSpend'] = totalSpend;
    data['TotalFundsRemaining'] = totalFundsRemaining;
    data['TotalSpentPercentage'] = totalSpentPercentage;
    data['AveragedFundingPercentage'] = averagedFundingPercentage;
    return data;
  }
}
