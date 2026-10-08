class GetMailCountResponse {
  bool? status;
  String? message;
  MailCountModel? response;

  GetMailCountResponse({this.status, this.message, this.response});

  GetMailCountResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    response = json['Response'] != null
        ? MailCountModel.fromJson(json['Response'])
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

class MailCountModel {
  int? unreadCount;
  int? totalReceived;
  int? totalSpend;

  MailCountModel({this.unreadCount, this.totalReceived, this.totalSpend});

  MailCountModel.fromJson(Map<String, dynamic> json) {
    unreadCount = json['UnreadCount'];
    totalReceived = json['TotalReceived'];
    totalSpend = json['totalSpend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UnreadCount'] = unreadCount;
    data['TotalReceived'] = totalReceived;
    data['totalSpend'] = totalSpend;
    return data;
  }
}
