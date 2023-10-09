import 'package:flutter/material.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/widgets/text_view.dart';

class SectionBody extends StatelessWidget {
  const SectionBody(
      {super.key,
      required this.leadingIcon,
      required this.title,
      required this.value,
      this.callbackAction,
      this.backgroundColor,
      this.trailingIcon});

  final IconData leadingIcon;
  final String title;
  final String value;
  final IconData? trailingIcon;
  final VoidCallback? callbackAction;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callbackAction,
      child: Container(
        padding: EdgeInsets.fromLTRB(16, backgroundColor == null ? 20 : 32, 16,
            backgroundColor == null ? 20 : 32),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          // Background color of the container
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.black, // Border color
            width: 0.05, // Border width
          ), // Border radius to make it rounded
        ),
        child: Row(
          children: [
            //Leading Icon
            Icon(
              leadingIcon,
              color: backgroundColor == null ? Colors.grey : Colors.white,
            ),
            //Title value
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                      text: title,
                      textColor:
                          backgroundColor == null ? Colors.black : Colors.white,
                      textFontWeight: FontWeight.normal,
                      fontSize: backgroundColor == null ? 12 : 15),
                  const SizedBox(
                    height: 6,
                  ),
                  TextView(
                      text: value,
                      textColor:
                          backgroundColor == null ? Colors.black : Colors.white,
                      textFontWeight: FontWeight.bold,
                      fontSize: backgroundColor == null ? 12 : 15),
                ],
              ),
            ),

            if (trailingIcon != null)
              Icon(
                trailingIcon,
                color: backgroundColor == null
                    ? AppColors.primaryColor
                    : Colors.white,
              )
          ],
        ),
      ),
    );
  }
}
