import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/core/providers/payee_providers.dart';
import 'package:manawanui/data/models/get_employ_by_response.dart';
import 'package:manawanui/helpers/extension/context_function.dart';
import 'package:manawanui/helpers/extension/string_extensions.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/helpers/resources/strings.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';
import 'package:manawanui/widgets/custom_app_bar.dart';
import 'package:manawanui/widgets/data_choose_widget.dart';
import 'package:manawanui/widgets/data_switch_widget.dart';
import 'package:manawanui/widgets/data_text_input_widget.dart';
import 'package:manawanui/widgets/payee_type_widget.dart';
import 'package:manawanui/widgets/section_title.dart';
import 'package:manawanui/widgets/text_view.dart';

final firstNameController = TextEditingController();
final nameController = TextEditingController();
final lastNameController = TextEditingController();
final knownAsController = TextEditingController();
final emailController = TextEditingController();
final addressController = TextEditingController();
final regionController = TextEditingController();
final irdNumberController = TextEditingController();
final phoneNumberController = TextEditingController();
final occupationController = TextEditingController();
final childSupportAmountController = TextEditingController();
final bankAccountController = TextEditingController();
final withHoldingTaxRateController = TextEditingController();
final standardPayRateController = TextEditingController();
final nightPayRateController = TextEditingController();
final weekendPayRateController = TextEditingController();
final customerNumberController = TextEditingController();

class AddEditPayee extends HookConsumerWidget {
  const AddEditPayee({super.key, this.employByModel});

  final EmployByModel? employByModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider.notifier);
    final isPayeeEditingState = ref.watch(isPayeeEditingProvider.notifier);

    final ScrollController scrollController = ScrollController();
    final List<PayeeTypeWidget> payeeTypes = [
      PayeeTypeWidget(
        title: StringResources.PERMANENT_EMPLOYEE_PAYEE,
        iconData: Icons.group,
        isEditable: employByModel == null ? true : false,
      ),
      PayeeTypeWidget(
        title: StringResources.CASUAL_EMPLOYEE_PAYEE,
        iconData: Icons.document_scanner_outlined,
        isEditable: employByModel == null ? true : false,
      ),
      PayeeTypeWidget(
        title: StringResources.CONTRACTOR_PAYEE,
        iconData: Icons.document_scanner,
        isEditable: employByModel == null ? true : false,
      ),
      PayeeTypeWidget(
        title: StringResources.ORGANIZATION_PAYEE,
        iconData: Icons.business_outlined,
        isEditable: employByModel == null ? true : false,
      ),
      PayeeTypeWidget(
        title: StringResources.SCHEDULER_CONTRACTOR_PAYEE,
        iconData: Icons.business,
        isEditable: employByModel == null ? true : false,
      ),
      PayeeTypeWidget(
        title: StringResources.THIRD_PARTY_PROVIDER_PAYEE,
        iconData: Icons.groups_sharp,
        isEditable: employByModel == null ? true : false,
      ),
    ];

    void scrollToIndex(int index) {
      if (index >= 0 && index < payeeTypes.length) {
        scrollController.animateTo(
          index * 120.0, // Adjust the item width as needed
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }

    return WillPopScope(
      onWillPop: () async {
        ref.invalidate(currentIndexProvider);
        ref.invalidate(selectedPayeeProvider);
        ref.invalidate(isPayeeEditingProvider);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: customAppBar(() {
          ref.invalidate(currentIndexProvider);
          ref.invalidate(selectedPayeeProvider);
          ref.invalidate(isPayeeEditingProvider);
          context.pop();
        }, actions: [
          if (employByModel != null)
            StreamBuilder<bool>(
                stream: isPayeeEditingState.stream,
                builder: (context, snapshot) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      isPayeeEditingState.state
                          ? TextButton(
                              onPressed: () {
                                ref
                                    .watch(isPayeeEditingProvider.notifier)
                                    .state = false;
                              },
                              child: TextView(
                                  text: "Save",
                                  textColor: AppColors.primaryColor,
                                  textFontWeight: FontWeight.normal,
                                  fontSize: 16))
                          : TextButton(
                              onPressed: () {
                                ref
                                    .watch(isPayeeEditingProvider.notifier)
                                    .state = true;
                              },
                              child: TextView(
                                  text: "Edit",
                                  textColor: AppColors.primaryColor,
                                  textFontWeight: FontWeight.normal,
                                  fontSize: 16))
                    ],
                  );
                }),
          const SizedBox(
            width: 8,
          )
        ], employByModel == null ? "Add Payee" : "Edit Payee"),
        body: StreamBuilder<bool>(
            stream: isPayeeEditingState.stream,
            builder: (context, snapshot) {
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SectionTitle(
                        title: "Payee Type",
                        iconData: Icons.help_rounded,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                if (currentIndex.state > 0) {
                                  currentIndex.state--;
                                  console(
                                      "currentIndex - ${currentIndex.state}");
                                  scrollToIndex(currentIndex.state);
                                }
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: AppColors.primaryColor,
                              )),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 100,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                controller: scrollController,
                                itemCount: payeeTypes.length,
                                itemBuilder: (context, index) {
                                  return AnimatedOpacity(
                                    opacity: 1.0,
                                    duration: const Duration(milliseconds: 500),
                                    child: payeeTypes[index],
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                              onTap: () {
                                console(
                                    "currentIndex - ${currentIndex.state} - ${payeeTypes.length - 1}");
                                if (currentIndex.state <
                                    payeeTypes.length - 1) {
                                  currentIndex.state++;
                                  console(
                                      "currentIndex - ${currentIndex.state}");
                                  scrollToIndex(currentIndex.state);
                                }
                              },
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.primaryColor,
                              )),
                        ],
                      ),

                      //! Body

                      const SizedBox(
                        height: 32,
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          final selectedPayee =
                              ref.watch(selectedPayeeProvider);
                          if (selectedPayee != null) {
                            if (selectedPayee.title ==
                                StringResources.PERMANENT_EMPLOYEE_PAYEE) {
                              return PermanentEmployeePayeeWidget(
                                employee: employByModel,
                              );
                            } else if (selectedPayee.title ==
                                StringResources.CASUAL_EMPLOYEE_PAYEE) {
                              return CasualEmployeePayeeWidget(
                                employee: employByModel,
                              );
                            } else if (selectedPayee.title ==
                                StringResources.CONTRACTOR_PAYEE) {
                              return ContractorPayeeWidget(
                                employee: employByModel,
                              );
                            } else if (selectedPayee.title ==
                                StringResources.ORGANIZATION_PAYEE) {
                              return OrganizationPayeeWidget(
                                employee: employByModel,
                              );
                            } else if (selectedPayee.title ==
                                StringResources.SCHEDULER_CONTRACTOR_PAYEE) {
                              return SchedulerContractorPayeeWidget(
                                employee: employByModel,
                              );
                            } else if (selectedPayee.title ==
                                StringResources.THIRD_PARTY_PROVIDER_PAYEE) {
                              return ThirdPartyProviderPayeeWidget(
                                employee: employByModel,
                              );
                            } else {
                              return const NoPayeeSelectedWidget();
                            }
                          } else {
                            return const NoPayeeSelectedWidget();
                          }
                        },
                      )
                      /*StreamBuilder<PayeeTypeWidget>(
                  stream: selectedPayee.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data?.title == "Permanent Employee") {
                        return const Text("data");
                      }
                      else {
                        return const NoPayeeSelectedWidget();
                      }
                    } else {
                      return const NoPayeeSelectedWidget();
                    }
                  },
                ),*/
                    ],
                  ),
                ),
              );
            }),
        floatingActionButton: employByModel != null
            ? (employByModel?.employeeStatusName != "Terminated")
                ? FloatingActionButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  )
                : null
            : null,
      ),
    );
  }
}

class PermanentEmployeePayeeWidget extends ConsumerWidget {
  const PermanentEmployeePayeeWidget({super.key, required this.employee});

  final EmployByModel? employee;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPayeeEditingState = ref.watch(isPayeeEditingProvider.notifier);

    return Column(
      children: [
        const SectionTitle(
          title: "Payee Details",
          iconData: Icons.help,
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.black, // Border color
              width: 0.05, // Border width
            ), // Border radius to make it rounded
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: DataTextInputWidget(
                    isEditing: isPayeeEditingState.state,
                    title: "First Name*",
                    controller: firstNameController,
                    onChanged: (value) {},
                    value: employee?.firstName ?? "",
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: DataTextInputWidget(
                    isEditing: isPayeeEditingState.state,
                    title: "Last Name*",
                    onChanged: (e) {},
                    controller: lastNameController,
                    value: employee?.lastName,
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                      child: DataChooseWidget(
                    title: "Date of Birth*",
                    value: employee?.dateofBirth?.convertStringDateToMMMDDYYY(),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: DataChooseWidget(
                    title: "Title",
                    value: employee?.titleContentList,
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                      child: DataChooseWidget(
                    title: "Gender",
                    value: employee?.genderContentList,
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: DataTextInputWidget(
                    isEditing: isPayeeEditingState.state,
                    controller: knownAsController,
                    onChanged: (value) {},
                    title: "Known As",
                    value: employee?.knownAs,
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              DataTextInputWidget(
                isEditing: isPayeeEditingState.state,
                controller: emailController,
                onChanged: (value) {},
                title: "Email*",
                value: employee?.email,
              ),
              const SizedBox(
                height: 8,
              ),
              DataTextInputWidget(
                isEditing: isPayeeEditingState.state,
                controller: addressController,
                onChanged: (value) {},
                title: "Address*",
                value: employee?.fullAddress,
              ),
              const SizedBox(
                height: 8,
              ),
              DataTextInputWidget(
                isEditing: isPayeeEditingState.state,
                controller: regionController,
                onChanged: (value) {},
                title: "Region*",
                value: employee?.regionContentList,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: DataTextInputWidget(
                      isEditing: isPayeeEditingState.state,
                      controller: irdNumberController,
                      onChanged: (value) {},
                      title: "IRD Number*",
                      value: employee?.irdNumber,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: DataTextInputWidget(
                    isEditing: isPayeeEditingState.state,
                    controller: phoneNumberController,
                    onChanged: (value) {},
                    title: "Phone Number",
                    value: employee?.homePhone ?? "",
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              DataChooseWidget(
                title: "Status*",
                value: employee?.employeeStatusName,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                      child: DataSwitchWidget(
                    onChanged: (value) {},
                    title: "Invite to Portal",
                    isSelected: employee?.inviteToPortal ?? false,
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: DataSwitchWidget(
                    title: "Privacy Notice Signed",
                    onChanged: (value) {},
                    isSelected: employee?.inviteToPortal ?? false,
                  )),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const SectionTitle(
          title: "Payroll Info",
          iconData: Icons.help,
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.black, // Border color
              width: 0.05, // Border width
            ), // Border radius to make it rounded
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: DataTextInputWidget(
                    isEditing: isPayeeEditingState.state,
                    controller: occupationController,
                    onChanged: (value) {},
                    title: "Occupation",
                    value: employee?.occupation ?? "",
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: DataChooseWidget(
                    title: "Tax Code*",
                    value: employee?.taxCodeContentList,
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                      child: DataChooseWidget(
                    title: "Start Date*",
                    value: employee?.startDate,
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: DataChooseWidget(
                    title: "Kiwisaver Option*",
                    value: employee?.kiwiSaverContentList,
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              DataTextInputWidget(
                isEditing: isPayeeEditingState.state,
                controller: childSupportAmountController,
                onChanged: (value) {},
                title: "Child Support Amount",
                value: "${employee?.childSupportAmount ?? ""}",
              ),
              const SizedBox(
                height: 8,
              ),
              DataTextInputWidget(
                isEditing: isPayeeEditingState.state,
                controller: bankAccountController,
                onChanged: (value) {},
                title: "Bank Account Number*",
                value: employee?.fullBankAccountNumber ?? "",
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: DataTextInputWidget(
                      isEditing: isPayeeEditingState.state,
                      controller: bankAccountController,
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
                      isEditing: isPayeeEditingState.state,
                      controller: bankAccountController,
                      onChanged: (value) {},
                      title: "Night Pay Rate",
                      value: "${employee?.nightPayRate ?? ""}",
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: DataTextInputWidget(
                      isEditing: isPayeeEditingState.state,
                      controller: bankAccountController,
                      onChanged: (value) {},
                      title: "Weekend Pay Rate",
                      value: "${employee?.weekendPayRate ?? ""}",
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: DataChooseWidget(
                    title: "Leave Entitlement",
                    value: employee?.leaveEntitlementContentList,
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              DataChooseWidget(
                title: "Payslip Emails",
                value: employee?.emailPayslipDisplay ?? "Choose",
              ),
            ],
          ),
        ),
        if (employee == null)
          Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              const SectionTitle(
                title: "Mandatory Forms",
                iconData: Icons.help,
              ),
              const SizedBox(
                height: 16,
              ),
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const DocumentFormWidget();
                },
              ),
              const SectionTitle(
                title: "Optional Files",
                iconData: Icons.help,
              ),
              const SizedBox(
                height: 16,
              ),
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const DocumentFormWidget();
                },
              ),
            ],
          ),
        if (employee != null && employee?.documents?.isNotEmpty == true)
          Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              const SectionTitle(
                title: "Mandatory Forms",
                iconData: Icons.help,
              ),
              const SizedBox(
                height: 16,
              ),
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const DocumentFormWidget();
                },
              ),
              const SectionTitle(
                title: "Optional Files",
                iconData: Icons.help,
              ),
              const SizedBox(
                height: 16,
              ),
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const DocumentFormWidget();
                },
              ),
            ],
          ),
      ],
    );
  }
}

class CasualEmployeePayeeWidget extends ConsumerWidget {
  const CasualEmployeePayeeWidget({super.key, required this.employee});

  final EmployByModel? employee;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPayeeEditingState = ref.watch(isPayeeEditingProvider.notifier);
    return PermanentEmployeePayeeWidget(
      employee: employee,
    );
  }
}

class ContractorPayeeWidget extends ConsumerWidget {
  const ContractorPayeeWidget({super.key, required this.employee});

  final EmployByModel? employee;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPayeeEditingState = ref.watch(isPayeeEditingProvider.notifier);
    return Column(
      children: [
        const SectionTitle(
          title: "Payee Details",
          iconData: Icons.help,
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.black, // Border color
              width: 0.05, // Border width
            ), // Border radius to make it rounded
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: DataTextInputWidget(
                    isEditing: isPayeeEditingState.state,
                    title: "First Name*",
                    controller: firstNameController,
                    onChanged: (value) {},
                    value: employee?.firstName ?? "",
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: DataTextInputWidget(
                    isEditing: isPayeeEditingState.state,
                    title: "Last Name*",
                    controller: lastNameController,
                    onChanged: (value) {},
                    value: employee?.lastName ?? "",
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const DataChooseWidget(
                title: "Date of Birth*",
              ),
              const SizedBox(
                height: 8,
              ),
              DataTextInputWidget(
                isEditing: isPayeeEditingState.state,
                title: "Email",
                controller: emailController,
                onChanged: (value) {},
                value: employee?.email ?? "",
              ),
              const SizedBox(
                height: 8,
              ),
              DataTextInputWidget(
                isEditing: isPayeeEditingState.state,
                title: "Address*",
                controller: addressController,
                onChanged: (value) {},
                value: employee?.fullAddress ?? "",
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: DataTextInputWidget(
                      isEditing: isPayeeEditingState.state,
                      title: "IRD Number*",
                      controller: irdNumberController,
                      onChanged: (value) {},
                      value: employee?.irdNumber ?? "",
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: DataTextInputWidget(
                      isEditing: isPayeeEditingState.state,
                      title: "Phone Number*",
                      controller: phoneNumberController,
                      onChanged: (value) {},
                      value: employee?.homePhone ?? "",
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const DataChooseWidget(
                title: "Status*",
              ),
              const SizedBox(
                height: 8,
              ),
              DataSwitchWidget(
                onChanged: (value) {},
                isSelected: true,
                title: "Privacy Notice Signed*",
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const SectionTitle(
          title: "Optional Files",
          iconData: Icons.help,
        ),
        const SizedBox(
          height: 16,
        ),
        ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return const DocumentFormWidget();
          },
        ),
      ],
    );
  }
}

class OrganizationPayeeWidget extends ConsumerWidget {
  const OrganizationPayeeWidget({super.key, required this.employee});

  final EmployByModel? employee;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPayeeEditingState = ref.watch(isPayeeEditingProvider.notifier);
    return Column(
      children: [
        const SectionTitle(
          title: "Payee Details",
          iconData: Icons.help,
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.black, // Border color
              width: 0.05, // Border width
            ), // Border radius to make it rounded
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DataTextInputWidget(
                isEditing: isPayeeEditingState.state,
                title: "Name*",
                controller: nameController,
                onChanged: (value) {},
                value: employee?.fullName ?? "",
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Expanded(
                      child: DataChooseWidget(
                    title: "Status*",
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: DataTextInputWidget(
                    isEditing: isPayeeEditingState.state,
                    title: "Phone Number*",
                    controller: phoneNumberController,
                    onChanged: (value) {},
                    value: employee?.homePhone ?? "",
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              DataTextInputWidget(
                isEditing: isPayeeEditingState.state,
                title: "email*",
                controller: emailController,
                onChanged: (value) {},
                value: employee?.email ?? "",
              ),
              const SizedBox(
                height: 8,
              ),
              DataTextInputWidget(
                isEditing: isPayeeEditingState.state,
                title: "Address*",
                controller: addressController,
                onChanged: (value) {},
                value: employee?.fullAddress ?? "",
              )
            ],
          ),
        ),
      ],
    );
  }
}

class SchedulerContractorPayeeWidget extends ConsumerWidget {
  const SchedulerContractorPayeeWidget({super.key, required this.employee});

  final EmployByModel? employee;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPayeeEditingState = ref.watch(isPayeeEditingProvider.notifier);
    return Column(
      children: [
        const SectionTitle(
          title: "Payee Details",
          iconData: Icons.help,
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.black, // Border color
              width: 0.05, // Border width
            ), // Border radius to make it rounded
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: DataTextInputWidget(
                      isEditing: isPayeeEditingState.state,
                      title: "First Name*",
                      controller: firstNameController,
                      onChanged: (value) {},
                      value: employee?.firstName ?? "",
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: DataTextInputWidget(
                    isEditing: isPayeeEditingState.state,
                    title: "Last Name*",
                    controller: lastNameController,
                    onChanged: (value) {},
                    value: employee?.lastName ?? "",
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                      child: DataChooseWidget(
                    title: "Date of Birth*",
                    value: employee?.dateofBirth?.convertStringDateToMMMDDYYY(),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: DataTextInputWidget(
                    isEditing: isPayeeEditingState.state,
                    title: "Address*",
                    controller: addressController,
                    onChanged: (value) {},
                    value: employee?.fullAddress ?? "",
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                      child: DataChooseWidget(
                    title: "Gender",
                    value: employee?.genderContentList,
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: DataTextInputWidget(
                    isEditing: isPayeeEditingState.state,
                    title: "Known As",
                    controller: knownAsController,
                    onChanged: (value) {},
                    value: employee?.knownAs ?? "",
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              DataTextInputWidget(
                isEditing: isPayeeEditingState.state,
                title: "Email*",
                controller: emailController,
                onChanged: (value) {},
                value: employee?.fullAddress ?? "",
              ),
              const SizedBox(
                height: 8,
              ),
              DataTextInputWidget(
                isEditing: isPayeeEditingState.state,
                title: "Address*",
                controller: addressController,
                onChanged: (value) {},
                value: employee?.fullAddress ?? "",
              ),
              const SizedBox(
                height: 8,
              ),
              DataChooseWidget(
                title: "Region*",
                value: employee?.regionContentList,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                      child: DataTextInputWidget(
                    isEditing: isPayeeEditingState.state,
                    title: "IRD Number*",
                    controller: irdNumberController,
                    onChanged: (value) {},
                    value: employee?.irdNumber ?? "",
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: DataTextInputWidget(
                    isEditing: isPayeeEditingState.state,
                    title: "Phone Number*",
                    controller: phoneNumberController,
                    onChanged: (value) {},
                    value: employee?.homePhone ?? "",
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              DataChooseWidget(
                title: "Status*",
                value: employee?.employeeStatusName,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                      child: DataSwitchWidget(
                    onChanged: (value) {},
                    title: "Invite to Portal",
                    isSelected: employee?.inviteToPortal ?? false,
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: DataSwitchWidget(
                    onChanged: (value) {},
                    title: "Privacy Notice Signed",
                    isSelected: employee?.privacyNoticeChecked ?? false,
                  )),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const SectionTitle(
          title: "Payroll Info",
          iconData: Icons.help,
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.black, // Border color
              width: 0.05, // Border width
            ), // Border radius to make it rounded
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: DataTextInputWidget(
                      isEditing: isPayeeEditingState.state,
                      title: "Occupation*",
                      controller: occupationController,
                      onChanged: (value) {},
                      value: employee?.occupation ?? "",
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: DataChooseWidget(
                    title: "Tax Code*",
                    value: employee?.taxCodeContentList,
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              DataChooseWidget(
                title: "Start Date*",
                value: employee?.startDate,
              ),
              const SizedBox(
                height: 8,
              ),
              DataTextInputWidget(
                isEditing: isPayeeEditingState.state,
                title: "Bank Account Number*",
                controller: bankAccountController,
                onChanged: (value) {},
                value: "${employee?.bankAccountNumber ?? ""}",
              ),
              const SizedBox(
                height: 8,
              ),
              DataTextInputWidget(
                isEditing: isPayeeEditingState.state,
                title: "Withholding Tax Rate*",
                controller: withHoldingTaxRateController,
                onChanged: (value) {},
                value: "${employee?.withholdingTaxRate ?? ""}",
              ),
              const SizedBox(
                height: 8,
              ),
              DataSwitchWidget(
                title: "GST Registered",
                onChanged: (value) {},
                isSelected: employee?.gstRegistered ?? false,
              ),
              const SizedBox(
                height: 8,
              ),
              DataChooseWidget(
                title: "Payslip Emails",
                value: employee?.emailPayslipDisplay ?? "Choose",
              ),
            ],
          ),
        ),
        if (employee == null)
          Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              const SectionTitle(
                title: "Mandatory Forms",
                iconData: Icons.help,
              ),
              const SizedBox(
                height: 16,
              ),
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const DocumentFormWidget();
                },
              ),
              const SectionTitle(
                title: "Optional Files",
                iconData: Icons.help,
              ),
              const SizedBox(
                height: 16,
              ),
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const DocumentFormWidget();
                },
              ),
            ],
          ),
        if (employee != null && employee?.documents?.isNotEmpty == true)
          Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              const SectionTitle(
                title: "Mandatory Forms",
                iconData: Icons.help,
              ),
              const SizedBox(
                height: 16,
              ),
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const DocumentFormWidget();
                },
              ),
              const SectionTitle(
                title: "Optional Files",
                iconData: Icons.help,
              ),
              const SizedBox(
                height: 16,
              ),
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const DocumentFormWidget();
                },
              ),
            ],
          ),
      ],
    );
  }
}

class ThirdPartyProviderPayeeWidget extends ConsumerWidget {
  const ThirdPartyProviderPayeeWidget({super.key, required this.employee});

  final EmployByModel? employee;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPayeeEditingState = ref.watch(isPayeeEditingProvider.notifier);
    return Column(
      children: [
        const SectionTitle(
          title: "Payee Details",
          iconData: Icons.help,
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.black, // Border color
              width: 0.05, // Border width
            ), // Border radius to make it rounded
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              DataTextInputWidget(
                isEditing: isPayeeEditingState.state,
                title: "Provider Name*",
                controller: nameController,
                onChanged: (value) {},
                value: employee?.fullName ?? "",
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                      child: DataTextInputWidget(
                    isEditing: isPayeeEditingState.state,
                    title: "Email*",
                    controller: emailController,
                    onChanged: (value) {},
                    value: employee?.email ?? "",
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: DataTextInputWidget(
                    isEditing: isPayeeEditingState.state,
                    title: "Phone Number",
                    controller: phoneNumberController,
                    onChanged: (value) {},
                    value: employee?.homePhone ?? "",
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              DataTextInputWidget(
                isEditing: isPayeeEditingState.state,
                title: "Customer Number",
                controller: customerNumberController,
                onChanged: (value) {},
                value: employee?.employeeCode ?? "",
              ),
              const SizedBox(
                height: 8,
              ),
              DataTextInputWidget(
                isEditing: isPayeeEditingState.state,
                title: "Address*",
                controller: addressController,
                onChanged: (value) {},
                value: employee?.fullAddress ?? "",
              ),
              const SizedBox(
                height: 8,
              ),
              DataChooseWidget(
                title: "Status",
                value: employee?.employeeStatusName,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const SectionTitle(
          title: "Mandatory Forms",
          iconData: Icons.help,
        ),
        const SizedBox(
          height: 16,
        ),
        ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return const DocumentFormWidget();
          },
        ),
      ],
    );
  }
}

class DocumentFormWidget extends ConsumerWidget {
  const DocumentFormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.black, // Border color
          width: 0.05, // Border width
        ), // Border radius to make it rounded
      ),
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(top: 4, bottom: 4),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.download,
                color: AppColors.primaryColor,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: TextView(
                      text: "Download form",
                      textColor: AppColors.primaryColor,
                      textFontWeight: FontWeight.normal,
                      fontSize: 16)),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.attachment,
                color: AppColors.primaryColor,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextView(
                      text: "Bank Verification",
                      textColor: Colors.black,
                      textFontWeight: FontWeight.normal,
                      fontSize: 16),
                  TextView(
                      text: "Choose File",
                      textColor: AppColors.primaryColor,
                      textFontWeight: FontWeight.normal,
                      fontSize: 14),
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }
}

class NoPayeeSelectedWidget extends StatelessWidget {
  const NoPayeeSelectedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.fullWidth(),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300, width: 1.0)),
      child: Column(
        children: [
          const Icon(
            Icons.document_scanner,
            size: 40,
          ),
          const SizedBox(
            height: 16,
          ),
          TextView(
              text: "Payee Type Not Selected",
              textColor: AppColors.primaryColor,
              textFontWeight: FontWeight.normal,
              fontSize: 18),
          const SizedBox(
            height: 8,
          ),
          const TextView(
            text: "Choose a payee type from the options\nabove to proceed",
            textColor: Colors.black,
            textFontWeight: FontWeight.normal,
            fontSize: 14,
            align: TextAlign.center,
          )
        ],
      ),
    );
  }
}
