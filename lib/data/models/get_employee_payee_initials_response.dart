class GetEmployeePayeeInitialsResponse {
  bool? status;
  String? message;
  EmployeePayeeModel? response;

  GetEmployeePayeeInitialsResponse({this.status, this.message, this.response});

  GetEmployeePayeeInitialsResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    response = json['Response'] != null
        ? EmployeePayeeModel.fromJson(json['Response'])
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

class EmployeePayeeModel {
  List<GenericIdValueModel>? region;
  List<GenericIdValueModel>? title;
  List<GenericIdValueModel>? gender;
  List<GenericIdValueModel>? status;
  List<GenericIdValueModel>? taxCode;
  List<GenericIdValueModel>? kiwisaverOption;
  List<GenericIdValueModel>? leaveEntitlement;
  List<GenericIdValueModel>? emailPayslipType;
  List<GenericIdValueModel>? thirdPartyPaymentProviders;
  List<EffectiveDatesddlModel>? effectiveDatesddl;
  bool? employerCanEmail;

  EmployeePayeeModel(
      {this.region,
      this.title,
      this.gender,
      this.status,
      this.taxCode,
      this.kiwisaverOption,
      this.leaveEntitlement,
      this.emailPayslipType,
      this.thirdPartyPaymentProviders,
      this.effectiveDatesddl,
      this.employerCanEmail});

  EmployeePayeeModel.fromJson(Map<String, dynamic> json) {
    if (json['Region'] != null) {
      region = <GenericIdValueModel>[];
      json['Region'].forEach((v) {
        region!.add(GenericIdValueModel.fromJson(v));
      });
    }
    if (json['Title'] != null) {
      title = <GenericIdValueModel>[];
      json['Title'].forEach((v) {
        title!.add(GenericIdValueModel.fromJson(v));
      });
    }
    if (json['Gender'] != null) {
      gender = <GenericIdValueModel>[];
      json['Gender'].forEach((v) {
        gender!.add(GenericIdValueModel.fromJson(v));
      });
    }
    if (json['Status'] != null) {
      status = <GenericIdValueModel>[];
      json['Status'].forEach((v) {
        status!.add(GenericIdValueModel.fromJson(v));
      });
    }
    if (json['TaxCode'] != null) {
      taxCode = <GenericIdValueModel>[];
      json['TaxCode'].forEach((v) {
        taxCode!.add(GenericIdValueModel.fromJson(v));
      });
    }
    if (json['KiwisaverOption'] != null) {
      kiwisaverOption = <GenericIdValueModel>[];
      json['KiwisaverOption'].forEach((v) {
        kiwisaverOption!.add(GenericIdValueModel.fromJson(v));
      });
    }
    if (json['LeaveEntitlement'] != null) {
      leaveEntitlement = <GenericIdValueModel>[];
      json['LeaveEntitlement'].forEach((v) {
        leaveEntitlement!.add(GenericIdValueModel.fromJson(v));
      });
    }
    if (json['EmailPayslipType'] != null) {
      emailPayslipType = <GenericIdValueModel>[];
      json['EmailPayslipType'].forEach((v) {
        emailPayslipType!.add(GenericIdValueModel.fromJson(v));
      });
    }
    if (json['EffectiveDatesddl'] != null) {
      effectiveDatesddl = <EffectiveDatesddlModel>[];
      json['EffectiveDatesddl'].forEach((v) {
        effectiveDatesddl!.add(EffectiveDatesddlModel.fromJson(v));
      });
    }
    if (json['ThirdPartyPaymentProviders'] != null) {
      thirdPartyPaymentProviders = <GenericIdValueModel>[];
      json['ThirdPartyPaymentProviders'].forEach((v) {
        thirdPartyPaymentProviders!.add(GenericIdValueModel.fromJson(v));
      });
    }
    employerCanEmail = json['EmployerCanEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (region != null) {
      data['Region'] = region!.map((v) => v.toJson()).toList();
    }
    if (title != null) {
      data['Title'] = title!.map((v) => v.toJson()).toList();
    }
    if (gender != null) {
      data['Gender'] = gender!.map((v) => v.toJson()).toList();
    }
    if (status != null) {
      data['Status'] = status!.map((v) => v.toJson()).toList();
    }
    if (taxCode != null) {
      data['TaxCode'] = taxCode!.map((v) => v.toJson()).toList();
    }
    if (kiwisaverOption != null) {
      data['KiwisaverOption'] =
          kiwisaverOption!.map((v) => v.toJson()).toList();
    }
    if (leaveEntitlement != null) {
      data['LeaveEntitlement'] =
          leaveEntitlement!.map((v) => v.toJson()).toList();
    }
    if (emailPayslipType != null) {
      data['EmailPayslipType'] =
          emailPayslipType!.map((v) => v.toJson()).toList();
    }

    if (thirdPartyPaymentProviders != null) {
      data['ThirdPartyPaymentProviders'] =
          thirdPartyPaymentProviders!.map((v) => v.toJson()).toList();
    }
    if (effectiveDatesddl != null) {
      data['EffectiveDatesddl'] =
          effectiveDatesddl!.map((v) => v.toJson()).toList();
    }
    data['EmployerCanEmail'] = employerCanEmail;
    return data;
  }
}

class GenericIdValueModel {
  String? id;
  String? name;

  GenericIdValueModel({this.id, this.name});

  GenericIdValueModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    return data;
  }
}

class EffectiveDatesddlModel {
  String? value;
  String? name;

  EffectiveDatesddlModel({this.value, this.name});

  EffectiveDatesddlModel.fromJson(Map<String, dynamic> json) {
    value = json['Value'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Value'] = value;
    data['Name'] = name;
    return data;
  }
}
