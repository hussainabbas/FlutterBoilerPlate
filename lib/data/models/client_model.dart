class ClientModel {
  String? id;
  String? name;

  ClientModel({this.id, this.name});

  ClientModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    return data;
  }
}
