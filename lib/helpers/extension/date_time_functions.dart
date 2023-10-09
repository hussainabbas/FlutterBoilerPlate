import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String convertDateToYYYYMMDDTHHMMSS() {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(this);
  }
}
