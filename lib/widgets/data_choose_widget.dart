import 'package:flutter/material.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/widgets/dotted_line_painter.dart';
import 'package:manawanui/widgets/text_view.dart';

class DataChooseWidget extends StatelessWidget {
  const DataChooseWidget({super.key, required this.title, this.value});

  final String title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.black, // Border color
            width: 0.05, // Border width
          ), // Border radius to make it rounded
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextView(
                text: title,
                textColor: Colors.black,
                textFontWeight: FontWeight.normal,
                fontSize: 14),
            const SizedBox(
              height: 14,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextView(
                          text: value ?? "Choose",
                          textColor: AppColors.primaryColor,
                          textFontWeight: FontWeight.normal,
                          fontSize: 14),
                      const SizedBox(height: 14.0), // Add some spacing
                      CustomPaint(
                        size: const Size(80.0, 2.0),
                        painter: DottedLinePainter(),
                      ),
                    ],
                  ),
                ),
                const Positioned(
                    right: 0,
                    child:
                        Opacity(opacity: 0.07, child: Icon(Icons.person_pin)))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
