import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/widgets/custom_text_field.dart';
import 'package:manawanui/widgets/text_view.dart';

class HelpAndResourcesMenuScreen extends HookConsumerWidget {
  const HelpAndResourcesMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextView(
                    text: "Wat do you need help with?",
                    textColor: Colors.black,
                    textFontWeight: FontWeight.bold,
                    fontSize: 16),
                CustomTextField(
                    controller: TextEditingController(),
                    title: "Search",
                    onChanged: (we) {}),
              ],
            ),
          ),
          Expanded(
              child: ListView.separated(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ExpansionPanelList(
                expandedHeaderPadding: const EdgeInsets.all(0),
                expandIconColor: AppColors.primaryColor,
                children: [
                  ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          tileColor: Colors.white,
                          title: TextView(
                              text: "Statement",
                              textColor: AppColors.primaryColor,
                              textFontWeight: FontWeight.normal,
                              fontSize: 16),
                          subtitle: const TextView(
                              text: "Track your Statement",
                              textColor: Colors.grey,
                              textFontWeight: FontWeight.normal,
                              fontSize: 14),
                        );
                      },
                      body: ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 50, right: 16),
                        tileColor: Colors.white,
                        title: TextView(
                            text: "Budgeting",
                            textColor: AppColors.primaryColor,
                            textFontWeight: FontWeight.normal,
                            fontSize: 16),
                        subtitle: const TextView(
                            text: "Track your Budgeting",
                            textColor: Colors.grey,
                            textFontWeight: FontWeight.normal,
                            fontSize: 14),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      isExpanded: false),
                ],
                expansionCallback: (int index, bool isExpanded) {},
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height: 1,
              );
            },
          ))
        ],
      ),
    );
  }
}
