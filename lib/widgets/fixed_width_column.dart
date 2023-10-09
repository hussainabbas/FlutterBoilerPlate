import 'package:flutter/material.dart';
import 'package:manawanui/helpers/extension/context_function.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';
import 'package:manawanui/widgets/text_view.dart';

class FixedWidthColumn extends StatelessWidget {
  final String text;
  final double multiplier;
  final bool? isShowing;
  final bool? isStatus;
  final String? status;

  //final Color statusContainerColor;

  const FixedWidthColumn(
      {super.key,
      required this.text,
      required this.multiplier,
      this.isStatus = false,
      this.status,
      //required this.statusContainerColor,
      this.isShowing = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: context.fullWidth() * multiplier,
      // Set a fixed width for columns
      child: Column(
        children: [
          isStatus ?? false
              ? Container(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: isStatus ?? false
                          ? getPayeeStatusColor(status ?? "")
                          : null),
                  child: TextView(
                    text: text,
                    textColor: isStatus ?? false ? Colors.white : Colors.black,
                    textFontWeight: FontWeight.normal,
                    fontSize: 12,
                    align: TextAlign.center,
                  ))
              : TextView(
                  text: text,
                  textColor: isStatus ?? false ? Colors.white : Colors.black,
                  textFontWeight: FontWeight.normal,
                  fontSize: 13,
                  align: TextAlign.center,
                ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: context.fullWidth(multiplier: 0.1),
            height: 2,
            color: isShowing ?? false ? AppColors.primaryColor : Colors.white,
          ),
        ],
      ),
    );
  }
}
