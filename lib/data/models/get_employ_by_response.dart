import 'package:image_picker/image_picker.dart';

class GetEmployByResponse {
  bool? status;
  String? message;
  int? totalPage;
  bool? isThirdPartyPaymentAllowed;
  List<EmployByModel>? response;

  GetEmployByResponse(
      {this.status,
      this.message,
    this.totalPage,
    this.isThirdPartyPaymentAllowed,
    this.response});

  GetEmployByResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    totalPage = json['TotalPage'];
    isThirdPartyPaymentAllowed = json['IsThirdPartyPaymentAllowed'];
    if (json['Response'] != null) {
      response = <EmployByModel>[];
      json['Response'].forEach((v) {
        response!.add(EmployByModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Message'] = message;
    data['TotalPage'] = totalPage;
    data['IsThirdPartyPaymentAllowed'] = isThirdPartyPaymentAllowed;
    if (response != null) {
      data['Response'] = response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmployByModel {
  int? employeeId;
  int? employerId;
  String? employeeCode;
  int? userId;
  int? thirdPartyProviderId;
  int? employmentStatusContentListId;
  int? employmentStatusContentList;
  int? regionContentListId;
  String? regionContentList;
  String? employeeTypeCode;
  String? employeeTypeDisplay;
  bool? isAgent;
  String? supportingDisplay;
  String? employeeStatusCode;
  String? employeeStatusName;
  String? emailPayslipCode;
  String? emailPayslipDisplay;
  String? address1;
  String? address2;
  String? city;
  bool? inviteToPortal;
  bool? privacyNoticeChecked;
  String? fullName;
  String? fullAddress;
  String? firstName;
  String? lastName;
  String? knownAs;
  String? dateofBirth;
  int? genderContentListId;
  String? genderContentList;
  int? titleContentListId;
  String? titleContentList;
  String? email;
  String? irdNumber;
  bool? isAgentEmployee;
  String? homePhone;
  String? workPhone;
  String? mobilePhone;
  String? occupation;
  int? taxCodeContentListId;
  String? taxCodeContentList;
  int? kiwiSaverContentListId;
  String? kiwiSaverContentList;
  int? leaveEntitlementContentListId;
  String? leaveEntitlementContentList;
  String? startDate;
  bool? hasKiwiSaver;
  double? childSupportAmount;
  int? bankSuffix;
  int? bankCompany;
  int? bankAccountNumber;
  int? bankBranch;
  String? fullBankAccountNumber;
  double? standardPayRate;
  double? nightPayRate;
  double? weekendPayRate;
  List<DocumentsModel>? documents;
  List<DocumentTypeModel>? documentType;
  List<PaySlipModel>? paySlip;
  String? effectiveDate;
  bool? isSelfManaged;
  double? withholdingTaxRate;
  bool? gstRegistered;
  String? payGroup;
  String? datapayCompany;
  String? terminationDate;
  int? terminationReasonContentListId;
  String? terminationReasonDisplay;
  String? terminationComments;
  bool? terminationContinuePayUntilDate;
  String? terminationPayOutHoliday;
  String? terminationPayOutLieu;
  String? terminationPayOutAnnual;

  EmployByModel({this.employeeId,
    this.employerId,
    this.employeeCode,
    this.userId,
    this.thirdPartyProviderId,
    this.employmentStatusContentListId,
    this.employmentStatusContentList,
    this.regionContentListId,
    this.regionContentList,
    this.employeeTypeCode,
    this.employeeTypeDisplay,
    this.isAgent,
    this.supportingDisplay,
    this.employeeStatusCode,
    this.employeeStatusName,
    this.emailPayslipCode,
    this.emailPayslipDisplay,
    this.address1,
    this.address2,
    this.city,
    this.inviteToPortal,
    this.privacyNoticeChecked,
    this.fullName,
    this.fullAddress,
    this.firstName,
    this.lastName,
    this.knownAs,
    this.dateofBirth,
    this.genderContentListId,
    this.genderContentList,
    this.titleContentListId,
    this.titleContentList,
    this.email,
    this.irdNumber,
    this.isAgentEmployee,
    this.homePhone,
    this.workPhone,
    this.mobilePhone,
    this.occupation,
    this.taxCodeContentListId,
    this.taxCodeContentList,
    this.kiwiSaverContentListId,
    this.kiwiSaverContentList,
    this.leaveEntitlementContentListId,
    this.leaveEntitlementContentList,
    this.startDate,
    this.hasKiwiSaver,
    this.childSupportAmount,
    this.bankSuffix,
    this.bankCompany,
    this.bankAccountNumber,
    this.bankBranch,
    this.fullBankAccountNumber,
    this.standardPayRate,
    this.nightPayRate,
    this.weekendPayRate,
    this.documents,
    this.documentType,
    this.paySlip,
    this.effectiveDate,
    this.isSelfManaged,
    this.withholdingTaxRate,
    this.gstRegistered,
    this.payGroup,
    this.datapayCompany,
    this.terminationDate,
    this.terminationReasonContentListId,
    this.terminationReasonDisplay,
    this.terminationComments,
    this.terminationContinuePayUntilDate,
    this.terminationPayOutHoliday,
    this.terminationPayOutLieu,
    this.terminationPayOutAnnual});

  EmployByModel.fromJson(Map<String, dynamic> json) {
    employeeId = json['EmployeeId'];
    employerId = json['EmployerId'];
    employeeCode = json['EmployeeCode'];
    userId = json['UserId'];
    thirdPartyProviderId = json['ThirdPartyProviderId'];
    employmentStatusContentListId = json['EmploymentStatusContentListId'];
    employmentStatusContentList = json['EmploymentStatusContentList'];
    regionContentListId = json['RegionContentListId'];
    regionContentList = json['RegionContentList'];
    employeeTypeCode = json['EmployeeTypeCode'];
    employeeTypeDisplay = json['EmployeeTypeDisplay'];
    isAgent = json['IsAgent'];
    supportingDisplay = json['SupportingDisplay'];
    employeeStatusCode = json['EmployeeStatusCode'];
    employeeStatusName = json['EmployeeStatusName'];
    emailPayslipCode = json['EmailPayslipCode'];
    emailPayslipDisplay = json['EmailPayslipDisplay'];
    address1 = json['Address1'];
    address2 = json['Address2'];
    city = json['City'];
    inviteToPortal = json['InviteToPortal'];
    privacyNoticeChecked = json['PrivacyNoticeChecked'];
    fullName = json['FullName'];
    fullAddress = json['FullAddress'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    knownAs = json['KnownAs'];
    dateofBirth = json['DateofBirth'];
    genderContentListId = json['GenderContentListId'];
    genderContentList = json['GenderContentList'];
    titleContentListId = json['TitleContentListId'];
    titleContentList = json['TitleContentList'];
    email = json['Email'];
    irdNumber = json['IrdNumber'];
    isAgentEmployee = json['IsAgentEmployee'];
    homePhone = json['HomePhone'];
    workPhone = json['WorkPhone'];
    mobilePhone = json['MobilePhone'];
    occupation = json['Occupation'];
    taxCodeContentListId = json['TaxCodeContentListId'];
    taxCodeContentList = json['TaxCodeContentList'];
    kiwiSaverContentListId = json['KiwiSaverContentListId'];
    kiwiSaverContentList = json['KiwiSaverContentList'];
    leaveEntitlementContentListId = json['LeaveEntitlementContentListId'];
    leaveEntitlementContentList = json['LeaveEntitlementContentList'];
    startDate = json['StartDate'];
    hasKiwiSaver = json['HasKiwiSaver'];
    childSupportAmount = json['ChildSupportAmount'];
    bankSuffix = json['BankSuffix'];
    bankCompany = json['BankCompany'];
    bankAccountNumber = json['BankAccountNumber'];
    bankBranch = json['BankBranch'];
    fullBankAccountNumber = json['FullBankAccountNumber'];
    standardPayRate = json['StandardPayRate'];
    nightPayRate = json['NightPayRate'];
    weekendPayRate = json['WeekendPayRate'];
    if (json['Documents'] != null) {
      documents = <DocumentsModel>[];
      json['Documents'].forEach((v) {
        documents!.add(DocumentsModel.fromJson(v));
      });
    }
    if (json['DocumentType'] != null) {
      documentType = <DocumentTypeModel>[];
      json['DocumentType'].forEach((v) {
        documentType!.add(DocumentTypeModel.fromJson(v));
      });
    }
    if (json['PaySlip'] != null) {
      paySlip = <PaySlipModel>[];
      json['PaySlip'].forEach((v) {
        paySlip!.add(PaySlipModel.fromJson(v));
      });
    }
    effectiveDate = json['EffectiveDate'];
    isSelfManaged = json['IsSelfManaged'];
    withholdingTaxRate = json['WithholdingTaxRate'];
    gstRegistered = json['GstRegistered'];
    payGroup = json['PayGroup'];
    datapayCompany = json['DatapayCompany'];
    terminationDate = json['TerminationDate'];
    terminationReasonContentListId = json['TerminationReasonContentListId'];
    terminationReasonDisplay = json['TerminationReasonDisplay'];
    terminationComments = json['TerminationComments'];
    terminationContinuePayUntilDate = json['TerminationContinuePayUntilDate'];
    terminationPayOutHoliday = json['TerminationPayOutHoliday'];
    terminationPayOutLieu = json['TerminationPayOutLieu'];
    terminationPayOutAnnual = json['TerminationPayOutAnnual'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EmployeeId'] = employeeId;
    data['EmployerId'] = employerId;
    data['EmployeeCode'] = employeeCode;
    data['UserId'] = userId;
    data['ThirdPartyProviderId'] = thirdPartyProviderId;
    data['EmploymentStatusContentListId'] = employmentStatusContentListId;
    data['EmploymentStatusContentList'] = employmentStatusContentList;
    data['RegionContentListId'] = regionContentListId;
    data['RegionContentList'] = regionContentList;
    data['EmployeeTypeCode'] = employeeTypeCode;
    data['EmployeeTypeDisplay'] = employeeTypeDisplay;
    data['IsAgent'] = isAgent;
    data['SupportingDisplay'] = supportingDisplay;
    data['EmployeeStatusCode'] = employeeStatusCode;
    data['EmployeeStatusName'] = employeeStatusName;
    data['EmailPayslipCode'] = emailPayslipCode;
    data['EmailPayslipDisplay'] = emailPayslipDisplay;
    data['Address1'] = address1;
    data['Address2'] = address2;
    data['City'] = city;
    data['InviteToPortal'] = inviteToPortal;
    data['PrivacyNoticeChecked'] = privacyNoticeChecked;
    data['FullName'] = fullName;
    data['FullAddress'] = fullAddress;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['KnownAs'] = knownAs;
    data['DateofBirth'] = dateofBirth;
    data['GenderContentListId'] = genderContentListId;
    data['GenderContentList'] = genderContentList;
    data['TitleContentListId'] = titleContentListId;
    data['TitleContentList'] = titleContentList;
    data['Email'] = email;
    data['IrdNumber'] = irdNumber;
    data['IsAgentEmployee'] = isAgentEmployee;
    data['HomePhone'] = homePhone;
    data['WorkPhone'] = workPhone;
    data['MobilePhone'] = mobilePhone;
    data['Occupation'] = occupation;
    data['TaxCodeContentListId'] = taxCodeContentListId;
    data['TaxCodeContentList'] = taxCodeContentList;
    data['KiwiSaverContentListId'] = kiwiSaverContentListId;
    data['KiwiSaverContentList'] = kiwiSaverContentList;
    data['LeaveEntitlementContentListId'] = leaveEntitlementContentListId;
    data['LeaveEntitlementContentList'] = leaveEntitlementContentList;
    data['StartDate'] = startDate;
    data['HasKiwiSaver'] = hasKiwiSaver;
    data['ChildSupportAmount'] = childSupportAmount;
    data['BankSuffix'] = bankSuffix;
    data['BankCompany'] = bankCompany;
    data['BankAccountNumber'] = bankAccountNumber;
    data['BankBranch'] = bankBranch;
    data['FullBankAccountNumber'] = fullBankAccountNumber;
    data['StandardPayRate'] = standardPayRate;
    data['NightPayRate'] = nightPayRate;
    data['WeekendPayRate'] = weekendPayRate;
    if (documents != null) {
      data['Documents'] = documents!.map((v) => v.toJson()).toList();
    }
    if (documentType != null) {
      data['DocumentType'] = documentType!.map((v) => v.toJson()).toList();
    }
    if (paySlip != null) {
      data['PaySlip'] = paySlip!.map((v) => v.toJson()).toList();
    }
    data['EffectiveDate'] = effectiveDate;
    data['IsSelfManaged'] = isSelfManaged;
    data['WithholdingTaxRate'] = withholdingTaxRate;
    data['GstRegistered'] = gstRegistered;
    data['PayGroup'] = payGroup;
    data['DatapayCompany'] = datapayCompany;
    data['TerminationDate'] = terminationDate;
    data['TerminationReasonContentListId'] = terminationReasonContentListId;
    data['TerminationReasonDisplay'] = terminationReasonDisplay;
    data['TerminationComments'] = terminationComments;
    data['TerminationContinuePayUntilDate'] = terminationContinuePayUntilDate;
    data['TerminationPayOutHoliday'] = terminationPayOutHoliday;
    data['TerminationPayOutLieu'] = terminationPayOutLieu;
    data['TerminationPayOutAnnual'] = terminationPayOutAnnual;
    return data;
  }
}

class DocumentsModel {
  int? employeeDocumentId;
  String? documentName;
  String? documentType;
  String? documentTitle;
  String? documentData;
  int? employeeDocumentTypeId;
  String? employeeDocumentTypeName;
  String? employeeName;
  String? employerId;
  bool? isPicked = false;
  XFile? selectedFile;

  DocumentsModel(
      {this.employeeDocumentId,
      this.documentName,
      this.documentType,
      this.documentTitle,
      this.documentData,
      this.employeeDocumentTypeId,
      this.employeeDocumentTypeName,
      this.employeeName,
      this.employerId,
      this.isPicked,
      this.selectedFile});

  DocumentsModel.fromJson(Map<String, dynamic> json) {
    employeeDocumentId = json['EmployeeDocumentId'];
    documentName = json['DocumentName'];
    documentType = json['DocumentType'];
    documentTitle = json['DocumentTitle'];
    documentData = json['DocumentData'];
    employeeDocumentTypeId = json['EmployeeDocumentTypeId'];
    employeeDocumentTypeName = json['EmployeeDocumentTypeName'];
    employeeName = json['EmployeeName'];
    employerId = json['EmployerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EmployeeDocumentId'] = employeeDocumentId;
    data['DocumentName'] = documentName;
    data['DocumentType'] = documentType;
    data['DocumentTitle'] = documentTitle;
    data['DocumentData'] = documentData;
    data['EmployeeDocumentTypeId'] = employeeDocumentTypeId;
    data['EmployeeDocumentTypeName'] = employeeDocumentTypeName;
    data['EmployeeName'] = employeeName;
    data['EmployerId'] = employerId;
    return data;
  }
}

class DocumentTypeModel {
  int? employeeDocumentTypeId;
  String? name;
  String? urlLink;
  String? employeeTypeCode;
  String? employeeTypeDisplay;
  int? listOrder;
  bool? mandatory;
  bool? expired;
  String? helpText;

  DocumentTypeModel({this.employeeDocumentTypeId,
    this.name,
    this.urlLink,
    this.employeeTypeCode,
    this.employeeTypeDisplay,
    this.listOrder,
    this.mandatory,
    this.expired,
    this.helpText});

  DocumentTypeModel.fromJson(Map<String, dynamic> json) {
    employeeDocumentTypeId = json['EmployeeDocumentTypeId'];
    name = json['Name'];
    urlLink = json['UrlLink'];
    employeeTypeCode = json['EmployeeTypeCode'];
    employeeTypeDisplay = json['EmployeeTypeDisplay'];
    listOrder = json['ListOrder'];
    mandatory = json['Mandatory'];
    expired = json['Expired'];
    helpText = json['HelpText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EmployeeDocumentTypeId'] = employeeDocumentTypeId;
    data['Name'] = name;
    data['UrlLink'] = urlLink;
    data['EmployeeTypeCode'] = employeeTypeCode;
    data['EmployeeTypeDisplay'] = employeeTypeDisplay;
    data['ListOrder'] = listOrder;
    data['Mandatory'] = mandatory;
    data['Expired'] = expired;
    data['HelpText'] = helpText;
    return data;
  }
}

class PaySlipModel {
  int? payslipId;
  int? payRunId;
  int? employeeId;
  String? periodEndDate;
  double? directCredit;
  String? payload;
  String? employerId;
  String? employerDisplay;

  PaySlipModel({this.payslipId,
    this.payRunId,
    this.employeeId,
    this.periodEndDate,
    this.directCredit,
    this.payload,
    this.employerId,
    this.employerDisplay});

  PaySlipModel.fromJson(Map<String, dynamic> json) {
    payslipId = json['PayslipId'];
    payRunId = json['PayRunId'];
    employeeId = json['EmployeeId'];
    periodEndDate = json['PeriodEndDate'];
    directCredit = json['DirectCredit'];
    payload = json['Payload'];
    employerId = json['EmployerId'];
    employerDisplay = json['EmployerDisplay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PayslipId'] = payslipId;
    data['PayRunId'] = payRunId;
    data['EmployeeId'] = employeeId;
    data['PeriodEndDate'] = periodEndDate;
    data['DirectCredit'] = directCredit;
    data['Payload'] = payload;
    data['EmployerId'] = employerId;
    data['EmployerDisplay'] = employerDisplay;
    return data;
  }
}
