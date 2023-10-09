class ReportGroupDataModel {
  String? serviceName;
  int? monthAdditive;
  double? actCharge;
  int? reportGroup;
  int? currentMonthAccrual;
  int? accrualMovement;
  int? monthAdditiveGroup2;
  double? accrualMovementGroup2;
  int? isAccrual;

  ReportGroupDataModel(
      {this.serviceName,
      this.monthAdditive,
      this.actCharge,
      this.reportGroup,
      this.currentMonthAccrual,
      this.accrualMovement,
      this.monthAdditiveGroup2,
      this.accrualMovementGroup2,
      this.isAccrual});

  ReportGroupDataModel.fromJson(Map<String, dynamic> json) {
    serviceName = json['ServiceName'];
    monthAdditive = json['MonthAdditive'];
    actCharge = json['ActCharge'];
    reportGroup = json['ReportGroup'];
    currentMonthAccrual = json['CurrentMonthAccrual'];
    accrualMovement = json['AccrualMovement'];
    monthAdditiveGroup2 = json['MonthAdditiveGroup2'];
    accrualMovementGroup2 = json['AccrualMovementGroup2'];
    isAccrual = json['IsAccrual'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ServiceName'] = serviceName;
    data['MonthAdditive'] = monthAdditive;
    data['ActCharge'] = actCharge;
    data['ReportGroup'] = reportGroup;
    data['CurrentMonthAccrual'] = currentMonthAccrual;
    data['AccrualMovement'] = accrualMovement;
    data['MonthAdditiveGroup2'] = monthAdditiveGroup2;
    data['AccrualMovementGroup2'] = accrualMovementGroup2;
    data['IsAccrual'] = isAccrual;
    return data;
  }
}
