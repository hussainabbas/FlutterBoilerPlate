import 'package:manawanui/data/models/funder_model.dart';

class GetCategorySupportPlanResponse {
  bool? status;
  String? message;
  List<FunderModel>? response;

  GetCategorySupportPlanResponse({this.status, this.message, this.response});

  GetCategorySupportPlanResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    if (json['Response'] != null) {
      response = <FunderModel>[];
      json['Response'].forEach((v) {
        response!.add(FunderModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Message'] = message;
    if (response != null) {
      data['Response'] = response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
