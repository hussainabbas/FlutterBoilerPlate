class GetTimesheetInitialErResponse {
  bool? status;
  String? message;
  bool? ddlSwitch;
  bool? isThirdPartyPaymentAllowed;
  TimesheetInitialErResponse? response;

  GetTimesheetInitialErResponse(
      {this.status,
      this.message,
      this.ddlSwitch,
      this.isThirdPartyPaymentAllowed,
      this.response});

  GetTimesheetInitialErResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    ddlSwitch = json['ddlSwitch'];
    isThirdPartyPaymentAllowed = json['IsThirdPartyPaymentAllowed'];
    response = json['Response'] != null
        ? TimesheetInitialErResponse.fromJson(json['Response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Message'] = message;
    data['ddlSwitch'] = ddlSwitch;
    data['IsThirdPartyPaymentAllowed'] = isThirdPartyPaymentAllowed;
    if (response != null) {
      data['Response'] = response!.toJson();
    }
    return data;
  }
}

class TimesheetInitialErResponse {
  List<EmployeeModel>? employee;
  List<PayComponentsModel>? payComponenets;
  List<ExpenseTypeModel>? expenseType;
  String? tobeNoted;

  TimesheetInitialErResponse(
      {this.employee, this.payComponenets, this.expenseType, this.tobeNoted});

  TimesheetInitialErResponse.fromJson(Map<String, dynamic> json) {
    if (json['Employee'] != null) {
      employee = <EmployeeModel>[];
      json['Employee'].forEach((v) {
        employee!.add(EmployeeModel.fromJson(v));
      });
    }
    if (json['PayComponenets'] != null) {
      payComponenets = <PayComponentsModel>[];
      json['PayComponenets'].forEach((v) {
        payComponenets!.add(PayComponentsModel.fromJson(v));
      });
    }
    if (json['ExpenseType'] != null) {
      expenseType = <ExpenseTypeModel>[];
      json['ExpenseType'].forEach((v) {
        expenseType!.add(ExpenseTypeModel.fromJson(v));
      });
    }
    tobeNoted = json['TobeNoted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (employee != null) {
      data['Employee'] = employee!.map((v) => v.toJson()).toList();
    }
    if (payComponenets != null) {
      data['PayComponenets'] = payComponenets!.map((v) => v.toJson()).toList();
    }
    if (expenseType != null) {
      data['ExpenseType'] = expenseType!.map((v) => v.toJson()).toList();
    }
    data['TobeNoted'] = tobeNoted;
    return data;
  }
}

class EmployeeModel {
  String? id;
  String? name;
  String? type;
  bool? isFamilyMemberEntitlement;

  EmployeeModel(
      {this.id, this.name, this.type, this.isFamilyMemberEntitlement});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    type = json['type'];
    isFamilyMemberEntitlement = json['isFamilyMemberEntitlement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['type'] = type;
    data['isFamilyMemberEntitlement'] = isFamilyMemberEntitlement;
    return data;
  }
}

class PayComponentsModel {
  Null? id;
  String? name;
  Null? value;
  int? intId;
  String? subGroup;
  bool? selected;
  Null? auxDate;
  Null? transcationstartDate;
  Null? transcationEndDate;
  bool? hasMondayised;
  Null? holidays;
  bool? isAgent;
  bool? hasChosenMondayised;
  Null? nzacDates;
  Null? message;
  int? publicHoliday;
  Null? holidayName;
  Null? customerNo;
  Null? invoiceRegex;
  Null? invoiceMessage;
  bool? shouldValidate;
  Null? accountTranslationId;
  Null? expensePayeeId;

  PayComponentsModel(
      {this.id,
      this.name,
      this.value,
      this.intId,
      this.subGroup,
      this.selected,
      this.auxDate,
      this.transcationstartDate,
      this.transcationEndDate,
      this.hasMondayised,
      this.holidays,
      this.isAgent,
      this.hasChosenMondayised,
      this.nzacDates,
      this.message,
      this.publicHoliday,
      this.holidayName,
      this.customerNo,
      this.invoiceRegex,
      this.invoiceMessage,
      this.shouldValidate,
      this.accountTranslationId,
      this.expensePayeeId});

  PayComponentsModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    value = json['Value'];
    intId = json['intId'];
    subGroup = json['SubGroup'];
    selected = json['Selected'];
    auxDate = json['AuxDate'];
    transcationstartDate = json['TranscationstartDate'];
    transcationEndDate = json['TranscationEndDate'];
    hasMondayised = json['HasMondayised'];
    holidays = json['Holidays'];
    isAgent = json['isAgent'];
    hasChosenMondayised = json['hasChosenMondayised'];
    nzacDates = json['nzacDates'];
    message = json['message'];
    publicHoliday = json['publicHoliday'];
    holidayName = json['holidayName'];
    customerNo = json['CustomerNo'];
    invoiceRegex = json['InvoiceRegex'];
    invoiceMessage = json['InvoiceMessage'];
    shouldValidate = json['ShouldValidate'];
    accountTranslationId = json['accountTranslationId'];
    expensePayeeId = json['ExpensePayeeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Value'] = value;
    data['intId'] = intId;
    data['SubGroup'] = subGroup;
    data['Selected'] = selected;
    data['AuxDate'] = auxDate;
    data['TranscationstartDate'] = transcationstartDate;
    data['TranscationEndDate'] = transcationEndDate;
    data['HasMondayised'] = hasMondayised;
    data['Holidays'] = holidays;
    data['isAgent'] = isAgent;
    data['hasChosenMondayised'] = hasChosenMondayised;
    data['nzacDates'] = nzacDates;
    data['message'] = message;
    data['publicHoliday'] = publicHoliday;
    data['holidayName'] = holidayName;
    data['CustomerNo'] = customerNo;
    data['InvoiceRegex'] = invoiceRegex;
    data['InvoiceMessage'] = invoiceMessage;
    data['ShouldValidate'] = shouldValidate;
    data['accountTranslationId'] = accountTranslationId;
    data['ExpensePayeeId'] = expensePayeeId;
    return data;
  }
}

class ExpenseTypeModel {
  String? id;
  String? name;
  int? intId;
  String? subGroup;
  bool? selected;
  Null? auxDate;
  int? accountTranslationId;
  int? expensePayeeId;

  ExpenseTypeModel(
      {this.id,
      this.name,
      this.intId,
      this.subGroup,
      this.selected,
      this.auxDate,
      this.accountTranslationId,
      this.expensePayeeId});

  ExpenseTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    intId = json['intId'];
    subGroup = json['SubGroup'];
    selected = json['Selected'];
    auxDate = json['AuxDate'];
    accountTranslationId = json['accountTranslationId'];
    expensePayeeId = json['ExpensePayeeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['intId'] = intId;
    data['SubGroup'] = subGroup;
    data['Selected'] = selected;
    data['AuxDate'] = auxDate;
    data['accountTranslationId'] = accountTranslationId;
    data['ExpensePayeeId'] = expensePayeeId;
    return data;
  }
}
