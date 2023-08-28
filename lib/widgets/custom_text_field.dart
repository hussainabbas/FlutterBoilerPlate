import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.title,
      required this.prefixIcon,
      required this.onChanged,
      this.errorMessage,
      this.obscure})
      : super(key: key);

  final TextEditingController controller;
  final String title;
  final bool? obscure;
  final String? errorMessage;
  final Icon prefixIcon;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              labelText: title,
              prefixIcon: prefixIcon,
            ),
            obscureText: obscure ?? false,
          ),
          const SizedBox(
            height: 8,
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
