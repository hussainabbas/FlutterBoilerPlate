// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/core/providers/timesheet_providers.dart';
import 'package:manawanui/data/models/get_employ_by_response.dart';
import 'package:manawanui/helpers/extension/context_function.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';
import 'package:manawanui/widgets/custom_elevated_button.dart';
import 'package:manawanui/widgets/data_choose_widget.dart';
import 'package:manawanui/widgets/dotted_line_painter.dart';
import 'package:manawanui/widgets/section_title.dart';
import 'package:manawanui/widgets/text_view.dart';

class AddEditTimeSheet extends ConsumerWidget {
  const AddEditTimeSheet({super.key, this.employByModel});

  final EmployByModel? employByModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final argsIndex = ModalRoute.of(context)?.settings.arguments as int;
    final mTimeSheetDataListProvider =
        ref.watch(timeSheetDataListProvider.notifier);
    final mExpenseSheetDataListProvider =
        ref.watch(expenseSheetDataListProvider.notifier);

    final mPaymentsSheetDataListProvider =
        ref.watch(paymentsSheetDataListProvider.notifier);
    final ScrollController scrollController = ScrollController();
    // Function to scroll to the newly added item
    void scrollToNewItem(int length) {
      const double itemExtent = 200.0; // Adjust this value as needed
      final double offset = length * itemExtent;

      scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        // Adjust the duration as needed
        curve: Curves.easeInOut,
      );
    }

    return WillPopScope(
      onWillPop: () async {
        ref.invalidate(timeSheetDataListProvider);
        ref.invalidate(expenseSheetDataListProvider);
        ref.invalidate(paymentsSheetDataListProvider);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          title: TextView(
              text: employByModel == null ? "Add Timesheet" : "Edit Timesheet",
              textColor: Colors.black,
              textFontWeight: FontWeight.bold,
              fontSize: 16),
          actions: [
            if (employByModel != null) const Icon(Icons.delete_outlined),
            const SizedBox(
              width: 8,
            )
          ],
        ),
        body: SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // * Payee Name
                const SectionTitle(
                  title: "Payee Name",
                  iconData: Icons.help_rounded,
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.black, // Border color
                        width: 0.2, // Border width
                      ), // Border radius to make it rounded
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TextView(
                                    text: "Choose",
                                    textColor: AppColors.primaryColor,
                                    textFontWeight: FontWeight.normal,
                                    fontSize: 14),
                                const SizedBox(height: 8.0), // Add some spacing
                                CustomPaint(
                                  size: const Size(80.0, 2.0),
                                  painter: DottedLinePainter(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Opacity(
                            opacity: 0.2, child: Icon(Icons.person_pin))
                      ],
                    ),
                  ),
                ),

                // * Fortnight Period
                const SizedBox(
                  height: 32,
                ),
                const SectionTitle(
                  title: "Fortnight Period",
                  iconData: Icons.help_rounded,
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.black, // Border color
                        width: 0.2, // Border width
                      ), // Border radius to make it rounded
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TextView(
                                    text: "Choose",
                                    textColor: AppColors.primaryColor,
                                    textFontWeight: FontWeight.normal,
                                    fontSize: 14),
                                const SizedBox(height: 8.0), // Add some spacing
                                CustomPaint(
                                  size: const Size(80.0, 2.0),
                                  painter: DottedLinePainter(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Opacity(
                            opacity: 0.2, child: Icon(Icons.calendar_month))
                      ],
                    ),
                  ),
                ),

                // * Time Sheet
                const SizedBox(
                  height: 32,
                ),
                SectionTitle(
                  title: "Time Sheet",
                  isAddButton: true,
                  callbackAction: () {
                    mTimeSheetDataListProvider.addItem("item");
                    console(
                        "timeSheetDataList.value.length = ${mTimeSheetDataListProvider.state.length}");
                    scrollToNewItem(mTimeSheetDataListProvider.state.length);
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                StreamBuilder<List<String>>(
                  stream: mTimeSheetDataListProvider.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  TimesheetItem(
                                    index: index,
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                            color: AppColors.primaryColor,
                                            // Border color
                                            width: 0.2, // Border width
                                          ), // Border radius to make it rounded
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            mTimeSheetDataListProvider
                                                .removeItem(
                                                    snapshot.data![index]);
                                            console(
                                                "mTimeSheetDataListProvider = ${mTimeSheetDataListProvider.state.length}");
                                          },
                                          child: Icon(
                                            Icons.delete_outlined,
                                            size: 24,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ))
                                ],
                              );
                            });
                      } else {
                        return const NotFoundWidget(
                          title: "Timesheet",
                          iconData: Icons.timer,
                        );
                      }
                    } else {
                      return const NotFoundWidget(
                        title: "Timesheet",
                        iconData: Icons.timer,
                      );
                    }
                  },
                ),

                // * Expense Sheet
                const SizedBox(
                  height: 32,
                ),
                SectionTitle(
                  title: "Expense Sheet",
                  isAddButton: true,
                  callbackAction: () {
                    mExpenseSheetDataListProvider.addItem("item");
                    scrollToNewItem(
                        mExpenseSheetDataListProvider.state.length * 2);
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                StreamBuilder<List<String>>(
                  stream: mExpenseSheetDataListProvider.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  ExpenseSheetItem(
                                    index: index,
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                            color: AppColors.primaryColor,
                                            // Border color
                                            width: 0.5, // Border width
                                          ), // Border radius to make it rounded
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            mExpenseSheetDataListProvider
                                                .removeItem(
                                                    snapshot.data![index]);
                                          },
                                          child: Icon(
                                            Icons.delete_outlined,
                                            size: 24,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ))
                                ],
                              );
                            });
                      } else {
                        return const NotFoundWidget(
                            title: "Expense Sheet",
                            iconData: Icons.document_scanner_rounded);
                      }
                    } else {
                      return const NotFoundWidget(
                          title: "Expense Sheet",
                          iconData: Icons.document_scanner_rounded);
                    }
                  },
                ),

                // * Payments
                const SizedBox(
                  height: 32,
                ),
                SectionTitle(
                  title: "Payments",
                  isAddButton: true,
                  callbackAction: () {
                    mPaymentsSheetDataListProvider.addItem("item");
                    scrollToNewItem(
                        mPaymentsSheetDataListProvider.state.length * 3);
                  },
                ),
                const SizedBox(
                  height: 8,
                ),

                StreamBuilder<List<String>>(
                  stream: mPaymentsSheetDataListProvider.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  PaymentsItem(
                                    index: index,
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                            color: AppColors.primaryColor,
                                            // Border color
                                            width: 0.5, // Border width
                                          ), // Border radius to make it rounded
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            mPaymentsSheetDataListProvider
                                                .removeItem(
                                                    snapshot.data![index]);
                                          },
                                          child: Icon(
                                            Icons.delete_outlined,
                                            size: 24,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ))
                                ],
                              );
                            });
                      } else {
                        return const NotFoundWidget(
                            title: "Payment", iconData: Icons.payment);
                      }
                    } else {
                      return const NotFoundWidget(
                          title: "Payment", iconData: Icons.payment);
                    }
                  },
                ),

                // * Save button
                const SizedBox(
                  height: 32,
                ),
                CustomElevatedButton(
                  title: "Save",
                  widthMultiplier: kIsWeb ? 0.14 : 0.35,
                  isFullRounded: true,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TimesheetItem extends ConsumerWidget {
  final int index;

  const TimesheetItem({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    for (int i = 0; i < 10; i++) {
      currentPageProviders.add(StateProvider<int>((ref) => 0));
    }

    final currentPage = ref.watch(currentPageProviders[index].notifier);
    PageController pageController =
        PageController(initialPage: currentPage.state);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16, top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.black, // Border color
          width: 0.2, // Border width
        ), // Border radius to make it rounded
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Expanded(
                  child: DataChooseWidget(
                title: "Person Supported",
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: DataChooseWidget(
                title: "Pay Component",
              )),
            ],
          ),

          // * show date view
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 190,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.black, // Border color
                width: 0.2, // Border width
              ), // Border radius to make it rounded
            ),
            child: Stack(
              children: [
                PageView.builder(
                  controller: pageController,
                  onPageChanged: (int page) {
                    currentPage.state = page;
                  },
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return DateViewWidget(
                      item: index.toString(),
                    );
                  },
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: GestureDetector(
                        onTap: () {
                          console("NEXT -> ${currentPage.state}");
                          if (currentPage.state < 9) {
                            pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.primaryColor,
                          size: 40,
                        ))),
                Positioned(
                    left: 0,
                    bottom: 0,
                    top: 0,
                    child: GestureDetector(
                        onTap: () {
                          console("Previous -> ${currentPage.state}");
                          if (currentPage.state > 1) {
                            pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: AppColors.primaryColor,
                          size: 40,
                        ))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExpenseSheetItem extends ConsumerWidget {
  final int index;

  const ExpenseSheetItem({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16, top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.black, // Border color
          width: 0.2, // Border width
        ), // Border radius to make it rounded
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: DataChooseWidget(
                title: "Person Supported",
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: DataChooseWidget(
                title: "Pay Component",
              )),
            ],
          ),

          // * show date view
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                  child: DataChooseWidget(
                title: "Amount",
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: DataChooseWidget(
                title: "Expense/Payee",
              )),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          DataChooseWidget(
            title: "Expense Type",
          ),
          SizedBox(
            height: 8,
          ),
          DataChooseWidget(
            title: "Hour",
          ),

          SizedBox(
            height: 8,
          ),
          DataChooseWidget(
            title: "Particulars",
          ),

          SizedBox(
            height: 8,
          ),
          DataChooseWidget(
            title: "Invoice Image",
          ),
        ],
      ),
    );
  }
}

class PaymentsItem extends ConsumerWidget {
  final int index;

  const PaymentsItem({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16, top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.black, // Border color
          width: 0.2, // Border width
        ), // Border radius to make it rounded
      ),
      child: const Column(
        children: [
          DataChooseWidget(
            title: "Person Supported",
          ),

          // * show date view
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                  child: DataChooseWidget(
                title: "Date",
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: DataChooseWidget(
                title: "Amount",
              )),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          DataChooseWidget(
            title: "Provider Name",
          ),
          SizedBox(
            height: 8,
          ),
          DataChooseWidget(
            title: "Customer No.",
          ),

          SizedBox(
            height: 8,
          ),
          DataChooseWidget(
            title: "Invoice No.",
          ),

          SizedBox(
            height: 8,
          ),
          DataChooseWidget(
            title: "Invoice Image",
          ),
        ],
      ),
    );
  }
}

class DateViewWidget extends ConsumerWidget {
  final String item;

  const DateViewWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Opacity(
            opacity: 0.05,
            child: Icon(
              Icons.calendar_month,
              size: 120,
            )),
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextView(
                text: "Date - $item",
                textColor: Colors.black,
                textFontWeight: FontWeight.bold,
                fontSize: 14),
            const SizedBox(
              height: 8,
            ),
            TextView(
                text: "Mon, Aug 28, 2023",
                textColor: AppColors.primaryColor,
                textFontWeight: FontWeight.bold,
                fontSize: 18),
            const SizedBox(
              height: 16,
            ),
            const TextView(
                text: "Hours",
                textColor: Colors.black,
                textFontWeight: FontWeight.normal,
                fontSize: 14),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.black, // Border color
                  width: 0.2, // Border width
                ), // Border radius to make it rounded
              ),
              child: TextView(
                  text: "00.00",
                  textColor: AppColors.primaryColor,
                  textFontWeight: FontWeight.bold,
                  fontSize: 22),
            )
          ],
        ),
      ],
    );
  }
}
/*
class DataChooseWidget extends StatelessWidget {
  final String title;
  final String? value;

  const DataChooseWidget({super.key, required this.title , this.value});

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextView(
                text: title,
                textColor: Colors.black,
                textFontWeight: FontWeight.normal,
                fontSize: 14),
            const SizedBox(
              height: 8,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextView(
                          text: value ?? "Choose",
                          textColor: AppColors.primaryColor,
                          textFontWeight: FontWeight.normal,
                          fontSize: 14),
                      const SizedBox(height: 8.0), // Add some spacing
                      CustomPaint(
                        size: const Size(80.0, 2.0),
                        painter: DottedLinePainter(),
                      ),
                    ],
                  ),
                ),
                const Positioned(
                    right: 0,
                    child:
                        Opacity(opacity: 0.07, child: Icon(Icons.person_pin)))
              ],
            ),
          ],
        ),
      ),
    );
  }
}*/

class NotFoundWidget extends StatelessWidget {
  final String title;
  final IconData iconData;

  const NotFoundWidget(
      {super.key, required this.title, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.fullWidth(),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.black, // Border color
          width: 0.2, // Border width
        ), // Border radius to make it rounded
      ),
      child: Column(
        children: [
          Icon(
            iconData,
            color: AppColors.primaryColor,
          ),
          const SizedBox(
            height: 16,
          ),
          TextView(
              text: "No $title Added",
              textColor: Colors.black,
              textFontWeight: FontWeight.normal,
              fontSize: 16),
          TextView(
              text: "Please press + button to add a $title",
              textColor: Colors.black,
              textFontWeight: FontWeight.normal,
              fontSize: 14),
        ],
      ),
    );
  }
}
