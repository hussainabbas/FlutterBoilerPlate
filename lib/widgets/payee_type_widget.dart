import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/core/providers/payee_providers.dart';
import 'package:manawanui/helpers/extension/context_function.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';
import 'package:manawanui/widgets/text_view.dart';

class PayeeTypeWidget extends ConsumerWidget {
  final IconData? iconData;
  final String title;
  final bool? isEditable;

  const PayeeTypeWidget(
      {super.key, required this.title, this.iconData, this.isEditable = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    console("PayeeTypeWidget=> $isEditable");
    return GestureDetector(
      onTap: () {
        if (isEditable == true) {
          ref.watch(selectedPayeeProvider.notifier).state =
              PayeeTypeWidget(title: title, iconData: iconData);
        }
      },
      child: SizedBox(
          width: context.fullWidth(multiplier: 0.18),
          child: Consumer(
            builder: (context, ref, child) {
              final selectedPayee = ref.watch(selectedPayeeProvider);
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                        border: Border.all(
                            color: selectedPayee?.title == title
                                ? AppColors.primaryColor
                                : Colors.white,
                            width: 1.0)),
                    child: Icon(
                      iconData,
                      color: selectedPayee?.title == title
                          ? AppColors.primaryColor
                          : Colors.black,
                    ),
                  ),
                  Expanded(
                    child: TextView(
                        text: title,
                        align: TextAlign.center,
                        textColor: selectedPayee?.title == title
                            ? AppColors.primaryColor
                            : Colors.black,
                        textFontWeight: FontWeight.normal,
                        fontSize: 12),
                  )
                ],
              );
            },
          )),
    );
  }
}
