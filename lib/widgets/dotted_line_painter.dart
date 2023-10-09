import 'package:flutter/material.dart';
import 'package:manawanui/helpers/resources/colors.dart';

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.primaryColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0; // Adjust the width of the line as needed

    double dashWidth = 5; // Adjust the width of each dash
    double dashSpace = 5; // Adjust the space between dashes

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, size.height / 2),
          Offset(startX + dashWidth, size.height / 2), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
