import 'package:intl/intl.dart';

extension DoubleX on double {
  String convertToAmount() {
    return NumberFormat("#,##0.00", "en_US").format(this);
  }

  String convertToTwoDecimal() {
    return toStringAsFixed(2);
  }
}
