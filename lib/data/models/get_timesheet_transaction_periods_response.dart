class GetTimesheetTransactionPeriodResponse {
  bool? status;
  String? message;

  ResponseTransactionPeriodModal? response;

  GetTimesheetTransactionPeriodResponse(
      {this.status, this.message, this.response});

  GetTimesheetTransactionPeriodResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];

    response = json['Response'] != null
        ? ResponseTransactionPeriodModal.fromJson(json['Response'])
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

class ResponseTransactionPeriodModal {
  List<TransPeriodModal>? transPeriod;

  bool? showTimesheetBlock;
  bool? showPaymentBlock;

  ResponseTransactionPeriodModal(
      {this.transPeriod, this.showTimesheetBlock, this.showPaymentBlock});

  ResponseTransactionPeriodModal.fromJson(Map<String, dynamic> json) {
    if (json['TransPeriod'] != null) {
      transPeriod = <TransPeriodModal>[];
      json['TransPeriod'].forEach((v) {
        transPeriod!.add(TransPeriodModal.fromJson(v));
      });
    }

    showPaymentBlock = json['ShowPaymentBlock'];
    showTimesheetBlock = json['ShowTimesheetBlock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (transPeriod != null) {
      data['TransPeriod'] = transPeriod!.map((v) => v.toJson()).toList();
    }
    data['ShowTimesheetBlock'] = showTimesheetBlock;
    data['ShowPaymentBlock'] = showPaymentBlock;
    return data;
  }
}

class TransPeriodModal {
  String? id;
  String? name;
  int? intId;
  Null? subGroup;
  bool? selected;
  Null? auxDate;
  Null? transcationstartDate;
  Null? transcationEndDate;
  bool? hasChosenMondayised;
  bool? hasMondayised;
  List<String>? nzacDates;
  String? message;
  int? publicHoliday;
  Null? holidayName;
  bool? isAgent;

  TransPeriodModal(
      {this.id,
      this.name,
      this.intId,
      this.subGroup,
      this.selected,
      this.auxDate,
      this.transcationstartDate,
      this.transcationEndDate,
      this.hasChosenMondayised,
      this.hasMondayised,
      this.nzacDates,
      this.message,
      this.publicHoliday,
      this.holidayName,
      this.isAgent});

  TransPeriodModal.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    intId = json['intId'];
    subGroup = json['SubGroup'];
    selected = json['Selected'];
    auxDate = json['AuxDate'];
    transcationstartDate = json['TranscationstartDate'];
    transcationEndDate = json['TranscationEndDate'];
    hasChosenMondayised = json['hasChosenMondayised'];
    hasMondayised = json['hasMondayised'];
    if (json['nzacDates'] != null) {
      nzacDates = json['nzacDates'].cast<String>();
    }

    message = json['message'];
    publicHoliday = json['publicHoliday'];
    holidayName = json['holidayName'];
    isAgent = json['isAgent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['intId'] = intId;
    data['SubGroup'] = subGroup;
    data['Selected'] = selected;
    data['AuxDate'] = auxDate;
    data['TranscationstartDate'] = transcationstartDate;
    data['TranscationEndDate'] = transcationEndDate;
    data['hasChosenMondayised'] = hasChosenMondayised;
    data['hasMondayised'] = hasMondayised;
    data['nzacDates'] = nzacDates;
    data['message'] = message;
    data['publicHoliday'] = publicHoliday;
    data['holidayName'] = holidayName;
    data['isAgent'] = isAgent;
    return data;
  }
}
