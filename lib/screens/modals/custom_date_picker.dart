import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manawanui/helpers/resources/colors.dart';

Future<void> customDatePicker(BuildContext context, String selectedDateString,
    Function(DateTime) callback) async {
  DateFormat format = DateFormat("MM/dd/yyyy", "en_US");
  DateTime selectedDate = format.parse(selectedDateString);
  DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(1930),
    lastDate: DateTime(2101),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: AppColors.primaryColor,
          colorScheme: ColorScheme.light(primary: AppColors.primaryColor),
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        child: child ??
            const SizedBox.shrink(), // Add a fallback child if child is null.
      );
    },
  );

  if (picked != null && picked != selectedDate) {
    callback(picked);
  }
}
