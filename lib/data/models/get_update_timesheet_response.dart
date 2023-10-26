class GetUpdateTimesheetResponse {
  bool? status;
  String? message;
  UpdateTimesheetResponse? response;

  GetUpdateTimesheetResponse({this.status, this.message, this.response});

  GetUpdateTimesheetResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    response = json['Response'] != null
        ? UpdateTimesheetResponse.fromJson(json['Response'])
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

class UpdateTimesheetResponse {
  String? certifiedPlatform;
  String? verifiedPlatform;
  int? userId;
  int? employerId;
  String? userRole;
  int? timesheetId;
  String? statusCode;
  bool? isAbbreviated;
  String? statusCodeDisplay;
  String? approvedByUserId;
  String? approvedDate;
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
  int? transactionPeriodId;
  String? transactionStartDate;
  List<String>? dateList;
  String? transactionEndDate;
  int? copyTimesheetId;
  int? accountTranslationId;
  int? certifiedByUserId;
  String? certifiedDate;
  int? totalPage;
  bool? spendManagementSwitch;
  List<PublicHolidayModel>? publicHoliday;
  String? holidaySelections;
  List<String>? restrictedFundingList;

  UpdateTimesheetResponse(
      {this.certifiedPlatform,
      this.verifiedPlatform,
      this.userId,
      this.employerId,
      this.userRole,
      this.timesheetId,
      this.statusCode,
      this.isAbbreviated,
      this.statusCodeDisplay,
      this.approvedByUserId,
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

  UpdateTimesheetResponse.fromJson(Map<String, dynamic> json) {
    certifiedPlatform = json['CertifiedPlatform'];
    verifiedPlatform = json['VerifiedPlatform'];
    userId = json['UserId'];
    employerId = json['EmployerId'];
    userRole = json['UserRole'];
    timesheetId = json['TimesheetId'];
    statusCode = json['StatusCode'];
    isAbbreviated = json['IsAbbreviated'];
    statusCodeDisplay = json['StatusCodeDisplay'];
    approvedByUserId = json['ApprovedByUserId'];
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
    if (json['DateList'] != null) {
      dateList = json['DateList'].cast<String>();
    }

    transactionEndDate = json['TransactionEndDate'];
    copyTimesheetId = json['CopyTimesheetId'];
    accountTranslationId = json['AccountTranslationId'];
    certifiedByUserId = json['CertifiedByUserId'];
    certifiedDate = json['CertifiedDate'];
    totalPage = json['TotalPage'];
    spendManagementSwitch = json['spendManagementSwitch'];
    if (json['PublicHoliday'] != null) {
      publicHoliday = <PublicHolidayModel>[];
      json['PublicHoliday'].forEach((v) {
        publicHoliday!.add(PublicHolidayModel.fromJson(v));
      });
    }
    holidaySelections = json['holidaySelections'];
    if (json['RestrictedFundingList'] != null) {
      restrictedFundingList = json['RestrictedFundingList'].cast<String>();
    }
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
    data['IsAbbreviated'] = isAbbreviated;
    data['StatusCodeDisplay'] = statusCodeDisplay;
    data['ApprovedByUserId'] = approvedByUserId;
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
    if (publicHoliday != null) {
      data['PublicHoliday'] = publicHoliday!.map((v) => v.toJson()).toList();
    }
    data['holidaySelections'] = holidaySelections;
    if (restrictedFundingList != null) {
      data['RestrictedFundingList'] = restrictedFundingList;
    }

    return data;
  }
}

class PublicHolidayModel {
  String? date;

  PublicHolidayModel({this.date});

  PublicHolidayModel.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Date'] = date;
    return data;
  }
}
