import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/data/models/reminders_list_response.dart';
import 'package:manawanui/helpers/extension/context_function.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/helpers/resources/routes_resources.dart';
import 'package:manawanui/widgets/custom_elevated_button.dart';
import 'package:manawanui/widgets/text_view.dart';

class RemindersMenuScreen extends HookConsumerWidget {
  const RemindersMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = useState<List<ReminderListResponse>>([
      ReminderListResponse(id: "1"),
      ReminderListResponse(id: "2"),
      ReminderListResponse(id: "3"),
      ReminderListResponse(id: "4"),
      ReminderListResponse(id: "5"),
      ReminderListResponse(id: "6"),
      // Add more data items here
    ]);
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SwitchListTile(
                tileColor: Colors.white,
                title: TextView(
                    text: "Timesheet Notification",
                    textColor: AppColors.primaryColor,
                    textFontWeight: FontWeight.bold,
                    fontSize: 16),
                value: true,
                onChanged: (value) {},
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: data.value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(
                              width: 1, color: AppColors.primaryColor),
                          right: BorderSide(
                              width: 1, color: AppColors.primaryColor),
                          bottom: BorderSide(
                              width: 1, color: AppColors.primaryColor),
                          left: BorderSide(
                            width: 4.0, // Set the width of the left border
                            color: AppColors
                                .primaryColor, // Set the color of the border
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(top: 8),
                      child: Column(
                        children: [
                          //Time

                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.notifications_none,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              TextView(
                                  text: "09:30 AM",
                                  textColor: Colors.grey,
                                  textFontWeight: FontWeight.normal,
                                  fontSize: 14),
                              SizedBox(
                                width: 16,
                              ),
                              TextView(
                                  text: "6 Days Left",
                                  textColor: Colors.grey,
                                  textFontWeight: FontWeight.normal,
                                  fontSize: 14),
                            ],
                          ),

                          //details
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Column(
                                children: [
                                  TextView(
                                      text: "OCT",
                                      textColor: Colors.grey,
                                      textFontWeight: FontWeight.normal,
                                      fontSize: 10),
                                  TextView(
                                      text: "01",
                                      textColor: Colors.black,
                                      textFontWeight: FontWeight.bold,
                                      fontSize: 14),
                                  TextView(
                                      text: "2023",
                                      textColor: Colors.grey,
                                      textFontWeight: FontWeight.normal,
                                      fontSize: 10),
                                ],
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                children: [
                                  TextView(
                                      text: "Timesheet Submission Reminder",
                                      textColor: AppColors.primaryColor,
                                      textFontWeight: FontWeight.normal,
                                      fontSize: 14),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      const TextView(
                                          align: TextAlign.center,
                                          text: "Fornight\nPeriod",
                                          textColor: Colors.grey,
                                          textFontWeight: FontWeight.normal,
                                          fontSize: 14),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            border: Border.all(
                                                width: 1, color: Colors.grey)),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            const TextView(
                                                align: TextAlign.center,
                                                text: "Sun",
                                                textColor: Colors.grey,
                                                textFontWeight:
                                                    FontWeight.normal,
                                                fontSize: 12),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Column(
                                              children: [
                                                TextView(
                                                    align: TextAlign.center,
                                                    text: "Sun",
                                                    textColor:
                                                        AppColors.primaryColor,
                                                    textFontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 12),
                                                TextView(
                                                    align: TextAlign.center,
                                                    text: "17",
                                                    textColor:
                                                        AppColors.primaryColor,
                                                    textFontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 12),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            const TextView(
                                                align: TextAlign.center,
                                                text: "2023",
                                                textColor: Colors.grey,
                                                textFontWeight:
                                                    FontWeight.normal,
                                                fontSize: 12),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            border: Border.all(
                                                width: 1, color: Colors.grey)),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            const TextView(
                                                align: TextAlign.center,
                                                text: "Sun",
                                                textColor: Colors.grey,
                                                textFontWeight:
                                                    FontWeight.normal,
                                                fontSize: 12),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Column(
                                              children: [
                                                TextView(
                                                    align: TextAlign.center,
                                                    text: "Sun",
                                                    textColor:
                                                        AppColors.primaryColor,
                                                    textFontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 12),
                                                TextView(
                                                    align: TextAlign.center,
                                                    text: "17",
                                                    textColor:
                                                        AppColors.primaryColor,
                                                    textFontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 12),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            const TextView(
                                                align: TextAlign.center,
                                                text: "2023",
                                                textColor: Colors.grey,
                                                textFontWeight:
                                                    FontWeight.normal,
                                                fontSize: 12),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          //button
                          const SizedBox(
                            height: 16,
                          ),
                          CustomElevatedButton(
                            title: "Create Timesheet",
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.ADD_EDIT_TIMESHEET,
                                  arguments: -1);
                            },
                            isFullRounded: true,
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}

class NothingFoundWidget extends StatelessWidget {
  const NothingFoundWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.fullWidth(),
      height: context.fullHeight(),
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextView(
                text: "No $title Found",
                textColor: AppColors.primaryColor,
                textFontWeight: FontWeight.bold,
                fontSize: 16),
            const SizedBox(
              height: 16,
            ),
            Icon(
              Icons.not_accessible,
              size: 220,
              color: AppColors.primaryColor,
            ),
            const SizedBox(
              height: 16,
            ),
            TextView(
              text: "Click '+' below button to\nadd $title",
              textColor: Colors.grey,
              textFontWeight: FontWeight.bold,
              fontSize: 14,
              align: TextAlign.center,
            ),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
