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

class ExpenseItemModel {
  String? personSupported;
  String? date;
  String? amount;
  String? expenseOrPayee;
  String? expenseType;
  String? hour;
  String? particulars;
  String? invoiceImage;

  ExpenseItemModel({
    this.personSupported,
    this.date,
    this.amount,
    this.expenseType,
    this.hour,
    this.particulars,
    this.invoiceImage,
  });
}

class PaymentsItemModel {
  String? personSupported;
  String? date;
  String? amount;
  String? providerName;
  String? customerNo;
  String? invoiceNo;
  String? invoiceImage;

  PaymentsItemModel({
    this.personSupported,
    this.date,
    this.amount,
    this.providerName,
    this.customerNo,
    this.invoiceNo,
    this.invoiceImage,
  });
}
