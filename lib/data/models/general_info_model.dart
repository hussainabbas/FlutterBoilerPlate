class GeneralInfoModel {
  String? accTotal;
  String? accountNumber;
  String? addressComposite;
  String? agentAddressComposite;
  String? agentEmail;
  String? agentMobile;
  String? agentName;
  String? allocation;
  String? averageAllocation;
  String? averageNeeded;
  String? averageSpending;
  String? balanceOwing;
  String? calculatedFullySpentDate;
  String? currentAverage;
  String? email;
  String? expenditure;
  String? fundingEndDate;
  String? fundingName;
  String? fundingStartDate;
  String? holidayAccrualTotal;
  String? homePhone;
  String? micTotal;
  String? mobilePhone;
  String? nhiNumber;
  String? name;
  String? fortsNoFunding;
  String? overspendAmount;
  String? pastHolidayAccrualsTotal;
  String? paymentsTotal;
  String? region;
  String? reimbursementTotal;
  String? remainingAverage;
  String? remainingFunding;
  String? remainingWeeks;
  String? statementFrequency;
  String? statementDate;
  String? totalHolidayAccruals;
  String? transactionTotal;

  GeneralInfoModel(
      {this.accTotal,
      this.accountNumber,
      this.addressComposite,
      this.agentAddressComposite,
      this.agentEmail,
      this.agentMobile,
      this.agentName,
      this.allocation,
      this.averageAllocation,
      this.averageNeeded,
      this.averageSpending,
      this.balanceOwing,
      this.calculatedFullySpentDate,
      this.currentAverage,
      this.email,
      this.expenditure,
      this.fundingEndDate,
      this.fundingName,
      this.fundingStartDate,
      this.holidayAccrualTotal,
      this.homePhone,
      this.micTotal,
      this.mobilePhone,
      this.nhiNumber,
      this.name,
      this.fortsNoFunding,
      this.overspendAmount,
      this.pastHolidayAccrualsTotal,
      this.paymentsTotal,
      this.region,
      this.reimbursementTotal,
      this.remainingAverage,
      this.remainingFunding,
      this.remainingWeeks,
      this.statementFrequency,
      this.statementDate,
      this.totalHolidayAccruals,
      this.transactionTotal});

  GeneralInfoModel.fromJson(Map<String, dynamic> json) {
    accTotal = json['accTotal'];
    accountNumber = json['accountNumber'];
    addressComposite = json['addressComposite'];
    agentAddressComposite = json['agentAddressComposite'];
    agentEmail = json['agentEmail'];
    agentMobile = json['agentMobile'];
    agentName = json['agentName'];
    allocation = json['allocation'];
    averageAllocation = json['averageAllocation'];
    averageNeeded = json['averageNeeded'];
    averageSpending = json['averageSpending'];
    balanceOwing = json['balanceOwing'];
    calculatedFullySpentDate = json['calculatedFullySpentDate'];
    currentAverage = json['currentAverage'];
    email = json['email'];
    expenditure = json['expenditure'];
    fundingEndDate = json['fundingEndDate'];
    fundingName = json['fundingName'];
    fundingStartDate = json['fundingStartDate'];
    holidayAccrualTotal = json['holidayAccrualTotal'];
    homePhone = json['homePhone'];
    micTotal = json['micTotal'];
    mobilePhone = json['mobilePhone'];
    nhiNumber = json['nhiNumber'];
    name = json['name'];
    fortsNoFunding = json['fortsNoFunding'];
    overspendAmount = json['overspendAmount'];
    pastHolidayAccrualsTotal = json['pastHolidayAccrualsTotal'];
    paymentsTotal = json['paymentsTotal'];
    region = json['region'];
    reimbursementTotal = json['reimbursementTotal'];
    remainingAverage = json['remainingAverage'];
    remainingFunding = json['remainingFunding'];
    remainingWeeks = json['remainingWeeks'];
    statementFrequency = json['statementFrequency'];
    statementDate = json['statementDate'];
    totalHolidayAccruals = json['totalHolidayAccruals'];
    transactionTotal = json['transactionTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accTotal'] = this.accTotal;
    data['accountNumber'] = this.accountNumber;
    data['addressComposite'] = this.addressComposite;
    data['agentAddressComposite'] = this.agentAddressComposite;
    data['agentEmail'] = this.agentEmail;
    data['agentMobile'] = this.agentMobile;
    data['agentName'] = this.agentName;
    data['allocation'] = this.allocation;
    data['averageAllocation'] = this.averageAllocation;
    data['averageNeeded'] = this.averageNeeded;
    data['averageSpending'] = this.averageSpending;
    data['balanceOwing'] = this.balanceOwing;
    data['calculatedFullySpentDate'] = this.calculatedFullySpentDate;
    data['currentAverage'] = this.currentAverage;
    data['email'] = this.email;
    data['expenditure'] = this.expenditure;
    data['fundingEndDate'] = this.fundingEndDate;
    data['fundingName'] = this.fundingName;
    data['fundingStartDate'] = this.fundingStartDate;
    data['holidayAccrualTotal'] = this.holidayAccrualTotal;
    data['homePhone'] = this.homePhone;
    data['micTotal'] = this.micTotal;
    data['mobilePhone'] = this.mobilePhone;
    data['nhiNumber'] = this.nhiNumber;
    data['name'] = this.name;
    data['fortsNoFunding'] = this.fortsNoFunding;
    data['overspendAmount'] = this.overspendAmount;
    data['pastHolidayAccrualsTotal'] = this.pastHolidayAccrualsTotal;
    data['paymentsTotal'] = this.paymentsTotal;
    data['region'] = this.region;
    data['reimbursementTotal'] = this.reimbursementTotal;
    data['remainingAverage'] = this.remainingAverage;
    data['remainingFunding'] = this.remainingFunding;
    data['remainingWeeks'] = this.remainingWeeks;
    data['statementFrequency'] = this.statementFrequency;
    data['statementDate'] = this.statementDate;
    data['totalHolidayAccruals'] = this.totalHolidayAccruals;
    data['transactionTotal'] = this.transactionTotal;
    return data;
  }
}
