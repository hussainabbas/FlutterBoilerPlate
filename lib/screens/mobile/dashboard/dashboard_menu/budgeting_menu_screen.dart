import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/core/providers/auth_providers.dart';
import 'package:manawanui/core/providers/budgeting_providers.dart';
import 'package:manawanui/core/providers/common_providers.dart';
import 'package:manawanui/data/models/funder_model.dart';
import 'package:manawanui/data/models/funder_start_date_model.dart';
import 'package:manawanui/data/models/get_budget_new_response.dart';
import 'package:manawanui/helpers/resources/api_param_keys.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';
import 'package:manawanui/widgets/api_error_widget.dart';
import 'package:manawanui/widgets/section_body.dart';
import 'package:manawanui/widgets/section_title.dart';
import 'package:manawanui/widgets/text_view.dart';

class BudgetingMenuScreen extends HookConsumerWidget {
  const BudgetingMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(budgetingViewModelProvider);
    final userDetails = ref.watch(userDetailsProvider);
    final currencySymbol = ref.watch(currencySymbolProvider);
    final apiClient = ref.watch(apiClientProvider).value;
    late FunderModel? selectedCategorySupportPlanItem;
    late FunderStartDateModel? selectedFunderStartDateModel;

    useEffect(() {
      setGlobalHeaders(userDetails, apiClient);
      viewModel.getBudgetingNew({
        ApiParamKeys.KEY_USER_ID_SMALL: userDetails?.userId ?? "",
        ApiParamKeys.KEY_EMPLOYER_ID: userDetails?.employerId ?? "",
      });
      return null;
    }, []);

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
                    const SectionBody(
                        leadingIcon: Icons.person_pin,
                        title: "Client Name",
                        value: "Porter TestBradley1"),
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
                      value: "Covid Leave",
                      trailingIcon: Icons.navigate_next_rounded,
                      callbackAction: () {
                        console("message");
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
                    const SectionBody(
                        leadingIcon: Icons.umbrella_rounded,
                        title: "Funding Start",
                        trailingIcon: Icons.navigate_next_rounded,
                        value: "Aug 17, 2021"),
                    const SizedBox(
                      height: 8,
                    ),
                    const SectionBody(
                      leadingIcon: Icons.calendar_month,
                      title: "NASC Review Date",
                      value: "Sep 07, 2021",
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
                    const Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SectionBody(
                              leadingIcon: Icons.umbrella_rounded,
                              title: "Total Funds by NASC",
                              trailingIcon: Icons.navigate_next_rounded,
                              value: "\$1,202.00"),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          flex: 1,
                          child: SectionBody(
                              leadingIcon: Icons.alarm_rounded,
                              title: "Spend to\ndate",
                              trailingIcon: Icons.navigate_next_rounded,
                              value: "\$1,202.00"),
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
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return const YourExpensePayeesItem();
                        }),
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
                    const YourExpensePayeesItem(),
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
                    const SectionBody(
                      leadingIcon: Icons.calendar_month,
                      title: "Budget Allocation",
                      value:
                          "Your Budget is over the allocation by \$36,766.90",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const SectionBody(
                      leadingIcon: Icons.calendar_month,
                      title: "Accumulative Funding",
                      value:
                          "Accumulative Funding Amount Remaining \n-\$36,766.90",
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

class YourExpensePayeesItem extends StatelessWidget {
  const YourExpensePayeesItem({super.key});

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
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              TextView(
                  text: "JAN",
                  textColor: Colors.black,
                  textFontWeight: FontWeight.normal,
                  fontSize: 12),
              SizedBox(
                height: 4,
              ),
              TextView(
                  text: "01",
                  textColor: Colors.black,
                  textFontWeight: FontWeight.bold,
                  fontSize: 14),
              SizedBox(
                height: 4,
              ),
              TextView(
                  text: "2022",
                  textColor: Colors.black,
                  textFontWeight: FontWeight.normal,
                  fontSize: 12),
            ],
          ),
          Expanded(
              child: TextView(
            text: "John Doe",
            textColor: Colors.black,
            textFontWeight: FontWeight.normal,
            fontSize: 16,
            align: TextAlign.center,
          )),
          Expanded(
              child: TextView(
            text: "Weekly",
            textColor: Colors.black,
            textFontWeight: FontWeight.normal,
            fontSize: 16,
            align: TextAlign.center,
          )),
          Expanded(
              child: TextView(
            text: "\$109.96",
            textColor: Colors.black,
            textFontWeight: FontWeight.normal,
            fontSize: 16,
            align: TextAlign.center,
          )),
        ],
      ),
    );
  }
}
