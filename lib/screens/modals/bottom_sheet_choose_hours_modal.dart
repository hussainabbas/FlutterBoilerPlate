import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/core/providers/timesheet_providers.dart';
import 'package:manawanui/helpers/extension/context_function.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/widgets/text_view.dart';
import 'package:numberpicker/numberpicker.dart';

class BottomSheetChooseHoursModal {
  static void show(
      BuildContext context,
      Function(double?) onSelect,
      double? selectedValue,
      WidgetRef ref,
      int index,
      TimesheetHoursController hoursController) {
    showModalBottomSheet(
        barrierLabel: "Choose Hours",
        barrierColor: Colors.black.withOpacity(0.5),
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          final selectedTimesheetSelectedHoursState = ref.watch(hoursController
              .selectedTimesheetSelectedHoursProviders[index].notifier);
          return StreamBuilder<double?>(
              stream: selectedTimesheetSelectedHoursState.stream,
              builder: (context, snapshot) {
                return Container(
                  color: Colors.white,
                  height: context.fullHeight(multiplier: 0.35),
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Column(
                    children: [
                      TextView(
                          text: "Choose Hours",
                          textColor: AppColors.primaryColor,
                          textFontWeight: FontWeight.bold,
                          fontSize: 16),
                      const Divider(
                        color: Colors.grey,
                        height: 24,
                      ),
                      Expanded(
                        child: DecimalNumberPicker(
                            value: ref
                                    .watch(hoursController
                                        .selectedTimesheetSelectedHoursProviders[
                                            index]
                                        .notifier)
                                    .state ??
                                0,
                            minValue: 0,
                            maxValue: 24,
                            decimalPlaces: 2,
                            onChanged: (value) {
                              ref
                                  .watch(hoursController
                                      .selectedTimesheetSelectedHoursProviders[
                                          index]
                                      .notifier)
                                  .state = value;
                              //onSelect(value);
                            }),
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
