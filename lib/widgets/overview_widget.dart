import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:manawanui/data/models/get_statement_new_response.dart';
import 'package:manawanui/helpers/extension/context_function.dart';
import 'package:manawanui/widgets/text_view.dart';

class OverviewWidget extends StatelessWidget {
  const OverviewWidget({super.key, required this.statementNewResponse});

  final GetStatementNewResponse? statementNewResponse;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: context.fullWidth(),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.black, // Border color
              width: 0.05, // Border width
            ), // Border radius to make it rounded
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Html(
                  shrinkWrap: true,
                  data: statementNewResponse?.response?.detailText ?? ""),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.black, // Border color
              width: 0.05, // Border width
            ), // Border radius to make it rounded
          ),
          child: Row(
            children: [
              const Icon(Icons.warning),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: TextView(
                    text: statementNewResponse?.response?.mainText ?? "",
                    textColor: Colors.black,
                    textFontWeight: FontWeight.normal,
                    fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
