import 'package:intl/intl.dart';

extension StringX on String {
  String convertStringDateToMMMDDYYY() {
    final parsedDate = DateTime.parse(this);
    final dateFormatter = DateFormat('MMM dd, yyyy', 'en_US');
    final formattedDate = dateFormatter.format(parsedDate);
    return formattedDate;
  }

  String convertStringDDMMYYYYToMMMDDYYY() {
    final inputFormat = DateFormat('dd/MM/yyyy');
    final parsedDate = inputFormat.parse(this);
    final outputFormat = DateFormat('MMM dd, yyyy', 'en_US');
    final formattedDate = outputFormat.format(parsedDate);
    return formattedDate;
  }

  String formatAmountNumber() {
    final number = double.tryParse(this);
    if (number != null) {
      final formatter = NumberFormat("#,##0.00", "en_US");
      return formatter.format(number);
    } else {
      return this;
    }
  }
}
