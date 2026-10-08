import 'package:flutter/material.dart';
import 'package:manawanui/helpers/resources/colors.dart';

class SimpleTextField extends StatelessWidget {
  const SimpleTextField(
      {Key? key,
      required this.controller,
      required this.onChanged,
      required this.isEditable,
      this.textInputType,
      this.maxLength,
      this.hint,
      this.focusNode,
      this.errorMessage})
      : super(key: key);

  final TextEditingController controller;
  final String? errorMessage;
  final bool isEditable;
  final TextInputType? textInputType;
  final ValueChanged<String> onChanged;
  final int? maxLength;
  final String? hint;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            enabled: isEditable,
            textAlign: TextAlign.center,
            keyboardType: textInputType,
            focusNode: focusNode,
            maxLength: maxLength,
            style: TextStyle(
                fontSize: 16,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.normal,
                fontFamily: 'Avenir'),
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              border: InputBorder.none, // Remove the border
              hintText: hint ?? 'empty', // No hint text
              counterText: '',
              contentPadding: const EdgeInsets.all(0), // No padding
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
