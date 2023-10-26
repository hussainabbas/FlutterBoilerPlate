import 'package:image_picker/image_picker.dart';

class GetEmployeeDocumentsResponse {
  bool? status;
  String? message;
  Response? response;

  GetEmployeeDocumentsResponse({this.status, this.message, this.response});

  GetEmployeeDocumentsResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    response =
        json['Response'] != null ? Response.fromJson(json['Response']) : null;
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

class Response {
  List<EmployeeDocumentsItem>? documents;

  Response({this.documents});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['Documents'] != null) {
      documents = <EmployeeDocumentsItem>[];
      json['Documents'].forEach((v) {
        documents!.add(EmployeeDocumentsItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (documents != null) {
      data['Documents'] = documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmployeeDocumentsItem {
  int? employeeDocumentTypeId;
  String? name;
  String? urlLink;
  String? employeeTypeCode;
  String? employeTypeDisplay;
  int? listOrder;
  bool? mandatory;
  bool? expired;
  String? helpText;
  bool? isPicked = false;

  XFile? selectedFile;
  String? selectedFileBase64;
  int? employeeDocumentId;
  String? documentName;
  String? documentType;
  String? documentTitle;
  String? documentData;
  String? employeeDocumentTypeName;
  String? employeeName;
  String? employerId;

  EmployeeDocumentsItem({
    this.employeeDocumentTypeId,
    this.name,
    this.urlLink,
    this.employeeTypeCode,
    this.employeTypeDisplay,
    this.listOrder,
    this.mandatory,
    this.expired,
    this.helpText,
    this.isPicked,
    this.employeeDocumentId,
    this.documentName,
    this.documentType,
    this.documentTitle,
    this.documentData,
    this.employeeDocumentTypeName,
    this.employeeName,
    this.employerId,
  });

  EmployeeDocumentsItem.fromJson(Map<String, dynamic> json) {
    employeeDocumentTypeId = json['EmployeeDocumentTypeId'];
    name = json['Name'];
    urlLink = json['UrlLink'];
    employeeTypeCode = json['EmployeeTypeCode'];
    employeTypeDisplay = json['EmployeTypeDisplay'];
    listOrder = json['ListOrder'];
    mandatory = json['Mandatory'];
    expired = json['Expired'];
    helpText = json['HelpText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EmployeeDocumentTypeId'] = employeeDocumentTypeId;
    data['Name'] = name;
    data['UrlLink'] = urlLink;
    data['EmployeeTypeCode'] = employeeTypeCode;
    data['EmployeTypeDisplay'] = employeTypeDisplay;
    data['ListOrder'] = listOrder;
    data['Mandatory'] = mandatory;
    data['Expired'] = expired;
    data['HelpText'] = helpText;
    return data;
  }
}
