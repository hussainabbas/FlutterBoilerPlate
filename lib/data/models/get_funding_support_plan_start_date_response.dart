import 'package:manawanui/data/models/funder_start_date_model.dart';

class GetFundingSupportPlanStartDateResponse {
  bool? status;
  String? message;
  List<FunderStartDateModel>? response;

  GetFundingSupportPlanStartDateResponse(
      {this.status, this.message, this.response});

  GetFundingSupportPlanStartDateResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    if (json['Response'] != null) {
      response = <FunderStartDateModel>[];
      json['Response'].forEach((v) {
        response!.add(FunderStartDateModel.fromJson(v));
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
