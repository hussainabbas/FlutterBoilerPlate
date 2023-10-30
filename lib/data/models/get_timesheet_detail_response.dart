class GetTimesheetDetailResponse {
  bool? status;
  String? message;
  Response? response;

  GetTimesheetDetailResponse({this.status, this.message, this.response});

  GetTimesheetDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    response =
        json['Response'] != null ? Response.fromJson(json['Response']) : null;
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

class Response {
  int? userId;
  int? timesheetId;
  int? employerId;
  int? employeeId;
  String? employeeName;
  String? employerName;
  String? employeeStatus;
  bool? isSelfManagedSchedular;
  String? transactionEndDate;
  String? transactionStartDate;
  int? publicHolidayPayComponentId;
  int? publicHolidayPayComponentId2;
  double? timesheetTotalHour;
  double? totalExpense;
  double? totalPayment;
  String? timeSheetStatusCode;
  String? timeSheetStatus;
  String? approvalBlurb;
  Null? autoProcessedDate;
  bool? isAbbreviated;
  List<PublicHoliday>? publicHoliday;
  List<ExpenseList>? restrictedFundingList;
  List<ExpenseList>? timesheetItemList;
  List<ExpenseList>? expenseList;
  List<ExpenseList>? paymentList;
  bool? showTimesheetBlock;
  bool? showPaymentBlock;
  bool? partiallyApproved;

  Response(
      {this.userId,
      this.timesheetId,
      this.employerId,
      this.employeeId,
      this.employeeName,
      this.employerName,
      this.employeeStatus,
      this.isSelfManagedSchedular,
      this.transactionEndDate,
      this.transactionStartDate,
      this.publicHolidayPayComponentId,
      this.publicHolidayPayComponentId2,
      this.timesheetTotalHour,
      this.totalExpense,
      this.totalPayment,
      this.timeSheetStatusCode,
      this.timeSheetStatus,
      this.approvalBlurb,
      this.autoProcessedDate,
      this.isAbbreviated,
      this.publicHoliday,
      this.restrictedFundingList,
      this.timesheetItemList,
      this.expenseList,
      this.paymentList,
      this.showTimesheetBlock,
      this.showPaymentBlock,
      this.partiallyApproved});

  Response.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    timesheetId = json['TimesheetId'];
    employerId = json['EmployerId'];
    employeeId = json['EmployeeId'];
    employeeName = json['EmployeeName'];
    employerName = json['EmployerName'];
    employeeStatus = json['EmployeeStatus'];
    isSelfManagedSchedular = json['IsSelfManagedSchedular'];
    transactionEndDate = json['TransactionEndDate'];
    transactionStartDate = json['TransactionStartDate'];
    publicHolidayPayComponentId = json['PublicHolidayPayComponentId'];
    publicHolidayPayComponentId2 = json['PublicHolidayPayComponentId2'];
    timesheetTotalHour = json['TimesheetTotalHour'];
    totalExpense = json['TotalExpense'];
    totalPayment = json['TotalPayment'];
    timeSheetStatusCode = json['TimeSheetStatusCode'];
    timeSheetStatus = json['TimeSheetStatus'];
    approvalBlurb = json['ApprovalBlurb'];
    autoProcessedDate = json['AutoProcessedDate'];
    isAbbreviated = json['IsAbbreviated'];
    if (json['PublicHoliday'] != null) {
      publicHoliday = <PublicHoliday>[];
      json['PublicHoliday'].forEach((v) {
        publicHoliday!.add(PublicHoliday.fromJson(v));
      });
    }
    if (json['RestrictedFundingList'] != null) {
      restrictedFundingList = <ExpenseList>[];
      json['RestrictedFundingList'].forEach((v) {
        restrictedFundingList!.add(ExpenseList.fromJson(v));
      });
    }
    if (json['TimesheetItemList'] != null) {
      timesheetItemList = <ExpenseList>[];
      json['TimesheetItemList'].forEach((v) {
        timesheetItemList!.add(ExpenseList.fromJson(v));
      });
    }
    if (json['ExpenseList'] != null) {
      expenseList = <ExpenseList>[];
      json['ExpenseList'].forEach((v) {
        expenseList!.add(ExpenseList.fromJson(v));
      });
    }
    if (json['PaymentList'] != null) {
      paymentList = <ExpenseList>[];
      json['PaymentList'].forEach((v) {
        paymentList!.add(ExpenseList.fromJson(v));
      });
    }
    showTimesheetBlock = json['ShowTimesheetBlock'];
    showPaymentBlock = json['ShowPaymentBlock'];
    partiallyApproved = json['PartiallyApproved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = userId;
    data['TimesheetId'] = timesheetId;
    data['EmployerId'] = employerId;
    data['EmployeeId'] = employeeId;
    data['EmployeeName'] = employeeName;
    data['EmployerName'] = employerName;
    data['EmployeeStatus'] = employeeStatus;
    data['IsSelfManagedSchedular'] = isSelfManagedSchedular;
    data['TransactionEndDate'] = transactionEndDate;
    data['TransactionStartDate'] = transactionStartDate;
    data['PublicHolidayPayComponentId'] = publicHolidayPayComponentId;
    data['PublicHolidayPayComponentId2'] = publicHolidayPayComponentId2;
    data['TimesheetTotalHour'] = timesheetTotalHour;
    data['TotalExpense'] = totalExpense;
    data['TotalPayment'] = totalPayment;
    data['TimeSheetStatusCode'] = timeSheetStatusCode;
    data['TimeSheetStatus'] = timeSheetStatus;
    data['ApprovalBlurb'] = approvalBlurb;
    data['AutoProcessedDate'] = autoProcessedDate;
    data['IsAbbreviated'] = isAbbreviated;
    if (publicHoliday != null) {
      data['PublicHoliday'] = publicHoliday!.map((v) => v.toJson()).toList();
    }
    if (restrictedFundingList != null) {
      data['RestrictedFundingList'] =
          restrictedFundingList!.map((v) => v.toJson()).toList();
    }
    if (timesheetItemList != null) {
      data['TimesheetItemList'] =
          timesheetItemList!.map((v) => v.toJson()).toList();
    }
    if (expenseList != null) {
      data['ExpenseList'] = expenseList!.map((v) => v.toJson()).toList();
    }
    if (paymentList != null) {
      data['PaymentList'] = paymentList!.map((v) => v.toJson()).toList();
    }
    data['ShowTimesheetBlock'] = showTimesheetBlock;
    data['ShowPaymentBlock'] = showPaymentBlock;
    data['PartiallyApproved'] = partiallyApproved;
    return data;
  }
}

class PublicHoliday {
  String? date;

  PublicHoliday({this.date});

  PublicHoliday.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Date'] = date;
    return data;
  }
}

class ExpenseList {
  int? expenseId;
  int? timesheetId;
  int? accountTranslationId;
  String? clientName;
  Null? employeeId;
  String? employeeName;
  int? payComponentId;
  String? payComponentName;
  Null? expenseTypeId;
  Null? expenseTypeName;
  String? expenseDate;
  double? amount;
  double? hoursWorked;
  String? particulars;
  String? clientServiceCategoryName;
  bool? approved;
  double? approxCost;
  Null? documants;

  ExpenseList(
      {this.expenseId,
      this.timesheetId,
      this.accountTranslationId,
      this.clientName,
      this.employeeId,
      this.employeeName,
      this.payComponentId,
      this.payComponentName,
      this.expenseTypeId,
      this.expenseTypeName,
      this.expenseDate,
      this.amount,
      this.hoursWorked,
      this.particulars,
      this.clientServiceCategoryName,
      this.approved,
      this.approxCost,
      this.documants});

  ExpenseList.fromJson(Map<String, dynamic> json) {
    expenseId = json['ExpenseId'];
    timesheetId = json['TimesheetId'];
    accountTranslationId = json['AccountTranslationId'];
    clientName = json['ClientName'];
    employeeId = json['EmployeeId'];
    employeeName = json['EmployeeName'];
    payComponentId = json['PayComponentId'];
    payComponentName = json['PayComponentName'];
    expenseTypeId = json['ExpenseTypeId'];
    expenseTypeName = json['ExpenseTypeName'];
    expenseDate = json['ExpenseDate'];
    amount = json['Amount'];
    hoursWorked = json['HoursWorked'];
    particulars = json['Particulars'];
    clientServiceCategoryName = json['ClientServiceCategoryName'];
    approved = json['Approved'];
    approxCost = json['ApproxCost'];
    documants = json['documents'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ExpenseId'] = expenseId;
    data['TimesheetId'] = timesheetId;
    data['AccountTranslationId'] = accountTranslationId;
    data['ClientName'] = clientName;
    data['EmployeeId'] = employeeId;
    data['EmployeeName'] = employeeName;
    data['PayComponentId'] = payComponentId;
    data['PayComponentName'] = payComponentName;
    data['ExpenseTypeId'] = expenseTypeId;
    data['ExpenseTypeName'] = expenseTypeName;
    data['ExpenseDate'] = expenseDate;
    data['Amount'] = amount;
    data['HoursWorked'] = hoursWorked;
    data['Particulars'] = particulars;
    data['ClientServiceCategoryName'] = clientServiceCategoryName;
    data['Approved'] = approved;
    data['ApproxCost'] = approxCost;
    data['documants'] = documants;
    return data;
  }
}
