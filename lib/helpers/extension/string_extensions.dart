import 'package:intl/intl.dart';

extension StringX on String {
  String convertStringDateToMMMDDYYY() {
    final parsedDate = DateTime.parse(this);
    final dateFormatter = DateFormat('MMM dd, yyyy', 'en_US');
    final formattedDate = dateFormatter.format(parsedDate);
    return formattedDate;
  }

  String convertStringDateToMMM() {
    final parsedDate = DateTime.parse(this);
    final dateFormatter = DateFormat('MMM', 'en_US');
    final formattedDate = dateFormatter.format(parsedDate);
    return formattedDate;
  }

  String convertStringDateToDD() {
    final parsedDate = DateTime.parse(this);
    final dateFormatter = DateFormat('dd', 'en_US');
    final formattedDate = dateFormatter.format(parsedDate);
    return formattedDate;
  }

  String convertStringDateToYYYY() {
    final parsedDate = DateTime.parse(this);
    final dateFormatter = DateFormat('yyyy', 'en_US');
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

  String convertStringDDMMYYYYToE() {
    final inputFormat = DateFormat('dd MMM yyyy');
    final parsedDate = inputFormat.parse(this);
    final outputFormat = DateFormat('E', 'en_US');
    final formattedDate = outputFormat.format(parsedDate);
    return formattedDate;
  }

  String convertStringDDMMYYYYToMMMDD() {
    final inputFormat = DateFormat('dd MMM yyyy');
    final parsedDate = inputFormat.parse(this);
    final outputFormat = DateFormat('MMM dd', 'en_US');
    final formattedDate = outputFormat.format(parsedDate);
    return formattedDate;
  }

  String convertStringDDMMYYYDateToYYYY() {
    final inputFormat = DateFormat('dd MMM yyyy');
    final parsedDate = inputFormat.parse(this);
    final outputFormat = DateFormat('yyyy', 'en_US');
    final formattedDate = outputFormat.format(parsedDate);
    return formattedDate;
  }

  String convertStringDDMMYYYHHMMSSDateToEMMMDDYYYY() {
    final inputFormat = DateFormat("yyyy-MM-dd'T'hh:mm:ss");
    final parsedDate = inputFormat.parse(this);
    final outputFormat = DateFormat('E, MMM dd, yyyy', 'en_US');
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

  int toInt() {
    if (isEmpty) {
      return 0;
    }
    return int.parse(this);
  }

  double toDouble() {
    if (isEmpty) {
      return 0.0;
    }
    return double.parse(this);
  }
}
