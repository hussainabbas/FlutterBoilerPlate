class ReportItemsModel {
  String? actDateStart;
  String? description;
  double? actCharge;
  double? balance;

  ReportItemsModel(
      {this.actDateStart, this.description, this.actCharge, this.balance});

  ReportItemsModel.fromJson(Map<String, dynamic> json) {
    actDateStart = json['ActDateStart'];
    description = json['Description'];
    actCharge = json['ActCharge'];
    balance = json['Balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ActDateStart'] = actDateStart;
    data['Description'] = description;
    data['ActCharge'] = actCharge;
    data['Balance'] = balance;
    return data;
  }
}
