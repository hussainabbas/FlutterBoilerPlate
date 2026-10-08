import 'package:flutter/material.dart';
import 'package:manawanui/helpers/resources/colors.dart';

class CircularProgressWidget extends StatelessWidget {
  const CircularProgressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor)),
      ),
    );
  }
}
