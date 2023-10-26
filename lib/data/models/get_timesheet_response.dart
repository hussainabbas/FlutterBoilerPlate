class GetTimesheetResponse {
  bool? status;
  String? message;
  int? totalPage;
  bool? isThirdPartyPaymentAllowed;
  bool? spendManagementSwitch;
  List<TimesheetItemModel>? response;

  GetTimesheetResponse(
      {this.status,
      this.message,
      this.totalPage,
      this.isThirdPartyPaymentAllowed,
      this.spendManagementSwitch,
      this.response});

  GetTimesheetResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    totalPage = json['TotalPage'];
    isThirdPartyPaymentAllowed = json['IsThirdPartyPaymentAllowed'];
    spendManagementSwitch = json['spendManagementSwitch'];
    if (json['Response'] != null) {
      response = <TimesheetItemModel>[];
      json['Response'].forEach((v) {
        response!.add(TimesheetItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Message'] = message;
    data['TotalPage'] = totalPage;
    data['IsThirdPartyPaymentAllowed'] = isThirdPartyPaymentAllowed;
    data['spendManagementSwitch'] = spendManagementSwitch;
    if (response != null) {
      data['Response'] = response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimesheetItemModel {
  Null? certifiedPlatform;
  Null? verifiedPlatform;
  int? userId;
  int? employerId;
  Null? userRole;
  int? timesheetId;
  String? statusCode;
  Null? autoProcessedDate;
  bool? isAbbreviated;
  String? statusCodeDisplay;
  Null? appovedByUserId;
  Null? approvedDate;
  int? employeeId;
  String? employeeCode;
  String? employeeTypeCode;
  bool? isSelfManagedSchedular;
  String? employeeName;
  String? employerName;
  String? accountTranslationName;
  String? timesheetType;
  double? totalHours;
  double? grossPay;
  String? totalAmount;
  Null? transactionPeriodId;
  String? transactionStartDate;
  Null? dateList;
  String? transactionEndDate;
  Null? copyTimesheetId;
  int? accountTranslationId;
  Null? certifiedByUserId;
  Null? certifiedDate;
  Null? totalPage;
  Null? spendManagementSwitch;
  Null? publicHoliday;
  Null? holidaySelections;
  Null? restrictedFundingList;

  TimesheetItemModel(
      {this.certifiedPlatform,
      this.verifiedPlatform,
      this.userId,
      this.employerId,
      this.userRole,
      this.timesheetId,
      this.statusCode,
      this.autoProcessedDate,
      this.isAbbreviated,
      this.statusCodeDisplay,
      this.appovedByUserId,
      this.approvedDate,
      this.employeeId,
      this.employeeCode,
      this.employeeTypeCode,
      this.isSelfManagedSchedular,
      this.employeeName,
      this.employerName,
      this.accountTranslationName,
      this.timesheetType,
      this.totalHours,
      this.grossPay,
      this.totalAmount,
      this.transactionPeriodId,
      this.transactionStartDate,
      this.dateList,
      this.transactionEndDate,
      this.copyTimesheetId,
      this.accountTranslationId,
      this.certifiedByUserId,
      this.certifiedDate,
      this.totalPage,
      this.spendManagementSwitch,
      this.publicHoliday,
      this.holidaySelections,
      this.restrictedFundingList});

  TimesheetItemModel.fromJson(Map<String, dynamic> json) {
    certifiedPlatform = json['CertifiedPlatform'];
    verifiedPlatform = json['VerifiedPlatform'];
    userId = json['UserId'];
    employerId = json['EmployerId'];
    userRole = json['UserRole'];
    timesheetId = json['TimesheetId'];
    statusCode = json['StatusCode'];
    autoProcessedDate = json['AutoProcessedDate'];
    isAbbreviated = json['IsAbbreviated'];
    statusCodeDisplay = json['StatusCodeDisplay'];
    appovedByUserId = json['AppovedByUserId'];
    approvedDate = json['ApprovedDate'];
    employeeId = json['EmployeeId'];
    employeeCode = json['EmployeeCode'];
    employeeTypeCode = json['EmployeeTypeCode'];
    isSelfManagedSchedular = json['IsSelfManagedSchedular'];
    employeeName = json['EmployeeName'];
    employerName = json['EmployerName'];
    accountTranslationName = json['AccountTranslationName'];
    timesheetType = json['TimesheetType'];
    totalHours = json['TotalHours'];
    grossPay = json['GrossPay'];
    totalAmount = json['TotalAmount'];
    transactionPeriodId = json['TransactionPeriodId'];
    transactionStartDate = json['TransactionStartDate'];
    dateList = json['DateList'];
    transactionEndDate = json['TransactionEndDate'];
    copyTimesheetId = json['CopyTimesheetId'];
    accountTranslationId = json['AccountTranslationId'];
    certifiedByUserId = json['CertifiedByUserId'];
    certifiedDate = json['CertifiedDate'];
    totalPage = json['TotalPage'];
    spendManagementSwitch = json['spendManagementSwitch'];
    publicHoliday = json['PublicHoliday'];
    holidaySelections = json['holidaySelections'];
    restrictedFundingList = json['RestrictedFundingList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CertifiedPlatform'] = certifiedPlatform;
    data['VerifiedPlatform'] = verifiedPlatform;
    data['UserId'] = userId;
    data['EmployerId'] = employerId;
    data['UserRole'] = userRole;
    data['TimesheetId'] = timesheetId;
    data['StatusCode'] = statusCode;
    data['AutoProcessedDate'] = autoProcessedDate;
    data['IsAbbreviated'] = isAbbreviated;
    data['StatusCodeDisplay'] = statusCodeDisplay;
    data['AppovedByUserId'] = appovedByUserId;
    data['ApprovedDate'] = approvedDate;
    data['EmployeeId'] = employeeId;
    data['EmployeeCode'] = employeeCode;
    data['EmployeeTypeCode'] = employeeTypeCode;
    data['IsSelfManagedSchedular'] = isSelfManagedSchedular;
    data['EmployeeName'] = employeeName;
    data['EmployerName'] = employerName;
    data['AccountTranslationName'] = accountTranslationName;
    data['TimesheetType'] = timesheetType;
    data['TotalHours'] = totalHours;
    data['GrossPay'] = grossPay;
    data['TotalAmount'] = totalAmount;
    data['TransactionPeriodId'] = transactionPeriodId;
    data['TransactionStartDate'] = transactionStartDate;
    data['DateList'] = dateList;
    data['TransactionEndDate'] = transactionEndDate;
    data['CopyTimesheetId'] = copyTimesheetId;
    data['AccountTranslationId'] = accountTranslationId;
    data['CertifiedByUserId'] = certifiedByUserId;
    data['CertifiedDate'] = certifiedDate;
    data['TotalPage'] = totalPage;
    data['spendManagementSwitch'] = spendManagementSwitch;
    data['PublicHoliday'] = publicHoliday;
    data['holidaySelections'] = holidaySelections;
    data['RestrictedFundingList'] = restrictedFundingList;
    return data;
  }
}
