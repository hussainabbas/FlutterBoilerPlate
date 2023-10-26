// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/core/providers/auth_providers.dart';
import 'package:manawanui/core/providers/timesheet_providers.dart';
import 'package:manawanui/data/models/get_timesheet_initials_er_response.dart';
import 'package:manawanui/data/models/get_timesheet_response.dart';
import 'package:manawanui/data/models/get_timesheet_transaction_periods_response.dart';
import 'package:manawanui/data/models/get_update_timesheet_response.dart';
import 'package:manawanui/data/models/timesheet_employee_dropdown_response.dart';
import 'package:manawanui/data/models/timesheet_hours_model.dart';
import 'package:manawanui/helpers/extension/context_function.dart';
import 'package:manawanui/helpers/extension/double_functions.dart';
import 'package:manawanui/helpers/extension/string_extensions.dart';
import 'package:manawanui/helpers/extension/widget_ref_functions.dart';
import 'package:manawanui/helpers/resources/api_param_keys.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';
import 'package:manawanui/screens/modals/bottom_sheet_choose_fortnight_modal.dart';
import 'package:manawanui/screens/modals/bottom_sheet_choose_hours_modal.dart';
import 'package:manawanui/screens/modals/bottom_sheet_employee_dropdown_modal.dart';
import 'package:manawanui/screens/modals/bottom_sheet_generic_modal.dart';
import 'package:manawanui/widgets/api_error_widget.dart';
import 'package:manawanui/widgets/custom_app_bar.dart';
import 'package:manawanui/widgets/custom_elevated_button.dart';
import 'package:manawanui/widgets/data_choose_widget.dart';
import 'package:manawanui/widgets/section_title.dart';
import 'package:manawanui/widgets/text_view.dart';

class AddEditTimeSheet extends HookConsumerWidget {
  const AddEditTimeSheet({super.key, this.timesheetItemModel});

  final TimesheetItemModel? timesheetItemModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final argsIndex = ModalRoute.of(context)?.settings.arguments as int;
    final viewModel = ref.watch(timesheetViewModelProvider);
    final userDetails = ref.watch(userDetailsProvider);
    final selectedTimesheetPayeeState =
        ref.watch(selectedTimesheetPayeeProvider.notifier);
    final selectedTimesheetFortnightState =
        ref.watch(selectedTimesheetFortnightProvider.notifier);
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

    useEffect(() {
      viewModel.getTimesheetEmployeeDropdown({
        ApiParamKeys.KEY_USER_ID_SMALL: userDetails?.userId ?? "",
        ApiParamKeys.KEY_EMPLOYER_ID: userDetails?.employerId ?? "",
        ApiParamKeys.KEY_IS_SELF_MANAGED: userDetails?.isSelfManaged ?? false,
      });
    }, []);

    return WillPopScope(
      onWillPop: () async {
        currentPageProviders.clear();
        selectedTimesheetPersonSupportedProvider.clear();
        selectedTimesheetPayComponentProvider.clear();
        //selectedTimesheetSelectedHoursProvider.clear();
        ref.invalidateTimeSheetProviders();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: customAppBar(() {
          currentPageProviders.clear();
          selectedTimesheetPersonSupportedProvider.clear();
          selectedTimesheetPayComponentProvider.clear();
          //selectedTimesheetSelectedHoursProvider.clear();
          ref.invalidateTimeSheetProviders();
          context.pop();
        }, timesheetItemModel == null ? "Add Timesheet" : "Edit Timesheet",
            actions: [
              if (timesheetItemModel != null) const Icon(Icons.delete_outlined),
              const SizedBox(
                width: 8,
              )
            ]),
        body: StreamBuilder<ApiResult<TimesheetEmployeeDropdownResponse>>(
          stream: viewModel.responseGetTimesheetEmployeeDropDownStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                  child: ApiErrorWidget(message: snapshot.error.toString()));
            }
            if (snapshot.hasData) {
              final response = snapshot.data;

              if (response?.error != null) {
                if (response?.error?.contains("401") == true) {
                  logout(ref, context);
                }
                return Center(
                    child: ApiErrorWidget(
                        message: response?.data?.message.toString() ?? ""));
              }

              if (response?.data?.status == true) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        /// Payee Name
                        const SectionTitle(
                          title: "Payee Name",
                          iconData: Icons.help_rounded,
                        ),
                        const SizedBox(
                          height: 8,
                        ),

                        StreamBuilder<EligibalEmployeesModal?>(
                            stream: selectedTimesheetPayeeState.stream,
                            builder: (context, snapshot) {
                              return DataChooseWidget(
                                title: "",
                                value:
                                    selectedTimesheetPayeeState.state?.name ??
                                        "Choose",
                                onPress: () {
                                  BottomSheetEmployeeDropdownModal.show(
                                      context,
                                      "Choose Payee",
                                      response
                                          ?.data?.response?.eligibalEmployees,
                                      null,
                                      userDetails,
                                      (p0) => () async {
                                            ref
                                                .watch(
                                                    selectedTimesheetPayeeProvider
                                                        .notifier)
                                                .state = p0;
                                            context.showProgressDialog();
                                            await viewModel
                                                .getTimesheetTransactionPeriod({
                                              ApiParamKeys.KEY_USER_ID_SMALL:
                                                  userDetails?.userId ?? "",
                                              ApiParamKeys.KEY_EMPLOYER_ID:
                                                  userDetails?.employerId ?? "",
                                              ApiParamKeys.KEY_EMPLOYEE_ID:
                                                  p0?.id ?? "",
                                              ApiParamKeys.KEY_ROLE_CODE:
                                                  userDetails?.roleCode ?? "",
                                            });
                                            if (context.mounted) {
                                              context.pop();
                                              context.pop();
                                            }
                                          });
                                },
                              );
                            }),

                        /// Fortnight Period
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

                        StreamBuilder<
                                ApiResult<
                                    GetTimesheetTransactionPeriodResponse>>(
                            stream: viewModel
                                .responseGetTimesheetTransactionPeriodStream,
                            builder: (context, snapshot) {
                              var data = snapshot.data?.data;
                              return StreamBuilder<TransPeriodModal?>(
                                  stream:
                                      selectedTimesheetFortnightState.stream,
                                  builder: (context, snapshot) {
                                    return DataChooseWidget(
                                      title: "",
                                      value: selectedTimesheetFortnightState
                                              .state?.name ??
                                          "Choose",
                                      onPress: () async {
                                        if (selectedTimesheetPayeeState.state ==
                                            null) {
                                          context.showErrorDialog(
                                              "Please select Payee before Fortnight period selection",
                                              title: "To be noted!");
                                          return;
                                        }
                                        BottomSheetChooseFortnightModal.show(
                                          context,
                                          data?.response?.transPeriod,
                                          userDetails,
                                          ref,
                                        );
                                      },
                                    );
                                  });
                            }),

                        /// Time Sheet
                        TimesheetBlock(scrollToNewItem: scrollToNewItem),

                        /// Expense Sheet
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
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
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  border: Border.all(
                                                    color:
                                                        AppColors.primaryColor,
                                                    // Border color
                                                    width: 0.5, // Border width
                                                  ), // Border radius to make it rounded
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    mExpenseSheetDataListProvider
                                                        .removeItem(snapshot
                                                            .data![index]);
                                                  },
                                                  child: Icon(
                                                    Icons.delete_outlined,
                                                    size: 24,
                                                    color:
                                                        AppColors.primaryColor,
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

                        /// Payments
                        const SizedBox(
                          height: 32,
                        ),
                        SectionTitle(
                          title: "Payments",
                          isAddButton: true,
                          callbackAction: () {
                            mPaymentsSheetDataListProvider.addItem("item");
                            scrollToNewItem(
                                mPaymentsSheetDataListProvider.state.length *
                                    3);
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
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
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  border: Border.all(
                                                    color:
                                                        AppColors.primaryColor,
                                                    // Border color
                                                    width: 0.5, // Border width
                                                  ), // Border radius to make it rounded
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    mPaymentsSheetDataListProvider
                                                        .removeItem(snapshot
                                                            .data![index]);
                                                  },
                                                  child: Icon(
                                                    Icons.delete_outlined,
                                                    size: 24,
                                                    color:
                                                        AppColors.primaryColor,
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

                        /// Save button
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
                );
              }
              return Center(
                  child: ApiErrorWidget(
                      message: response?.data?.message.toString() ?? ""));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class TimesheetBlock extends HookConsumerWidget {
  const TimesheetBlock({super.key, required this.scrollToNewItem});

  final Function(int) scrollToNewItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(timesheetViewModelProvider);
    final userDetails = ref.watch(userDetailsProvider);
    final mTimeSheetDataListProvider =
        ref.watch(timeSheetDataListProvider.notifier);
    final selectedTimesheetPayeeState =
        ref.watch(selectedTimesheetPayeeProvider.notifier);
    final selectedTimesheetFortnightState =
        ref.watch(selectedTimesheetFortnightProvider.notifier);
    GetUpdateTimesheetResponse? updateTimesheetResponse;
    GetTimesheetInitialErResponse? getTimesheetInitialErResponse;

    void addNewTimeSheetItem() {
      List<TimesheetHoursModel> timesheetHoursList = [];

      for (final date in updateTimesheetResponse?.response?.dateList ?? []) {
        TimesheetHoursModel timeSheetHoursModel = TimesheetHoursModel();
        timeSheetHoursModel.date = date;
        timesheetHoursList.add(timeSheetHoursModel);
      }

      mTimeSheetDataListProvider.addItem(TimesheetTimeModel(
          personSupported: "",
          payComponent: "",
          timesheetHoursModel: timesheetHoursList,
          publicHoliday: updateTimesheetResponse?.response?.publicHoliday));
      scrollToNewItem(mTimeSheetDataListProvider.state.length);
    }

    void getTimesheetInitialsEr() async {
      context.showProgressDialog();
      await viewModel.getTimesheetInitialsEr({
        ApiParamKeys.KEY_USER_ID: userDetails?.userId ?? "",
        ApiParamKeys.KEY_EMPLOYER_ID: userDetails?.employerId ?? "",
        ApiParamKeys.KEY_EMPLOYEE_ID_SMALL:
            selectedTimesheetPayeeState.state?.id ?? "",
        ApiParamKeys.KEY_ROLE_CODE: userDetails?.roleCode ?? "",
        ApiParamKeys.KEY_IS_SELF_MANAGED: userDetails?.isSelfManaged ?? false
      });

      if (context.mounted) context.pop();
    }

    useEffect(() {
      final subscription =
          viewModel.responseUpdateTimesheetStream.listen((response) async {
        if (response.data?.status == true) {
          updateTimesheetResponse = response.data;
          getTimesheetInitialsEr();
        }
      });

      return subscription.cancel;
    }, const []);

    useEffect(() {
      final subscription =
          viewModel.responseTimesheetInitialsErStream.listen((response) async {
        if (response.data?.status == true) {
          getTimesheetInitialErResponse = response.data;
          addNewTimeSheetItem();
        }
      });

      return subscription.cancel;
    }, const []);

    return Column(
      children: [
        const SizedBox(
          height: 32,
        ),
        SectionTitle(
          title: "Time Sheet",
          isAddButton: true,
          callbackAction: () async {
            if (selectedTimesheetPayeeState.state == null ||
                selectedTimesheetFortnightState.state == null) {
              context.showErrorDialog(
                  "Choose Payee and than select the fortnight to proceed",
                  title: "To be noted!");
              return;
            }
            if (updateTimesheetResponse == null) {
              context.showProgressDialog();
              await viewModel.updateTimesheet({
                ApiParamKeys.KEY_USER_ID: userDetails?.userId ?? "",
                ApiParamKeys.KEY_USER_ROLE_CAP: userDetails?.roleCode ?? "",
                ApiParamKeys.KEY_TIMESHEET_ID: 0,
                ApiParamKeys.KEY_STATUS_CODE: "N",
                ApiParamKeys.KEY_TRANSACTION_PERIOD_ID:
                    selectedTimesheetFortnightState.state?.id ?? "",
                ApiParamKeys.KEY_EMPLOYER_ID_CAP: userDetails?.employerId ?? "",
                ApiParamKeys.KEY_EMPLOYEE_ID:
                    selectedTimesheetPayeeState.state?.id ?? "",
              });
              if (context.mounted) {
                context.pop();
              }
            } else {
              addNewTimeSheetItem();
            }
          },
        ),
        const SizedBox(
          height: 8,
        ),
        StreamBuilder<List<TimesheetTimeModel>>(
          stream: mTimeSheetDataListProvider.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (mTimeSheetDataListProvider.state.isNotEmpty) {
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
                            timesheetInitialErResponse:
                                getTimesheetInitialErResponse,
                            timesheetTimeModel:
                                mTimeSheetDataListProvider.state[index],
                          ),
                          Positioned(
                              bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: AppColors.primaryColor,
                                    // Border color
                                    width: 0.05, // Border width
                                  ), // Border radius to make it rounded
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    mTimeSheetDataListProvider
                                        .removeItem(snapshot.data![index]);
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
      ],
    );
  }
}

class TimesheetItem extends ConsumerWidget {
  final int index;
  final TimesheetTimeModel? timesheetTimeModel;
  final GetTimesheetInitialErResponse? timesheetInitialErResponse;

  const TimesheetItem(
      {super.key,
      required this.index,
      required this.timesheetTimeModel,
      required this.timesheetInitialErResponse});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timesheetHoursController = TimesheetHoursController(
        timesheetTimeModel!.timesheetHoursModel!.length);
    for (int i = 0; i < timesheetTimeModel!.timesheetHoursModel!.length; i++) {
      currentPageProviders.add(StateProvider<int>((ref) => 0));
      selectedTimesheetPersonSupportedProvider
          .add(StateProvider<EmployeeModel?>((ref) => null));
      selectedTimesheetPayComponentProvider
          .add(StateProvider<PayComponentsModel?>((ref) => null));
      // selectedTimesheetSelectedHoursProvider.
      //     .add(StateProvider<double?>((ref) => null));
    }
    final selectedTimesheetPersonSupportedState =
        ref.watch(selectedTimesheetPersonSupportedProvider[index].notifier);

    final selectedTimesheetPayComponentState =
        ref.watch(selectedTimesheetPayComponentProvider[index].notifier);
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
          width: 0.05, // Border width
        ), // Border radius to make it rounded
      ),
      child: Column(
        children: [
          Row(
            children: [
              StreamBuilder<EmployeeModel?>(
                  stream: selectedTimesheetPersonSupportedState.stream,
                  builder: (context, snapshot) {
                    return Expanded(
                        child: DataChooseWidget(
                      title: "Person Supported",
                      value:
                          selectedTimesheetPersonSupportedState.state?.name ??
                              "Choose",
                      onPress: () {
                        BottomSheetGenericModal.show<EmployeeModel?>(
                          context,
                          "Choose Person Supported",
                          timesheetInitialErResponse?.response?.employee,
                          selectedTimesheetPersonSupportedState.state,
                          (item) => item!.name!,
                          (item) {
                            ref
                                .watch(selectedTimesheetPersonSupportedProvider[
                                        index]
                                    .notifier)
                                .state = item;
                          },
                        );
                      },
                    ));
                  }),
              const SizedBox(
                width: 10,
              ),
              StreamBuilder<PayComponentsModel?>(
                  stream: selectedTimesheetPayComponentState.stream,
                  builder: (context, snapshot) {
                    return Expanded(
                        child: DataChooseWidget(
                      title: "Pay Component",
                      value: selectedTimesheetPayComponentState.state?.name ??
                          "Choose",
                      onPress: () {
                        BottomSheetGenericModal.show<PayComponentsModel?>(
                          context,
                          "Choose Pay Component",
                          timesheetInitialErResponse?.response?.payComponenets,
                          selectedTimesheetPayComponentState.state,
                          (item) => item!.name!,
                          (item) {
                            ref
                                .watch(
                                    selectedTimesheetPayComponentProvider[index]
                                        .notifier)
                                .state = item;
                          },
                        );
                      },
                    ));
                  }),
            ],
          ),

          /// show date view
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
                width: 0.05, // Border width
              ), // Border radius to make it rounded
            ),
            child: Stack(
              children: [
                PageView.builder(
                  controller: pageController,
                  onPageChanged: (int page) {
                    currentPage.state = page;
                  },
                  itemCount: timesheetTimeModel?.timesheetHoursModel?.length,
                  itemBuilder: (context, index) {
                    return DateViewWidget(
                      item: timesheetTimeModel?.timesheetHoursModel?[index],
                      timesheetTimeModel: timesheetTimeModel,
                      index: index,
                      hoursController: timesheetHoursController,
                    );
                  },
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: GestureDetector(
                        onTap: () {
                          if (currentPage.state <
                              timesheetTimeModel!.timesheetHoursModel!.length) {
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
                          if (currentPage.state >= 1) {
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
          width: 0.05, // Border width
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

          /// show date view
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
          width: 0.05, // Border width
        ), // Border radius to make it rounded
      ),
      child: const Column(
        children: [
          DataChooseWidget(
            title: "Person Supported",
          ),

          /// show date view
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
  final TimesheetHoursModel? item;
  final int index;
  final TimesheetTimeModel? timesheetTimeModel;
  final TimesheetHoursController hoursController;

  const DateViewWidget(
      {super.key,
      required this.item,
      required this.timesheetTimeModel,
      required this.index,
      required this.hoursController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isPublicHoliday = timesheetTimeModel?.publicHoliday?.any(
          (publicHolidayDate) => publicHolidayDate.date == item?.date,
        ) ??
        false;

    final selectedTimesheetSelectedHoursState = ref.watch(hoursController
        .selectedTimesheetSelectedHoursProviders[index].notifier);
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
            const TextView(
                text: "Date",
                textColor: Colors.black,
                textFontWeight: FontWeight.bold,
                fontSize: 14),
            const SizedBox(
              height: 8,
            ),
            TextView(
                text:
                    item?.date?.convertStringDDMMYYYHHMMSSDateToEMMMDDYYYY() ??
                        "",
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
            StreamBuilder<double?>(
                stream: selectedTimesheetSelectedHoursState.stream,
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.black, // Border color
                            width: 0.05, // Border width
                          ), // Border radius to make it rounded
                        ),
                        child: GestureDetector(
                          onTap: () {
                            BottomSheetChooseHoursModal.show(
                                context,
                                (p0) => () {
                                      console("message -> $p0");
                                      ref
                                          .watch(hoursController
                                              .selectedTimesheetSelectedHoursProviders[
                                                  index]
                                              .notifier)
                                          .state = p0;
                                    },
                                selectedTimesheetSelectedHoursState.state ??
                                    1.0,
                                ref,
                                index,
                                hoursController);
                          },
                          child: TextView(
                              text:
                                  "${selectedTimesheetSelectedHoursState.state?.convertToTwoDecimal() ?? item?.hours ?? "00.00"}",
                              textColor: isPublicHoliday
                                  ? Colors.black
                                  : AppColors.primaryColor,
                              textFontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ),
                    ],
                  );
                }),
          ],
        ),
      ],
    );
  }
}

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
          width: 0.05, // Border width
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
