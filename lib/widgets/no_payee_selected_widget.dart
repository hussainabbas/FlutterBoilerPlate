import 'package:flutter/material.dart';
import 'package:manawanui/helpers/extension/context_function.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/widgets/text_view.dart';

class NoPayeeSelectedWidget extends StatelessWidget {
  const NoPayeeSelectedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.fullWidth(),
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300, width: 1.0)),
      child: Column(
        children: [
          const Icon(
            Icons.document_scanner,
            size: 40,
          ),
          const SizedBox(
            height: 16,
          ),
          TextView(
              text: "Payee Type Not Selected",
              textColor: AppColors.primaryColor,
              textFontWeight: FontWeight.normal,
              fontSize: 18),
          const SizedBox(
            height: 8,
          ),
          const TextView(
            text: "Choose a payee type from the options\nabove to proceed",
            textColor: Colors.black,
            textFontWeight: FontWeight.normal,
            fontSize: 14,
            align: TextAlign.center,
          )
        ],
      ),
    );
  }
}
