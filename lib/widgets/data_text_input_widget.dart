import 'package:flutter/material.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';
import 'package:manawanui/widgets/dotted_line_painter.dart';
import 'package:manawanui/widgets/simple_text_input.dart';
import 'package:manawanui/widgets/text_view.dart';

class DataTextInputWidget extends StatelessWidget {
  const DataTextInputWidget(
      {super.key,
      required this.title,
      this.value,
      required this.controller,
      required this.onChanged,
      required this.isEditing,
      this.error});

  final String title;
  final String? value;
  final TextEditingController controller;
  final String? error;
  final bool isEditing;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    console("VALUE => $value");
    controller.text = value ?? "";
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
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextView(
                      text: title,
                      textColor: Colors.black,
                      textFontWeight: FontWeight.normal,
                      fontSize: 14),

                  SimpleTextField(
                    isEditable: isEditing,
                    controller: controller,
                    onChanged: (e) {},
                    errorMessage: error,
                  ), // Add some spacing
                  CustomPaint(
                    size: const Size(80.0, 2.0),
                    painter: DottedLinePainter(),
                  ),
                ],
              ),
            ),
            const Positioned(
                right: 0,
                child: Opacity(opacity: 0.07, child: Icon(Icons.person_pin)))
          ],
        ),
      ),
    );
  }
}
