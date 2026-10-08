import 'package:manawanui/data/models/get_employee_payee_initials_response.dart';

class GetEmployerClientListResponse {
  bool? status;
  String? message;
  List<GenericIdValueModel>? response;

  GetEmployerClientListResponse({this.status, this.message, this.response});

  GetEmployerClientListResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    if (json['Response'] != null) {
      response = <GenericIdValueModel>[];
      json['Response'].forEach((v) {
        response!.add(GenericIdValueModel.fromJson(v));
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
