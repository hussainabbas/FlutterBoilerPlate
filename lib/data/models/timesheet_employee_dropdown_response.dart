class TimesheetEmployeeDropdownResponse {
  bool? status;
  String? message;
  EmployeeDropdownModal? response;

  TimesheetEmployeeDropdownResponse({this.status, this.message, this.response});

  TimesheetEmployeeDropdownResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    response = json['Response'] != null
        ? EmployeeDropdownModal.fromJson(json['Response'])
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

class EmployeeDropdownModal {
  List<EligibalEmployeesModal>? eligibalEmployees;

  EmployeeDropdownModal({this.eligibalEmployees});

  EmployeeDropdownModal.fromJson(Map<String, dynamic> json) {
    if (json['EligibalEmployees'] != null) {
      eligibalEmployees = <EligibalEmployeesModal>[];
      json['EligibalEmployees'].forEach((v) {
        eligibalEmployees!.add(EligibalEmployeesModal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (eligibalEmployees != null) {
      data['EligibalEmployees'] =
          eligibalEmployees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EligibalEmployeesModal {
  String? id;
  String? name;
  int? intId;
  String? subGroup;
  bool? selected;
  Null? auxDate;
  Null? transcationstartDate;
  Null? transcationEndDate;
  bool? hasChosenMondayised;
  bool? hasMondayised;
  Null? nzacDates;
  Null? message;
  int? publicHoliday;
  Null? holidayName;
  bool? isAgent;

  EligibalEmployeesModal(
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

  EligibalEmployeesModal.fromJson(Map<String, dynamic> json) {
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
    nzacDates = json['nzacDates'];
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
