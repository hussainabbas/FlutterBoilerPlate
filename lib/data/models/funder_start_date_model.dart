class FunderStartDateModel {
  String? id;
  String? name;

  FunderStartDateModel({this.id, this.name});

  FunderStartDateModel.fromJson(Map<String, dynamic> json) {
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
