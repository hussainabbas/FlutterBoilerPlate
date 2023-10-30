import 'package:flutter/material.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/widgets/text_view.dart';

class BottomSheetGenericExpansionModal<T> {
  static void show<T>(
    BuildContext context,
    String title,
    Map<String, List<T>>? list,
    String Function(T?) getName,
    Function(T?) onSelect,
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
                fontSize: 16,
              ),
              const Divider(
                color: Colors.grey,
                height: 24,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: list?.length,
                  itemBuilder: (context, index) {
                    final subgroup = list?.keys.elementAt(index);
                    final items = list?[subgroup];
                    return ExpansionTile(
                      title: Text(subgroup ?? ""),
                      children: items?.map((item) {
                            return ListTile(
                              title: Text(getName(item)),
                              onTap: () {
                                onSelect(item);
                                Navigator.of(context)
                                    .pop(); // Close the bottom sheet
                              },
                            );
                          }).toList() ??
                          [],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
