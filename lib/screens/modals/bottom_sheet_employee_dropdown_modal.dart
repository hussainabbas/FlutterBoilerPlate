import 'package:flutter/material.dart';
import 'package:manawanui/data/models/timesheet_employee_dropdown_response.dart';
import 'package:manawanui/data/models/user_details_response.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/widgets/text_view.dart';

class BottomSheetEmployeeDropdownModal {
  static void show(
    BuildContext context,
    String title,
    List<EligibalEmployeesModal>? list,
    EligibalEmployeesModal? selectedItem,
    UserDetailsResponse? userDetails,
    Function(EligibalEmployeesModal?) onSelect,
  ) {
    showModalBottomSheet(
        barrierLabel: title,
        barrierColor: Colors.black.withOpacity(0.5),
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Column(
              children: [
                TextView(
                    text: title,
                    textColor: AppColors.primaryColor,
                    textFontWeight: FontWeight.bold,
                    fontSize: 16),
                const Divider(
                  color: Colors.grey,
                  height: 24,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: list?.length,
                    itemBuilder: (context, index) {
                      final item = list?[index];
                      return ListTile(
                        onTap: onSelect(list?[index]),
                        title: Text(item?.name ?? ""),
                        leading: Radio<String>(
                          value: item?.id ?? "",
                          groupValue: selectedItem?.id,
                          onChanged: (value) {},
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
