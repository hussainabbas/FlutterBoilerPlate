import 'package:flutter/material.dart';
import 'package:manawanui/helpers/resources/colors.dart';

class SimpleTextField extends StatelessWidget {
  const SimpleTextField(
      {Key? key,
      required this.controller,
      required this.onChanged,
      required this.isEditable,
      this.errorMessage})
      : super(key: key);

  final TextEditingController controller;
  final String? errorMessage;
  final bool isEditable;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            enabled: isEditable,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.normal,
                fontFamily: 'Avenir'),
            controller: controller,
            onChanged: onChanged,
            decoration: const InputDecoration(
              border: InputBorder.none, // Remove the border
              hintText: 'empty', // No hint text
              contentPadding: EdgeInsets.all(0), // No padding
            ),
          ),

          if (errorMessage != null && errorMessage!.isNotEmpty)
            Text(
              errorMessage.toString(),
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.normal,
                fontSize: 12,
              ),
            )
          //TextView(text: errorMessage.toString(), textColor: Colors.red, textFontWeight: FontWeight.normal, fontSize: 12, align: TextAlign.start,)
        ],
      ),
    );
  }
}
