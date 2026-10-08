import 'package:manawanui/data/models/statement_model.dart';

class GetStatementNewResponse {
  bool? status;
  String? message;
  StatementResponseModel? response;

  GetStatementNewResponse({this.status, this.message, this.response});

  GetStatementNewResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    response = json['Response'] != null
        ? StatementResponseModel.fromJson(json['Response'])
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
