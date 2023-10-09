import 'package:flutter/material.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/widgets/text_view.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle(
      {super.key,
      required this.title,
      this.iconData,
      this.callbackAction,
      this.isAddButton});

  final String title;
  final IconData? iconData;
  final VoidCallback? callbackAction;
  final bool? isAddButton;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "$title Information",
      child: Row(
        children: [
          Container(
            width: 20, // Make the container full width
            height: 3.0, // Height of the line
            color: AppColors.primaryColor, // Color of the line
          ),
          const SizedBox(
            width: 16,
          ),
          TextView(
              text: title,
              textColor: AppColors.primaryColor,
              textFontWeight: FontWeight.bold,
              fontSize: 16),
          if (isAddButton ?? false)
            Expanded(
              child: Row(
                children: [
                  const Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: callbackAction,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 4, 16, 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        // Background color of the container
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          TextView(
                              text: "Add",
                              textColor: Colors.white,
                              textFontWeight: FontWeight.bold,
                              fontSize: 14)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (iconData != null)
            Expanded(
              child: GestureDetector(
                onTap: callbackAction,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    iconData,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
