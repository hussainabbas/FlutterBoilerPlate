import 'package:app_name/widgets/text_view.dart';
import 'package:flutter/material.dart';

class ApiErrorWidget extends StatelessWidget {
  const ApiErrorWidget({Key? key, required String message})
      : _message = message,
        super(key: key);

  final String _message;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Center(
        child: TextView(
            text: _message,
            textColor: Colors.red,
            textFontWeight: FontWeight.normal,
            fontSize: 12),
      ),
    );
  }
}
