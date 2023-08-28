import 'package:app_name/helpers/resources/colors.dart';
import 'package:flutter/material.dart';

class CircularProgressWidget extends StatelessWidget {
  const CircularProgressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor)),
      ),
    );
  }
}
