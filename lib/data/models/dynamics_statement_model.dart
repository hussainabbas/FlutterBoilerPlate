import 'package:manawanui/data/models/general_info_model.dart';

class DynamicsStatementModel {
  GeneralInfoModel? generalInfo;
  String? reportItemList;

  DynamicsStatementModel({this.generalInfo, this.reportItemList});

  DynamicsStatementModel.fromJson(Map<String, dynamic> json) {
    generalInfo = json['GeneralInfo'] != null
        ? GeneralInfoModel.fromJson(json['GeneralInfo'])
        : null;
    reportItemList = json['ReportItemList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (generalInfo != null) {
      data['GeneralInfo'] = generalInfo!.toJson();
    }
    data['ReportItemList'] = reportItemList;
    return data;
  }
}
