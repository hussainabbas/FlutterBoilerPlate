import 'package:flutter/material.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/widgets/text_view.dart';

class SectionSimpleBody extends StatelessWidget {
  const SectionSimpleBody(
      {super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        // Background color of the container
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.black, // Border color
          width: 0.05, // Border width
        ), // Border radius to make it rounded
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextView(
                text: title,
                textColor: AppColors.primaryColor,
                textFontWeight: FontWeight.normal,
                fontSize: 15),
          ),
          const SizedBox(
            width: 16,
          ),
          TextView(
              text: value,
              textColor: Colors.black,
              textFontWeight: FontWeight.bold,
              fontSize: 15),
        ],
      ),
    );
  }
}
