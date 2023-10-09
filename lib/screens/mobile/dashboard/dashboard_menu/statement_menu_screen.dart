import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/core/providers/auth_providers.dart';
import 'package:manawanui/core/providers/common_providers.dart';
import 'package:manawanui/core/providers/dashboard_providers.dart';
import 'package:manawanui/data/models/funder_model.dart';
import 'package:manawanui/data/models/funder_start_date_model.dart';
import 'package:manawanui/data/models/get_statement_new_response.dart';
import 'package:manawanui/data/models/statement_model.dart';
import 'package:manawanui/helpers/extension/context_function.dart';
import 'package:manawanui/helpers/extension/date_time_functions.dart';
import 'package:manawanui/helpers/extension/string_extensions.dart';
import 'package:manawanui/helpers/resources/api_param_keys.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';
import 'package:manawanui/screens/modals/bottom_sheet_choose_funder_name_modal.dart';
import 'package:manawanui/screens/modals/bottom_sheet_choose_funder_start_date_modal.dart';
import 'package:manawanui/widgets/api_error_widget.dart';
import 'package:manawanui/widgets/overview_widget.dart';
import 'package:manawanui/widgets/section_body.dart';
import 'package:manawanui/widgets/section_simple_body.dart';
import 'package:manawanui/widgets/section_title.dart';
import 'package:manawanui/widgets/text_view.dart';

class StatementMenuScreen extends HookConsumerWidget {
  const StatementMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(dashboardViewModelProvider);
    final userDetails = ref.watch(userDetailsProvider);
    final currencySymbol = ref.watch(currencySymbolProvider);
    final apiClient = ref.watch(apiClientProvider).value;
    late FunderModel? selectedCategorySupportPlanItem;
    late FunderStartDateModel? selectedFunderStartDateModel;

    useEffect(() {
      setGlobalHeaders(userDetails, apiClient);
      viewModel.getStatementNew({
        ApiParamKeys.KEY_USER_ID_SMALL: userDetails?.userId ?? "",
        ApiParamKeys.KEY_EMPLOYER_ID: userDetails?.employerId ?? "",
        ApiParamKeys.KEY_IS_SELF_MANAGED: userDetails?.isSelfManaged ?? false,
      });
      return null;
    }, []);

    useEffect(() {
      final subscription = viewModel.responseGetCategorySupportPlanListStream
          .listen((response) async {
        if (response.data?.status == true) {
          BottomSheetChooseFunderNameModal.show(
              context,
              response.data?.response,
              selectedCategorySupportPlanItem!,
              viewModel,
              userDetails);
        } else {
          context
              .showErrorDialog(response.data?.message ?? response.error ?? "");
        }
      });

      return subscription.cancel;
    }, const []);

    useEffect(() {
      final subscription = viewModel
          .responseGetFundingSupportPlanStartDateListStream
          .listen((response) async {
        if (response.data?.status == true) {
          BottomSheetChooseFunderStartDateModal.show(
              context,
              response.data?.response,
              selectedFunderStartDateModel!,
              viewModel,
              userDetails);
        } else {
          context
              .showErrorDialog(response.data?.message ?? response.error ?? "");
        }
      });

      return subscription.cancel;
    }, const []);

    Future<void> selectStatementDatePicker(
        BuildContext context,
        String selectedDateString,
        StatementResponseModel? statementResponseModel) async {
      DateTime selectedDate = DateTime.parse(selectedDateString);
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: AppColors.primaryColor,
              // Adjust the accent color as needed.
              colorScheme: ColorScheme.light(primary: AppColors.primaryColor),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child ??
                const SizedBox
                    .shrink(), // Add a fallback child if child is null.
          );
        },
      );

      if (picked != null && picked != selectedDate) {
        if (context.mounted) context.showProgressDialog();
        await viewModel.getStatementNew({
          ApiParamKeys.KEY_USER_ID_SMALL: userDetails?.userId ?? "",
          ApiParamKeys.KEY_EMPLOYER_ID: userDetails?.employerId ?? "",
          ApiParamKeys.KEY_SUPPORT_PLAN_ID:
              statementResponseModel?.supportPlanId ?? "",
          ApiParamKeys.KEY_CLIENT_REPORT_ID:
              statementResponseModel?.clientReportId ?? "",
          ApiParamKeys.KEY_STATEMENT_DATE:
              picked.convertDateToYYYYMMDDTHHMMSS(),
        });
        if (context.mounted) {
          // Navigator.pop(context);
          context.pop();
        }
      }
    }

    return StreamBuilder<ApiResult<GetStatementNewResponse>>(
      stream: viewModel.responseGetStatementNewStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: ApiErrorWidget(message: snapshot.error.toString()));
        } else if (snapshot.hasData) {
          final response = snapshot.data;
          final data = response?.data;

          if (response?.error != null) {
            if (response?.error?.contains("401") == true) {
              logout(ref, context);
            }

            return Center(
                child:
                    ApiErrorWidget(message: response?.error.toString() ?? ""));
          } else {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    //CLIENT
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SectionTitle(title: "Client"),
                        Container(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            // Height of the rounded container
                            decoration: BoxDecoration(
                              color: Colors.white,
                              // Background color of the container
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(
                                color: Colors.black, // Border color
                                width: 0.05, // Border width
                              ), // Border radius to make it rounded
                            ),
                            child: Column(
                              children: [
                                TextView(
                                    text: "Acct. Number",
                                    textColor: AppColors.primaryColor,
                                    textFontWeight: FontWeight.bold,
                                    fontSize: 14),
                                const SizedBox(
                                  height: 4,
                                ),
                                TextView(
                                    text: data?.response?.dynamicsStatement
                                            ?.generalInfo?.accountNumber ??
                                        "",
                                    textColor: AppColors.primaryColor,
                                    textFontWeight: FontWeight.normal,
                                    fontSize: 12)
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SectionBody(
                        leadingIcon: Icons.person_pin,
                        title: "Client Name",
                        value: data?.response?.client?.name ?? ""),
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
                        console(
                            "BottomSheetChooseFunderNameModal -> ${selectedCategorySupportPlanItem?.id}");
                        if (context.mounted) {
                          context.showProgressDialog();
                        }
                        await viewModel.getCategorySupportPlanList({
                          ApiParamKeys.KEY_USER_ID_SMALL:
                              userDetails?.userId ?? "",
                          ApiParamKeys.KEY_EMPLOYER_ID:
                              userDetails?.employerId ?? "",
                          ApiParamKeys.KEY_SUPPORT_PLAN_ID:
                              data?.response?.supportPlanId ?? "",
                          ApiParamKeys.KEY_CLIENT_REPORT_ID:
                              data?.response?.clientReportId ?? "",
                          ApiParamKeys.KEY_CLIENT_ID:
                              data?.response?.client?.id ?? "",
                        });
                        if (context.mounted) {
                          // Navigator.pop(context);
                          context.pop();
                        }
                        //BottomSheetChooseFunderModal.show(context);
                      },
                    ),
                    //FUNDING AND STATEMENT
                    const SizedBox(
                      height: 32,
                    ),
                    const SectionTitle(title: "Funding & Statement"),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SectionBody(
                              leadingIcon: Icons.umbrella_rounded,
                              title: "Funding Start",
                              trailingIcon: Icons.navigate_next_rounded,
                              callbackAction: () async {
                                selectedFunderStartDateModel =
                                    data?.response?.funderStartDate;
                                console(
                                    "selectedFunderStartDateModel -> ${selectedFunderStartDateModel?.id}");
                                if (context.mounted) {
                                  context.showProgressDialog();
                                }
                                await viewModel.getFundingSupportPlanStartDate({
                                  ApiParamKeys.KEY_USER_ID_SMALL:
                                      userDetails?.userId ?? "",
                                  ApiParamKeys.KEY_EMPLOYER_ID:
                                      userDetails?.employerId ?? "",
                                  ApiParamKeys.KEY_SUPPORT_PLAN_ID:
                                      data?.response?.supportPlanId ?? "",
                                });
                                if (context.mounted) {
                                  // Navigator.pop(context);
                                  context.pop();
                                }
                                //BottomSheetChooseFunderModal.show(context);
                              },
                              value: data?.response?.funderStartDate?.name
                                      ?.convertStringDateToMMMDDYYY() ??
                                  ""),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          flex: 1,
                          child: SectionBody(
                              leadingIcon: Icons.alarm_rounded,
                              title: "Statement Date",
                              trailingIcon: Icons.navigate_next_rounded,
                              callbackAction: () {
                                selectStatementDatePicker(
                                    context,
                                    data?.response?.statementDate ?? "",
                                    data?.response);
                              },
                              value: data?.response?.statementDate
                                      ?.convertStringDateToMMMDDYYY() ??
                                  ""),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SectionBody(
                      leadingIcon: Icons.calendar_month,
                      title: "NASC Review Date",
                      value: data?.response?.nASCReviewDate
                              ?.convertStringDateToMMMDDYYY() ??
                          "",
                      trailingIcon: Icons.help_rounded,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SectionBody(
                      leadingIcon: Icons.calendar_month,
                      title: "Funding Period",
                      value:
                          "${data?.response?.dynamicsStatement?.generalInfo?.fundingStartDate ?? ""} to ${data?.response?.dynamicsStatement?.generalInfo?.fundingEndDate ?? ""}",
                      trailingIcon: Icons.help_rounded,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SectionBody(
                      leadingIcon: Icons.calendar_month,
                      title: "Total Funds Allocated",
                      value:
                          "$currencySymbol${data?.response?.dynamicsStatement?.generalInfo?.allocation?.formatAmountNumber()}",
                      trailingIcon: Icons.help_rounded,
                    ),

                    const SizedBox(
                      height: 8,
                    ),
                    SectionBody(
                      leadingIcon: Icons.calendar_month,
                      title:
                          "Funding Remaining at ${data?.response?.dynamicsStatement?.generalInfo?.statementDate?.convertStringDDMMYYYYToMMMDDYYY()}",
                      value:
                          "$currencySymbol${data?.response?.dynamicsStatement?.generalInfo?.remainingFunding?.formatAmountNumber()}",
                      backgroundColor: AppColors.primaryColor,
                      trailingIcon: Icons.help_rounded,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SectionBody(
                      leadingIcon: Icons.calendar_month,
                      title: "Total Expenditure",
                      value:
                          "$currencySymbol${data?.response?.dynamicsStatement?.generalInfo?.expenditure?.formatAmountNumber()}",
                      trailingIcon: Icons.help_rounded,
                    ),

                    //Funding Period Expenses
                    const SizedBox(
                      height: 32,
                    ),
                    const SectionTitle(
                      title: "Funding Period Expenses",
                      iconData: Icons.help_rounded,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SectionSimpleBody(
                        title: "Payments",
                        value:
                            "$currencySymbol${data?.response?.dynamicsStatement?.generalInfo?.paymentsTotal?.formatAmountNumber()}"),
                    const SizedBox(
                      height: 4,
                    ),
                    SectionSimpleBody(
                        title: "MIC Service Charges",
                        value:
                            "$currencySymbol${data?.response?.dynamicsStatement?.generalInfo?.micTotal?.formatAmountNumber()}"),

                    //Funding Period Accruals
                    const SizedBox(
                      height: 32,
                    ),
                    const SectionTitle(
                      title: "Funding Period Accruals",
                      iconData: Icons.help_rounded,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SectionSimpleBody(
                        title: "ACC Accrual",
                        value:
                            "$currencySymbol${data?.response?.dynamicsStatement?.generalInfo?.accTotal?.formatAmountNumber()}"),
                    const SizedBox(
                      height: 4,
                    ),
                    SectionSimpleBody(
                        title: "Holiday & Alt Hol Pay Accrual",
                        value:
                            "$currencySymbol${data?.response?.dynamicsStatement?.generalInfo?.holidayAccrualTotal?.formatAmountNumber()}"),

                    //Total Holiday Accruals
                    const SizedBox(
                      height: 32,
                    ),
                    const SectionTitle(
                      title: "Total Holiday Accruals",
                      iconData: Icons.help_rounded,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SectionSimpleBody(
                        title:
                            "Holiday & ALt Hol Pay Accrued in previous period(s)",
                        value:
                            "$currencySymbol${data?.response?.dynamicsStatement?.generalInfo?.pastHolidayAccrualsTotal?.formatAmountNumber()}"),
                    const SizedBox(
                      height: 4,
                    ),
                    SectionSimpleBody(
                        title:
                            "Total Holiday & Alt Hol Pay Accrued in previous period(s)",
                        value:
                            "$currencySymbol${data?.response?.dynamicsStatement?.generalInfo?.totalHolidayAccruals?.formatAmountNumber()}"),
                    //Overview
                    const SizedBox(
                      height: 32,
                    ),
                    const SectionTitle(
                      title: "Overview",
                      iconData: Icons.help_rounded,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    OverviewWidget(
                      statementNewResponse: data,
                    )
                  ],
                ),
              ),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
