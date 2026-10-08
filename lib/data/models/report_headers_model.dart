import 'package:manawanui/data/models/report_group_data_model.dart';

class ReportHeadersModel {
  String? reportGroup;
  List<ReportGroupDataModel>? reportGroupData;
  double? totalSpend;
  int? totalSpendforthisMonth;

  ReportHeadersModel(
      {this.reportGroup,
      this.reportGroupData,
      this.totalSpend,
      this.totalSpendforthisMonth});

  ReportHeadersModel.fromJson(Map<String, dynamic> json) {
    reportGroup = json['ReportGroup'];
    if (json['ReportGroupData'] != null) {
      reportGroupData = <ReportGroupDataModel>[];
      json['ReportGroupData'].forEach((v) {
        reportGroupData!.add(ReportGroupDataModel.fromJson(v));
      });
    }
    totalSpend = json['TotalSpend'];
    totalSpendforthisMonth = json['TotalSpendforthisMonth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ReportGroup'] = reportGroup;
    if (reportGroupData != null) {
      data['ReportGroupData'] =
          reportGroupData!.map((v) => v.toJson()).toList();
    }
    data['TotalSpend'] = totalSpend;
    data['TotalSpendforthisMonth'] = totalSpendforthisMonth;
    return data;
  }
}
