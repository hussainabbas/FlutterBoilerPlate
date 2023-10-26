import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/widgets/text_view.dart';

class BottomSheetGenericModal<T> {
  static void show<T>(
    BuildContext context,
    String title,
    List<T>? list,
    T? selectedItem,
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
                    final item = list?[index];
                    return ListTile(
                      onTap: () async {
                        onSelect(list?[index]);
                        context.pop();
                      },
                      title: Text(getName(item)),
                      leading: Radio<T?>(
                        value: item,
                        groupValue: selectedItem,
                        onChanged: (value) {},
                      ),
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
