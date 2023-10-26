import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manawanui/core/providers/auth_providers.dart';
import 'package:manawanui/core/providers/payee_providers.dart';
import 'package:manawanui/data/models/get_employ_by_response.dart';
import 'package:manawanui/data/models/get_employee_payee_initials_response.dart';
import 'package:manawanui/helpers/enums/payees_type.dart';
import 'package:manawanui/helpers/extension/date_time_functions.dart';
import 'package:manawanui/screens/modals/bottom_sheet_choose_general_modal.dart';
import 'package:manawanui/screens/modals/custom_date_picker.dart';
import 'package:manawanui/widgets/data_choose_widget.dart';
import 'package:manawanui/widgets/data_switch_widget.dart';
import 'package:manawanui/widgets/data_text_input_widget.dart';
import 'package:manawanui/widgets/section_title.dart';

class PayeesPayrollInfoWidget extends StatelessWidget {
  const PayeesPayrollInfoWidget({
    super.key,
    required this.employee,
    required this.type,
    required this.response,
    required this.ref,
    required this.isEditing,
    required this.occupationController,
    required this.childSupportAmountController,
    required this.bankAccountController,
    required this.standardPayRateController,
    required this.nightPayRateController,
    required this.weekendPayRateController,
    required this.withHoldingTaxRateController,
  });

  final EmployByModel? employee;
  final PayeesType? type;
  final bool isEditing;
  final WidgetRef ref;
  final GetEmployeePayeeInitialsResponse? response;
  final TextEditingController occupationController;
  final TextEditingController childSupportAmountController;
  final TextEditingController bankAccountController;
  final TextEditingController standardPayRateController;
  final TextEditingController nightPayRateController;
  final TextEditingController weekendPayRateController;
  final TextEditingController withHoldingTaxRateController;

  @override
  Widget build(BuildContext context) {
    final DateTime? selectedPayeeStartDateState =
        ref.watch(selectedPayeeStartDateProvider);
    final viewModel = ref.watch(payeesViewModelProvider);
    final selectedTaxCode = ref.watch(selectedPayeeTaxCodeProvider.notifier);
    final selectedKiwisaver =
        ref.watch(selectedPayeeKiwisaverOptionProvider.notifier);
    final selectedLeaveEntitlement =
        ref.watch(selectedPayeeLeaveEntitlementProvider.notifier);
    final selectedPayslipEmails =
        ref.watch(selectedPayeePayslipEmailsProvider.notifier);
    final userDetails = ref.watch(userDetailsProvider);
    if (type != PayeesType.CONTRACTOR &&
        type != PayeesType.ORGANIZATION &&
        type != PayeesType.THIRD_PARTY_PROVIDER) {
      return Container(
        margin: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            const SectionTitle(
              title: "Payroll Info",
              iconData: Icons.help,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(top: 16),
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
                  ///OCCUPATION + TAX CODE
                  Row(
                    children: [
                      Expanded(
                          child: DataTextInputWidget(
                        isEditing: isEditing,
                        controller: occupationController,
                        onChanged: (value) {},
                        title: "Occupation",
                        value: employee?.occupation ?? "",
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      StreamBuilder<GenericIdValueModel?>(
                          stream: selectedTaxCode.stream,
                          builder: (context, snapshot) {
                            return Expanded(
                                child: DataChooseWidget(
                              title: "Tax Code*",
                              value: selectedTaxCode.state?.name ??
                                  employee?.taxCodeContentList,
                              onPress: () {
                                if (isEditing) {
                                  BottomSheetChooseGeneralModal.show(
                                    context,
                                    "Choose Tax Code",
                                    response?.response?.taxCode,
                                    selectedTaxCode.state,
                                    userDetails,
                                    (p0) {
                                      ref
                                          .watch(selectedPayeeTaxCodeProvider
                                              .notifier)
                                          .state = p0;
                                    },
                                  );
                                }
                              },
                            ));
                          }),
                    ],
                  ),

                  ///START DATE + KIWISAVER OPTIONS
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: DataChooseWidget(
                        title: "Start Date*",
                        value: selectedPayeeStartDateState
                                ?.convertDateToMMDDYYYY() ??
                            employee?.startDate,
                        onPress: () {
                          if (isEditing) {
                            customDatePicker(
                              context,
                              employee?.dateofBirth ??
                                  DateTime.now().toString(),
                              (pickedTime) {
                                ref
                                    .watch(
                                        selectedPayeeStartDateProvider.notifier)
                                    .state = pickedTime;
                              },
                            );
                          }
                        },
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      if (type != PayeesType.SCHEDULAR_CONTRACTOR)
                        StreamBuilder<GenericIdValueModel?>(
                            stream: selectedKiwisaver.stream,
                            builder: (context, snapshot) {
                              return Expanded(
                                  child: DataChooseWidget(
                                title: "Kiwisaver Option*",
                                value: selectedKiwisaver.state?.name ??
                                    employee?.kiwiSaverContentList,
                                onPress: () {
                                  if (isEditing) {
                                    BottomSheetChooseGeneralModal.show(
                                      context,
                                      "Choose Kiwisaver Options",
                                      response?.response?.kiwisaverOption,
                                      selectedKiwisaver.state,
                                      userDetails,
                                      (p0) {
                                        ref
                                            .watch(
                                                selectedPayeeKiwisaverOptionProvider
                                                    .notifier)
                                            .state = p0;
                                      },
                                    );
                                  }
                                },
                              ));
                            }),
                    ],
                  ),

                  ///CHILD SUPPORT AMOUNT NOT FOR SCHEDULAR_CONTRACTOR
                  if (type != PayeesType.SCHEDULAR_CONTRACTOR)
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: DataTextInputWidget(
                        isEditing: isEditing,
                        controller: childSupportAmountController,
                        onChanged: (value) {},
                        title: "Child Support Amount",
                        value: "${employee?.childSupportAmount ?? ""}",
                      ),
                    ),

                  ///BANK ACCOUNT NUMBER
                  const SizedBox(
                    height: 8,
                  ),
                  DataTextInputWidget(
                    isEditing: isEditing,
                    controller: bankAccountController,
                    onChanged: (value) {},
                    title: "Bank Account Number*",
                    value: employee?.fullBankAccountNumber ?? "",
                  ),

                  /// STANDARD PAY RATE + NIGHT PAY RATE NOT FOR SCHEDULAR_CONTRACTOR
                  if (type != PayeesType.SCHEDULAR_CONTRACTOR)
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: DataTextInputWidget(
                              isEditing: isEditing,
                              controller: standardPayRateController,
                              onChanged: (value) {},
                              title: "Standard Pay Rate*",
                              value: "${employee?.standardPayRate ?? ""}",
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: DataTextInputWidget(
                              isEditing: isEditing,
                              controller: nightPayRateController,
                              onChanged: (value) {},
                              title: "Night Pay Rate",
                              value: "${employee?.nightPayRate ?? ""}",
                            ),
                          ),
                        ],
                      ),
                    ),

                  /// WEEKEND PAY RATE NOT FOR SCHEDULAR_CONTRACTOR
                  if (type != PayeesType.SCHEDULAR_CONTRACTOR)
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: DataTextInputWidget(
                              isEditing: isEditing,
                              controller: weekendPayRateController,
                              onChanged: (value) {},
                              title: "Weekend Pay Rate",
                              value: "${employee?.weekendPayRate ?? ""}",
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          StreamBuilder<GenericIdValueModel?>(
                              stream: selectedLeaveEntitlement.stream,
                              builder: (context, snapshot) {
                                return Expanded(
                                    child: DataChooseWidget(
                                  title: "Leave Entitlement",
                                  value: selectedLeaveEntitlement.state?.name ??
                                      employee?.leaveEntitlementContentList,
                                  onPress: () {
                                    if (isEditing) {
                                      BottomSheetChooseGeneralModal.show(
                                        context,
                                        "Choose Leave Entitlement",
                                        response?.response?.leaveEntitlement,
                                        selectedLeaveEntitlement.state,
                                        userDetails,
                                        (p0) {
                                          ref
                                              .watch(
                                                  selectedPayeeLeaveEntitlementProvider
                                                      .notifier)
                                              .state = p0;
                                        },
                                      );
                                    }
                                  },
                                ));
                              }),
                        ],
                      ),
                    ),

                  /// WEEKEND PAY RATE NOT FOR SCHEDULAR_CONTRACTOR
                  if (type == PayeesType.SCHEDULAR_CONTRACTOR)
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: DataTextInputWidget(
                        isEditing: isEditing,
                        title: "Withholding Tax Rate*",
                        controller: withHoldingTaxRateController,
                        onChanged: (value) {},
                        value: "${employee?.withholdingTaxRate ?? ""}",
                      ),
                    ),

                  /// GST REGISTERED ONLY FOR SCHEDULAR_CONTRACTOR
                  if (type == PayeesType.SCHEDULAR_CONTRACTOR)
                    DataSwitchWidget(
                      title: "GST Registered",
                      onChanged: (value) {},
                      isEditing: true,
                      isSelected: employee?.gstRegistered ?? false,
                    ),

                  /// Payslip Emails
                  const SizedBox(
                    height: 8,
                  ),
                  StreamBuilder<GenericIdValueModel?>(
                      stream: selectedPayslipEmails.stream,
                      builder: (context, snapshot) {
                        return DataChooseWidget(
                          title: "Payslip Emails",
                          value: selectedPayslipEmails.state?.name ??
                              employee?.emailPayslipDisplay ??
                              "Choose",
                          onPress: () {
                            if (isEditing) {
                              BottomSheetChooseGeneralModal.show(
                                context,
                                "Choose Payslip Emails",
                                response?.response?.emailPayslipType,
                                selectedPayslipEmails.state,
                                userDetails,
                                (p0) {
                                  ref
                                      .watch(selectedPayeePayslipEmailsProvider
                                          .notifier)
                                      .state = p0;
                                },
                              );
                            }
                          },
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container();
  }
}
