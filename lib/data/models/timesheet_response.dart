class TimesheetResponse {
  final String date;
  final String name;
  final double hrs;
  final String cost;
  final String status;

  TimesheetResponse({
    required this.date,
    required this.name,
    required this.hrs,
    required this.cost,
    required this.status,
  });
}
