import 'package:flutter/material.dart';
import 'package:manawanui/widgets/text_view.dart';

class ApiErrorWidget extends StatelessWidget {
  const ApiErrorWidget({Key? key, required String message})
      : _message = message,
        super(key: key);

  final String _message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextView(
              align: TextAlign.center,
              text: _message,
              textColor: Colors.red,
              textFontWeight: FontWeight.normal,
              fontSize: 12),
        ],
      ),
    );
  }
}
