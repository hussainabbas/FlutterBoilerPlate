class GetNZAddressResponse {
  bool? success;
  List<Addresses>? addresses;

  GetNZAddressResponse({this.success, this.addresses});

  GetNZAddressResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(Addresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresses {
  int? dPID;
  String? sourceDesc;
  String? fullAddress;

  Addresses({this.dPID, this.sourceDesc, this.fullAddress});

  Addresses.fromJson(Map<String, dynamic> json) {
    dPID = json['DPID'];
    sourceDesc = json['SourceDesc'];
    fullAddress = json['FullAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DPID'] = dPID;
    data['SourceDesc'] = sourceDesc;
    data['FullAddress'] = fullAddress;
    return data;
  }
}
