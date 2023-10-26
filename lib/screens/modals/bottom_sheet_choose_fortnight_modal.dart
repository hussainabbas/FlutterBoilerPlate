import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:manawanui/core/providers/timesheet_providers.dart';
import 'package:manawanui/data/models/get_timesheet_transaction_periods_response.dart';
import 'package:manawanui/data/models/user_details_response.dart';
import 'package:manawanui/helpers/extension/context_function.dart';
import 'package:manawanui/helpers/extension/string_extensions.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';
import 'package:manawanui/widgets/custom_elevated_button.dart';
import 'package:manawanui/widgets/text_view.dart';

class BottomSheetChooseFortnightModal {
  static void show(
    BuildContext context,
    List<TransPeriodModal>? list,
    UserDetailsResponse? userDetails,
    WidgetRef ref,
  ) {
    int currentPageIndex = 0;
    showModalBottomSheet(
        barrierLabel: "Please select fortnight period",
        barrierColor: Colors.black.withOpacity(0.5),
        context: context,
        builder: (BuildContext context) {
          final PageController pageController = PageController();
          return Container(
            color: Colors.white,
            height: context.fullHeight(multiplier: 0.35),
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Column(
              children: [
                TextView(
                    text: "Please select fortnight period",
                    textColor: AppColors.primaryColor,
                    textFontWeight: FontWeight.bold,
                    fontSize: 16),
                const Divider(
                  color: Colors.grey,
                  height: 24,
                ),
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                          onTap: () {
                            pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                          child: const Icon(Icons.arrow_back_ios)),
                      Expanded(
                        child: PageView.builder(
                          itemCount: list?.length,
                          controller: pageController,
                          itemBuilder: (context, index) {
                            final dateParts = list?[index].name?.split("-");
                            currentPageIndex = index;
                            return Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextView(
                                          text: "Start",
                                          textColor: AppColors.primaryColor,
                                          textFontWeight: FontWeight.normal,
                                          fontSize: 18),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      TextView(
                                          text: dateParts?[0]
                                                  .convertStringDDMMYYYYToE() ??
                                              "",
                                          textColor: Colors.black,
                                          textFontWeight: FontWeight.normal,
                                          fontSize: 16),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      TextView(
                                          text: dateParts?[0]
                                                  .convertStringDDMMYYYYToMMMDD() ??
                                              "",
                                          textColor: Colors.black,
                                          textFontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      TextView(
                                          text: dateParts?[0]
                                                  .convertStringDDMMYYYDateToYYYY() ??
                                              "",
                                          textColor: Colors.black,
                                          textFontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextView(
                                          text: "End",
                                          textColor: AppColors.primaryColor,
                                          textFontWeight: FontWeight.normal,
                                          fontSize: 18),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      TextView(
                                          text: dateParts?[1]
                                                  .convertStringDDMMYYYYToE() ??
                                              "",
                                          textColor: Colors.black,
                                          textFontWeight: FontWeight.normal,
                                          fontSize: 16),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      TextView(
                                          text: dateParts?[1]
                                                  .convertStringDDMMYYYYToMMMDD() ??
                                              "",
                                          textColor: Colors.black,
                                          textFontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      TextView(
                                          text: dateParts?[1]
                                                  .convertStringDDMMYYYDateToYYYY() ??
                                              "",
                                          textColor: Colors.black,
                                          textFontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                          child: const Icon(Icons.arrow_forward_ios)),
                      const SizedBox(
                        width: 16,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: CustomElevatedButton(
                      title: "Insert Fortnight",
                      onPressed: () {
                        console(
                            " currentPageIndex = index -> $currentPageIndex");
                        console(
                            " currentPageIndex = index -> ${list?[currentPageIndex]}");
                        ref
                            .watch(selectedTimesheetFortnightProvider.notifier)
                            .state = list?[currentPageIndex];
                        context.pop();
                      },
                      backgroundColor: AppColors.primaryColor,
                      isFullRounded: true,
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: CustomElevatedButton(
                      title: "Cancel",
                      onPressed: () {
                        context.pop();
                      },
                      backgroundColor: AppColors.primaryColor,
                      isFullRounded: true,
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
