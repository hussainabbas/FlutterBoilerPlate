import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/core/providers/auth_providers.dart';
import 'package:manawanui/core/providers/budgeting_providers.dart';
import 'package:manawanui/core/providers/common_providers.dart';
import 'package:manawanui/core/providers/dashboard_providers.dart';
import 'package:manawanui/data/models/get_budget_allocation_response.dart';
import 'package:manawanui/data/models/get_budget_new_response.dart';
import 'package:manawanui/data/models/get_employee_payee_initials_response.dart';
import 'package:manawanui/helpers/extension/context_function.dart';
import 'package:manawanui/helpers/extension/double_functions.dart';
import 'package:manawanui/helpers/extension/string_extensions.dart';
import 'package:manawanui/helpers/resources/api_param_keys.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';
import 'package:manawanui/screens/modals/bottom_sheet_choose_general_modal.dart';
import 'package:manawanui/widgets/api_error_widget.dart';
import 'package:manawanui/widgets/fixed_width_column.dart';
import 'package:manawanui/widgets/section_body.dart';
import 'package:manawanui/widgets/section_title.dart';
import 'package:manawanui/widgets/text_view.dart';

class BudgetingMenuScreen extends HookConsumerWidget {
  const BudgetingMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(budgetingViewModelProvider);
    final dashboardViewModel = ref.watch(dashboardViewModelProvider);
    final userDetails = ref.watch(userDetailsProvider);
    final currencySymbol = ref.watch(currencySymbolProvider);
    final apiClient = ref.watch(apiClientProvider).value;
    late GenericIdValueModel? selectedCategorySupportPlanItem;
    late GenericIdValueModel? selectedFunderStartDateModel;
    late GenericIdValueModel? selectedClientIdModel;

    void getBudgetingNew() async {
      var body = {
        ApiParamKeys.KEY_USER_ID_SMALL: userDetails?.userId ?? "",
        ApiParamKeys.KEY_EMPLOYER_ID: userDetails?.employerId ?? "",
      };
      await viewModel.getBudgetingNew(body);
    }

    void getBudgetAllocation(String supportPlanId) async {
      var bodyBudgetAllocation = {
        ApiParamKeys.KEY_USER_ID_SMALL: userDetails?.userId ?? "",
        ApiParamKeys.KEY_EMPLOYER_ID: userDetails?.employerId ?? "",
        ApiParamKeys.KEY_IS_SELF_MANAGED: userDetails?.isSelfManaged ?? "",
        ApiParamKeys.KEY_SUPPORT_PLAN_ID: supportPlanId,
      };
      await viewModel.getBudgetAllocation(bodyBudgetAllocation);
    }

    useEffect(() {
      setGlobalHeaders(userDetails, apiClient);
      getBudgetingNew();
      return null;
    }, []);

    useEffect(() {
      final subscription = dashboardViewModel
          .responseGetEmployerClientListStream
          .listen((response) async {
        if (response.data?.status == true) {
          BottomSheetChooseGeneralModal.show(
              context,
              "Choose Client Name",
              response.data?.response,
              selectedClientIdModel,
              userDetails, (value) async {
            if (context.mounted) context.showProgressDialog();
            await viewModel.getBudgetingNew({
              ApiParamKeys.KEY_USER_ID_SMALL: userDetails?.userId ?? "",
              ApiParamKeys.KEY_EMPLOYER_ID: userDetails?.employerId ?? "",
              ApiParamKeys.KEY_CLIENT_ID: value?.id ?? ""
            });
            if (context.mounted) {
              context.pop();
            }
          });
        } else {
          context
              .showErrorDialog(response.data?.message ?? response.error ?? "");
        }
      });

      return subscription.cancel;
    }, const []);

    useEffect(() {
      final subscription = dashboardViewModel
          .responseGetCategorySupportPlanListStream
          .listen((response) async {
        if (response.data?.status == true) {
          BottomSheetChooseGeneralModal.show(
              context,
              "Choose Funder Name",
              response.data?.response,
              selectedCategorySupportPlanItem,
              userDetails, (value) async {
            if (context.mounted) context.showProgressDialog();
            await viewModel.getBudgetingNew({
              ApiParamKeys.KEY_USER_ID_SMALL: userDetails?.userId ?? "",
              ApiParamKeys.KEY_EMPLOYER_ID: userDetails?.employerId ?? "",
              ApiParamKeys.KEY_SUPPORT_PLAN_ID: value?.id ?? ""
            });
            if (context.mounted) {
              context.pop();
            }
          });
        } else {
          context
              .showErrorDialog(response.data?.message ?? response.error ?? "");
        }
      });

      return subscription.cancel;
    }, const []);

    useEffect(() {
      final subscription = dashboardViewModel
          .responseGetFundingSupportPlanStartDateListStream
          .listen((response) async {
        if (response.data?.status == true) {
          BottomSheetChooseGeneralModal.show(
              context,
              "Choose Funder Name",
              response.data?.response,
              selectedFunderStartDateModel,
              userDetails, (value) async {
            if (context.mounted) context.showProgressDialog();
            await viewModel.getBudgetingNew({
              ApiParamKeys.KEY_USER_ID_SMALL: userDetails?.userId ?? "",
              ApiParamKeys.KEY_EMPLOYER_ID: userDetails?.employerId ?? "",
              ApiParamKeys.KEY_SUPPORT_PLAN_ID: value?.id ?? ""
            });
            if (context.mounted) {
              context.pop();
            }
          });
        } else {
          context
              .showErrorDialog(response.data?.message ?? response.error ?? "");
        }
      });

      return subscription.cancel;
    }, const []);

    return StreamBuilder<ApiResult<GetBudgetNewResponse>>(
      stream: viewModel.responseGetBudgetingNewStream,
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
          final data = response?.data;
          getBudgetAllocation(
              data?.response?.supportPlan?.supportPlanId?.toString() ?? "");
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
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    //CLIENT
                    const SectionTitle(title: "Client"),
                    const SizedBox(
                      height: 16,
                    ),
                    SectionBody(
                      leadingIcon: Icons.person_pin,
                      title: "Client Name",
                      trailingIcon: Icons.navigate_next_rounded,
                      value: data?.response?.client?.name ?? "",
                      callbackAction: () async {
                        selectedClientIdModel = data?.response?.client;
                        if (context.mounted) {
                          context.showProgressDialog();
                        }
                        await dashboardViewModel.getEmployerClientList({
                          ApiParamKeys.KEY_USER_ID_SMALL:
                              userDetails?.userId ?? "",
                          ApiParamKeys.KEY_EMPLOYER_ID:
                              userDetails?.employerId ?? "",
                          ApiParamKeys.KEY_SUPPORT_PLAN_ID:
                              data?.response?.supportPlan?.supportPlanId ?? "",
                        });
                        if (context.mounted) {
                          context.pop();
                        }
                      },
                    ),
                    //FUNDER
                    const SizedBox(
                      height: 32,
                    ),
                    const SectionTitle(title: "Funder"),
                    const SizedBox(
                      height: 16,
                    ),
                    SectionBody(
                      leadingIcon: Icons.help_rounded,
                      title: "Funder Name",
                      value: data?.response?.funder?.name ?? "",
                      trailingIcon: Icons.navigate_next_rounded,
                      callbackAction: () async {
                        selectedCategorySupportPlanItem =
                            data?.response?.funder;
                        if (context.mounted) {
                          context.showProgressDialog();
                        }
                        await dashboardViewModel.getCategorySupportPlanList({
                          ApiParamKeys.KEY_USER_ID_SMALL:
                              userDetails?.userId ?? "",
                          ApiParamKeys.KEY_EMPLOYER_ID:
                              userDetails?.employerId ?? "",
                          ApiParamKeys.KEY_SUPPORT_PLAN_ID:
                              data?.response?.supportPlan?.supportPlanId ?? "",
                          ApiParamKeys.KEY_CLIENT_REPORT_ID:
                              data?.response?.clientReportId ?? "",
                          ApiParamKeys.KEY_CLIENT_ID:
                              data?.response?.client?.id ?? "",
                        });
                        if (context.mounted) {
                          context.pop();
                        }
                      },
                    ),
                    //Funding & Review Date
                    const SizedBox(
                      height: 32,
                    ),
                    const SectionTitle(title: "Funding & Review Date"),
                    const SizedBox(
                      height: 16,
                    ),
                    SectionBody(
                        leadingIcon: Icons.umbrella_rounded,
                        title: "Funding Start",
                        trailingIcon: Icons.navigate_next_rounded,
                        callbackAction: () async {
                          selectedFunderStartDateModel =
                              data?.response?.funderStartDate;
                          if (context.mounted) {
                            context.showProgressDialog();
                          }
                          await dashboardViewModel
                              .getFundingSupportPlanStartDate({
                            ApiParamKeys.KEY_USER_ID_SMALL:
                                userDetails?.userId ?? "",
                            ApiParamKeys.KEY_EMPLOYER_ID:
                                userDetails?.employerId ?? "",
                            ApiParamKeys.KEY_SUPPORT_PLAN_ID:
                                data?.response?.supportPlan?.supportPlanId ??
                                    "",
                          });
                          if (context.mounted) {
                            context.pop();
                          }
                        },
                        value: data?.response?.supportPlan?.startDate
                                ?.convertStringDateToMMMDDYYY() ??
                            ""),
                    const SizedBox(
                      height: 8,
                    ),
                    SectionBody(
                      leadingIcon: Icons.calendar_month,
                      title: "NASC Review Date",
                      value: data?.response?.supportPlan?.endDate
                              ?.convertStringDateToMMMDDYYY() ??
                          "",
                      trailingIcon: Icons.help_rounded,
                    ),

                    //Funding Information
                    const SizedBox(
                      height: 32,
                    ),
                    const SectionTitle(
                      title: "Funding Information",
                      iconData: Icons.help_rounded,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SectionBody(
                              leadingIcon: Icons.umbrella_rounded,
                              title: "Total Funds by NASC",
                              trailingIcon: Icons.navigate_next_rounded,
                              value:
                                  "$currencySymbol${data?.response?.supportPlan?.totalBudget?.convertToAmount()}"),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          flex: 1,
                          child: SectionBody(
                              leadingIcon: Icons.alarm_rounded,
                              title: "Spend to\ndate",
                              trailingIcon: Icons.navigate_next_rounded,
                              value:
                                  "$currencySymbol${data?.response?.currentSpend?.convertToAmount()}"),
                        ),
                      ],
                    ),

                    //Your Payees
                    const SizedBox(
                      height: 32,
                    ),
                    const SectionTitle(
                      title: "Your Payees",
                      iconData: Icons.help_rounded,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    data?.response?.budgetEmployees?.isNotEmpty == true
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data?.response?.budgetEmployees?.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FixedWidthColumn(
                                        text: 'Start Date',
                                        multiplier: 0.2,
                                        isShowing: true,
                                      ),
                                      FixedWidthColumn(
                                        text: 'Expense',
                                        multiplier: 0.2,
                                      ),
                                      FixedWidthColumn(
                                        text: 'Frequency',
                                        multiplier: 0.3,
                                      ),
                                      FixedWidthColumn(
                                        text: 'Amount',
                                        multiplier: 0.2,
                                      ),
                                    ],
                                  ),
                                  YourPayeesItem(
                                    item:
                                        data?.response?.budgetEmployees?[index],
                                    currencySymbol: currencySymbol,
                                  ),
                                ],
                              );
                            })
                        : const NoRecordFoundWidget(title: "Payees"),
                    //Your Expenses
                    const SizedBox(
                      height: 32,
                    ),
                    const SectionTitle(
                      title: "Your Expenses",
                      iconData: Icons.help_rounded,
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    data?.response?.budgetExpenses?.isNotEmpty == true
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data?.response?.budgetExpenses?.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FixedWidthColumn(
                                        text: 'Start Date',
                                        multiplier: 0.2,
                                        isShowing: true,
                                      ),
                                      FixedWidthColumn(
                                        text: 'Expense',
                                        multiplier: 0.2,
                                      ),
                                      FixedWidthColumn(
                                        text: 'Frequency',
                                        multiplier: 0.3,
                                      ),
                                      FixedWidthColumn(
                                        text: 'Amount',
                                        multiplier: 0.2,
                                      ),
                                    ],
                                  ),
                                  YourExpenseItem(
                                    item:
                                        data?.response?.budgetExpenses?[index],
                                    currencySymbol: currencySymbol,
                                  ),
                                ],
                              );
                            })
                        : const NoRecordFoundWidget(title: "Expense"),
                    //Allocation
                    const SizedBox(
                      height: 32,
                    ),
                    const SectionTitle(
                      title: "Allocation",
                      iconData: Icons.help_rounded,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    StreamBuilder<ApiResult<GetBudgetAllocationResponse>>(
                      stream: viewModel.responseGetBudgetingAllocationStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: ApiErrorWidget(
                                  message: snapshot.error.toString()));
                        }
                        if (snapshot.hasData) {
                          var allocationData = snapshot.data?.data;
                          return Column(
                            children: [
                              SectionBody(
                                  leadingIcon: Icons.calendar_month,
                                  title: "Budget Allocation",
                                  value: allocationData
                                          ?.response?.allocatedBudget ??
                                      ""),
                              const SizedBox(
                                height: 8,
                              ),
                              SectionBody(
                                  leadingIcon: Icons.calendar_month,
                                  title: "Accumulative Funding",
                                  value:
                                      allocationData?.response?.fundRemaining ??
                                          ""),
                            ],
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
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
    );
  }
}

class NoRecordFoundWidget extends StatelessWidget {
  const NoRecordFoundWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.fullWidth(),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 0.05),
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Icon(
            Icons.browser_not_supported,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 16,
          ),
          TextView(
              text: "No Record Found",
              textColor: AppColors.primaryColor,
              textFontWeight: FontWeight.normal,
              fontSize: 16),
          const SizedBox(
            height: 16,
          ),
          TextView(
              text: "Could not find any record against your $title",
              textColor: Colors.grey,
              textFontWeight: FontWeight.normal,
              fontSize: 14),
        ],
      ),
    );
  }
}

class YourPayeesItem extends StatelessWidget {
  const YourPayeesItem(
      {super.key, required this.item, required this.currencySymbol});

  final BudgetEmployeesModel? item;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 15),
      margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(
            width: 4.0, // Set the width of the left border
            color: Colors.grey, // Set the color of the border
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FixedWidthColumn(
            text:
                '${item?.startDate?.convertStringDateToMMM() ?? ""}\n${item?.startDate?.convertStringDateToDD() ?? ""}\n${item?.startDate?.convertStringDateToYYYY() ?? ""}',
            multiplier: 0.2,
          ),
          FixedWidthColumn(
            text: item?.employeeName ?? "",
            multiplier: 0.2,
          ),
          FixedWidthColumn(
            text: item?.frequencyDisplay ?? "",
            multiplier: 0.3,
          ),
          FixedWidthColumn(
            text:
                "$currencySymbol${item?.inclusiveAmountForPeriod?.convertToAmount()}",
            multiplier: 0.2,
          ),
        ],
      ),
    );
  }
}

class YourExpenseItem extends StatelessWidget {
  const YourExpenseItem(
      {super.key, required this.item, required this.currencySymbol});

  final BudgetExpensesModel? item;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 15),
      margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(
            width: 4.0, // Set the width of the left border
            color: Colors.grey, // Set the color of the border
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FixedWidthColumn(
            text:
                '${item?.startDate?.convertStringDateToMMM() ?? ""}\n${item?.startDate?.convertStringDateToDD() ?? ""}\n${item?.startDate?.convertStringDateToYYYY() ?? ""}',
            multiplier: 0.2,
          ),
          FixedWidthColumn(
            text: item?.employeeName ?? "",
            multiplier: 0.2,
          ),
          FixedWidthColumn(
            text: item?.frequencyDisplay ?? "",
            multiplier: 0.3,
          ),
          FixedWidthColumn(
            text: "$currencySymbol${item?.amount?.convertToAmount()}",
            multiplier: 0.2,
          ),
        ],
      ),
    );
  }
}

/*
class YourPayeesItem2 extends StatelessWidget {
  const YourPayeesItem2(
      {super.key, required this.item, required this.currencySymbol});

  final BudgetEmployeesModel? item;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(
            width: 4.0, // Set the width of the left border
            color: Colors.grey, // Set the color of the border
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              TextView(
                  text: item?.startDate?.convertStringDateToMMM() ?? "",
                  textColor: Colors.black,
                  textFontWeight: FontWeight.normal,
                  fontSize: 12),
              const SizedBox(
                height: 4,
              ),
              TextView(
                  text: item?.startDate?.convertStringDateToDD() ?? "",
                  textColor: Colors.black,
                  textFontWeight: FontWeight.bold,
                  fontSize: 14),
              const SizedBox(
                height: 4,
              ),
              TextView(
                  text: item?.startDate?.convertStringDateToYYYY() ?? "",
                  textColor: Colors.black,
                  textFontWeight: FontWeight.normal,
                  fontSize: 12),
            ],
          ),
          Expanded(
              child: TextView(
                text: item?.employeeName ?? "",
                textColor: Colors.black,
                textFontWeight: FontWeight.normal,
                fontSize: 16,
                align: TextAlign.center,
              )),
          Expanded(
              child: TextView(
                text: item?.frequencyDisplay ?? "",
                textColor: Colors.black,
                textFontWeight: FontWeight.normal,
                fontSize: 16,
                align: TextAlign.center,
              )),
          Expanded(
              child: TextView(
                text:
                "$currencySymbol${item?.inclusiveAmountForPeriod?.convertToAmount()}",
                textColor: Colors.black,
                textFontWeight: FontWeight.normal,
                fontSize: 16,
                align: TextAlign.center,
              )),
        ],
      ),
    );
  }
}*/
