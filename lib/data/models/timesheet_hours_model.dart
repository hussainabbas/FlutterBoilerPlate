import 'package:manawanui/data/models/get_update_timesheet_response.dart';

class TimesheetTimeModel {
  String? personSupported;
  String? payComponent;
  List<TimesheetHoursModel>? timesheetHoursModel;
  List<PublicHolidayModel>? publicHoliday;

  TimesheetTimeModel(
      {this.personSupported,
      this.payComponent,
      this.timesheetHoursModel,
      this.publicHoliday});
}

class TimesheetHoursModel {
  String? date;
  double? hours;

  TimesheetHoursModel({this.date, this.hours});
}
