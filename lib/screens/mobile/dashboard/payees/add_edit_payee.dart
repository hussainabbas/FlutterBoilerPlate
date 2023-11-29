import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/core/providers/auth_providers.dart';
import 'package:manawanui/core/providers/common_providers.dart';
import 'package:manawanui/core/providers/payee_providers.dart';
import 'package:manawanui/data/models/get_employ_by_response.dart';
import 'package:manawanui/data/models/get_employee_documents_response.dart';
import 'package:manawanui/data/models/get_employee_payee_initials_response.dart';
import 'package:manawanui/data/models/get_nz_post_auth_token_response.dart';
import 'package:manawanui/helpers/enums/payees_type.dart';
import 'package:manawanui/helpers/extension/context_function.dart';
import 'package:manawanui/helpers/extension/date_time_functions.dart';
import 'package:manawanui/helpers/extension/string_extensions.dart';
import 'package:manawanui/helpers/extension/widget_ref_functions.dart';
import 'package:manawanui/helpers/resources/api_param_keys.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/helpers/resources/strings.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';
import 'package:manawanui/screens/mobile/dashboard/payees/search_address_screen.dart';
import 'package:manawanui/screens/modals/bottom_sheet_choose_general_modal.dart';
import 'package:manawanui/screens/modals/custom_date_picker.dart';
import 'package:manawanui/widgets/custom_app_bar.dart';
import 'package:manawanui/widgets/custom_bank_account_widget.dart';
import 'package:manawanui/widgets/data_choose_widget.dart';
import 'package:manawanui/widgets/data_switch_widget.dart';
import 'package:manawanui/widgets/data_text_input_widget.dart';
import 'package:manawanui/widgets/document_form_widget.dart';
import 'package:manawanui/widgets/no_payee_selected_widget.dart';
import 'package:manawanui/widgets/payee_type_widget.dart';
import 'package:manawanui/widgets/section_title.dart';
import 'package:manawanui/widgets/text_view.dart';

final firstNameController = TextEditingController();
final nameController = TextEditingController();
final lastNameController = TextEditingController();
final knownAsController = TextEditingController();
final emailController = TextEditingController();
final regionController = TextEditingController();
final irdNumberController = TextEditingController();
final phoneNumberController = TextEditingController();
final occupationController = TextEditingController();
final childSupportAmountController = TextEditingController();
final bankCompanyController = TextEditingController();
final bankBranchController = TextEditingController();
final bankAccountController = TextEditingController();
final bankSuffixController = TextEditingController();
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
    console("AddEditPayee");
    final viewModel = ref.watch(payeesViewModelProvider);
    final nzViewModel = ref.watch(nzPostViewModelProvider);

    final userDetails = ref.watch(userDetailsProvider);
    final selectedPayee = ref.watch(selectedPayeeProvider);
    final currentIndex = ref.watch(currentIndexProvider.notifier);
    final apiClient = ref.watch(apiClientProvider).value;
    final isPayeeEditingState = ref.watch(isPayeeEditingProvider.notifier);
    final ScrollController scrollController = ScrollController();
    final taxCode = ref.read(selectedPayeeTaxCodeProvider.notifier);
    var dateOfBirthProvider =
        ref.watch(selectedPayeeDateOfBirthProvider.notifier);
    var titleProvider = ref.watch(selectedPayeeTitleProvider.notifier);
    var genderProvider = ref.watch(selectedPayeeGenderProvider.notifier);
    var regionProvider = ref.watch(selectedPayeeRegionProvider.notifier);
    var statusProvider = ref.watch(selectedPayeeStatusProvider.notifier);
    var addressProvider = ref.watch(selectedAddressPayeeProvider.notifier);
    var startDateProvider = ref.watch(selectedPayeeStartDateProvider.notifier);
    var selectedThirdParty =
        ref.watch(selectedThirdPartyProviderNameProvider.notifier);
    var kiwisaverOptionsProvider =
        ref.watch(selectedPayeeKiwisaverOptionProvider.notifier);
    var leaveEntitlementProvider =
        ref.watch(selectedPayeeLeaveEntitlementProvider.notifier);
    var payslipEmailsProvider =
        ref.watch(selectedPayeePayslipEmailsProvider.notifier);
    var selectedDocument = ref.watch(selectedDocumentsProvider.notifier);

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

    void getEmployBy() async {
      context.showProgressDialog();
      await viewModel.getEmployBy({
        ApiParamKeys.KEY_USER_ID_SMALL: userDetails?.userId ?? "",
        ApiParamKeys.KEY_EMPLOYER_ID: userDetails?.employerId ?? "",
        ApiParamKeys.KEY_IS_SELF_MANAGED: userDetails?.isSelfManaged ?? "",
        ApiParamKeys.KEY_PAGE_NO: 1,
      });
      ref.invalidatePayeesScreenProvider();
      if (context.mounted) context.pop();
    }

    List<DocumentsModel>? convertToDocumentsModelList(
        List<EmployeeDocumentsItem?> employeeDocuments) {
      return employeeDocuments
          .where((item) => item?.selectedFile != null)
          .map((item) {
        // Create a new DocumentsModel object based on EmployeeDocumentsItem
        return DocumentsModel(
          employeeDocumentId: item?.employeeDocumentId,
          documentName: item?.documentName,
          documentType: item?.documentType,
          documentTitle: item?.documentTitle,
          documentData: item?.selectedFileBase64,
          employeeDocumentTypeId: item?.employeeDocumentTypeId,
          employeeDocumentTypeName: item?.employeeDocumentTypeName,
          employeeName: item?.employeeName,
          employerId: item?.employerId,
          isPicked: item?.isPicked,
          selectedFile: item?.selectedFile,
        );
      }).toList();
    }

    useEffect(() {
      final subscription =
          viewModel.responseAddUpdateEmployeeStream.listen((response) async {
        if (response.data?.status == true) {
          context.showSuccessSnackBar(response.data?.message ?? "");
          getEmployBy();
          context.pop();
        } else {
          context
              .showErrorDialog(response.data?.message ?? response.error ?? "");
        }
      });

      return subscription.cancel;
    }, const []);

    void savePayee() async {
      EmployByModel? newEmployByModel;
      var firstName = firstNameController.text.toString();
      var name = nameController.text.toString();
      var lastName = lastNameController.text.toString();
      var knownAs = knownAsController.text.toString();
      var email = emailController.text.toString();
      var irdNumber = irdNumberController.text.toString();
      var phoneNumber = phoneNumberController.text.toString();
      var occupation = occupationController.text.toString();
      var standardPayRate = standardPayRateController.text.toString();
      var nightPayRate = nightPayRateController.text.toString();
      var weekendPayRate = weekendPayRateController.text.toString();
      var childSupportAmount = childSupportAmountController.text.toString();
      var withHoldingTaxRate = withHoldingTaxRateController.text.toString();
      var bankSuffix = bankSuffixController.text.toString();
      var bankBranch = bankBranchController.text.toString();
      var bankCompany = bankCompanyController.text.toString();
      var bankAccountNumber = bankAccountController.text.toString();
      var customerNumber = customerNumberController.text.toString();

      // Map<String, dynamic> body = {};

      if (selectedPayee?.title == StringResources.PERMANENT_EMPLOYEE_PAYEE ||
          selectedPayee?.title == StringResources.CASUAL_EMPLOYEE_PAYEE ||
          selectedPayee?.title == StringResources.SCHEDULER_CONTRACTOR_PAYEE) {
        if (firstName.isEmpty) {
          context.showErrorDialog(
              "First Name is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }
        if (lastName.isEmpty) {
          context.showErrorDialog(
              "Last Name is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }
        if (dateOfBirthProvider.state == null && employByModel == null) {
          context.showErrorDialog(
              "Date of Birth is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }
        if (titleProvider.state == null && employByModel == null) {
          context.showErrorDialog(
              "Title is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }
        if (email.isEmpty) {
          context.showErrorDialog(
              "Email is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }
        if (addressProvider.state == null && employByModel == null) {
          context.showErrorDialog(
              "Address is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }
        if (regionProvider.state == null && employByModel == null) {
          context.showErrorDialog(
              "Region is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }
        if (irdNumber.isEmpty) {
          context.showErrorDialog(
              "IRD Number is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }
        if (statusProvider.state == null && employByModel == null) {
          context.showErrorDialog(
              "Status is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }
        if (taxCode.state == null && employByModel == null) {
          context.showErrorDialog(
              "Tax Code is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }
        if (startDateProvider.state == null && employByModel == null) {
          context.showErrorDialog(
              "Start Date is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }
        if (kiwisaverOptionsProvider.state == null && employByModel == null) {
          context.showErrorDialog(
              "Kiwisaver Option is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }

        if (bankAccountNumber.isEmpty) {
          context.showErrorDialog(
              "Bank Account Number is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }

        if (standardPayRate.isEmpty) {
          context.showErrorDialog(
              "Standard Pay Rate is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }
        if (leaveEntitlementProvider.state == null && employByModel == null) {
          context.showErrorDialog(
              "Leave Entitlement is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }
        if (payslipEmailsProvider.state == null && employByModel == null) {
          context.showErrorDialog(
              "Email Payslip Type is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }

        if (childSupportAmount.isNotEmpty) {
          double childSupportAmountValue =
              double.tryParse(childSupportAmount) ?? 0;
          if (childSupportAmountValue < 15) {
            context.showErrorDialog("Minimum Child Support Amount is \$15",
                title: "Warning");
            return;
          }
        }

        if (standardPayRate.isNotEmpty) {
          double amount = double.tryParse(standardPayRate) ?? 0;
          if (amount < 15) {
            context.showErrorDialog("Minimum Standard Pay Rate is \$15",
                title: "Warning");
            return;
          }
        }

        if (weekendPayRate.isNotEmpty) {
          double amount = double.tryParse(weekendPayRate) ?? 0;
          if (amount < 15) {
            context.showErrorDialog("Minimum Weekend Pay Rate is \$15",
                title: "Warning");
            return;
          }
        }

        if (nightPayRate.isNotEmpty) {
          double amount = double.tryParse(nightPayRate) ?? 0;
          if (amount < 15) {
            context.showErrorDialog("Minimum Night Pay Rate is \$15",
                title: "Warning");
            return;
          }
        }
        /* body = {

          "LastName": lastName,
          "KnownAs": knownAs,
          "LeaveEntitlementContentListId": leaveEntitlementProvider.state?.id ??
              employByModel?.leaveEntitlementContentListId,
          "LeaveEntitlementContentList": leaveEntitlementProvider.state?.name ??
              employByModel?.leaveEntitlementContentList,
          "NightPayRate": nightPayRate,
          "Occupation": occupation,
          "OccupationContentListId": 0,
          "RegionContentList":
              regionProvider.state?.name ?? employByModel?.regionContentList,
          "RegionContentListId":
              regionProvider.state?.id ?? employByModel?.regionContentListId,
          "StandardPayRate": standardPayRate,
          "StartDate":
              startDateProvider.state?.toString() ?? employByModel?.startDate,
          "TaxCodeContentList":
              taxCode.state?.name ?? employByModel?.taxCodeContentList,
          "TaxCodeContentListId":
              taxCode.state?.id ?? employByModel?.taxCodeContentListId,
          "TitleContentList":
              titleProvider.state?.name ?? employByModel?.titleContentList,
          "TitleContentListId":
              titleProvider.state?.id ?? employByModel?.titleContentListId,
          "UserId": userDetails?.userId,
          "WeekendPayRate": weekendPayRate,
          "WithholdingTaxRate": withHoldingTaxRate,
          "IsSelfManaged": userDetails?.isSelfManaged ?? false,
          "Documents": [],
          // EDIT
          "BalancesArray": [],
          "PaySlip": [],
          "DatapayCompany":employByModel?.datapayCompany ?? "",
          "PayGroup": employByModel?.payGroup,

          "Address1": addressProvider.state ?? employByModel?.fullAddress,
          "BankSuffix": bankSuffix,
          "BankCompany": bankCompany,
          "BankAccountNumber": bankAccountNumber,
          "BankBranch": bankBranch,
          "ChildSupportAmount": childSupportAmount,
          "DateofBirth": dateOfBirthProvider.state?.toString() ??
              employByModel?.dateofBirth,
          "Email": email,
          "EmployeeId": employByModel == null ? 0 : employByModel?.employeeId,
          "EmployeeStatusName": statusProvider.state?.name ??
              employByModel?.employmentStatusContentList,
          "EmployeeStatusCode": statusProvider.state?.name?[0] ??
              employByModel?.employeeStatusCode,
          "EmployeeTypeCode": getEmployeeType(
              selectedPayee?.title ?? employByModel?.employeeTypeDisplay ?? ""),
          "EmployeeTypeDisplay":
          selectedPayee?.title ?? employByModel?.employeeTypeDisplay,
          "EmployerId": userDetails?.employerId,
          "EmploymentStatusContentListId": statusProvider.state?.id ??
              employByModel?.employmentStatusContentListId,
          "FirstName": firstName,
          "FullAddress": addressProvider.state ?? employByModel?.fullAddress,
          "GenderContentList":
          genderProvider.state?.name ?? employByModel?.genderContentList,
          "GenderContentListId":
          genderProvider.state?.id ?? employByModel?.genderContentListId,
          "GstRegistered": false ?? employByModel?.gstRegistered,
          "HasKiwiSaver": true ?? employByModel?.hasKiwiSaver,
          "HomePhone": phoneNumber,
          "InviteToPortal": false,
          "PrivacyNoticeChecked": false,
          "IrdNumber": irdNumber,
          "IsAgent": false,
          "IsAgentEmployee": false,
          "KiwiSaverContentListId": kiwisaverOptionsProvider.state?.id ??
              employByModel?.kiwiSaverContentListId,
          "KiwiSaverContentList": kiwisaverOptionsProvider.state?.name ??
              employByModel?.kiwiSaverContentList,
          // "ThirdPartyProviderId": employByModel?.thirdPartyProviderId,
          // "FullName": nameController.text.toString(),
          // "FullBankAccountNumber": bankAccountNumber,
          // "EffectiveDate": "2017-08-14T00:00:00",
          //
          // "PayGroup": employByModel?.payGroup,
          // "DatapayCompany": employByModel?.datapayCompany,
          // "EmailPayslipCode":
          //     payslipEmailsProvider.state?.id ?? employByModel?.emailPayslipCode,
          // "EmailPayslipDisplay": payslipEmailsProvider.state?.name ??
          //     employByModel?.emailPayslipDisplay,
          // "BalancesArray": [],
          // "EmployeeCode": employByModel?.employeeCode,
          //
          // "WitholodingTaxRate": withHoldingTaxRate,
        };*/
      } else if (selectedPayee?.title == StringResources.CONTRACTOR_PAYEE) {
        if (firstName.isEmpty) {
          context.showErrorDialog(
              "First Name is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }
        if (lastName.isEmpty) {
          context.showErrorDialog(
              "Last Name is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }

        if (dateOfBirthProvider.state == null && employByModel == null) {
          context.showErrorDialog(
              "Date of Birth is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }
        if (addressProvider.state == null && employByModel == null) {
          context.showErrorDialog(
              "Address is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }

        if (phoneNumber.isEmpty) {
          context.showErrorDialog(
              "Phone Number is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }
        if (statusProvider.state == null && employByModel == null) {
          context.showErrorDialog(
              "Status is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }

        /*body = {
          "Address1": addressProvider.state ?? employByModel?.fullAddress,
          "ChildSupportAmount": childSupportAmount,
          "DateofBirth": dateOfBirthProvider.state?.toString() ??
              employByModel?.dateofBirth,
          "Email": email,
          "EmployeeId": employByModel == null ? 0 : employByModel?.employeeId,
          "EmployeeStatusName": statusProvider.state?.name ??
              employByModel?.employmentStatusContentList,
          "EmployeeStatusCode": statusProvider.state?.id ??
              employByModel?.employmentStatusContentListId,
          "EmployeeTypeCode": getEmployeeType(
              selectedPayee?.title ?? employByModel?.employeeTypeDisplay ?? ""),
          "EmployeeTypeDisplay":
              selectedPayee?.title ?? employByModel?.employeeTypeDisplay,
          "EmployerId": userDetails?.employerId,
          "EmploymentStatusContentListId": 0,
          "FirstName": firstName,
          "FullAddress": addressProvider.state ?? employByModel?.fullAddress,
          "GenderContentList":
              genderProvider.state?.name ?? employByModel?.genderContentList,
          "GenderContentListId":
              genderProvider.state?.id ?? employByModel?.genderContentListId,
          "GstRegistered": false ?? employByModel?.gstRegistered,
          "HasKiwiSaver": true ?? employByModel?.hasKiwiSaver,
          "HomePhone": phoneNumber,
          "InviteToPortal": false,
          "PrivacyNoticeChecked": false,
          "IrdNumber": irdNumber,
          "IsAgent": false,
          "IsAgentEmployee": false,
          "KiwiSaverContentListId": kiwisaverOptionsProvider.state?.id ??
              employByModel?.kiwiSaverContentListId,
          "KiwiSaverContentList": kiwisaverOptionsProvider.state?.name ??
              employByModel?.kiwiSaverContentList,
          "LastName": lastName,
          "KnownAs": knownAs,
          "LeaveEntitlementContentListId": leaveEntitlementProvider.state?.id ??
              employByModel?.leaveEntitlementContentListId,
          "LeaveEntitlementContentList": leaveEntitlementProvider.state?.name ??
              employByModel?.leaveEntitlementContentList,
          "NightPayRate": nightPayRate,
          "Occupation": occupation,
          "OccupationContentListId": 0,
          "RegionContentList":
              regionProvider.state?.name ?? employByModel?.regionContentList,
          "RegionContentListId":
              regionProvider.state?.id ?? employByModel?.regionContentListId,
          "StandardPayRate": standardPayRate,
          "TaxCodeContentList":
              taxCode.state?.name ?? employByModel?.taxCodeContentList,
          "TaxCodeContentListId":
              taxCode.state?.id ?? employByModel?.taxCodeContentListId,
          "TitleContentList":
              titleProvider.state?.name ?? employByModel?.titleContentList,
          "TitleContentListId":
              titleProvider.state?.id ?? employByModel?.titleContentListId,
          "UserId": userDetails?.userId,
          "WeekendPayRate": weekendPayRate,
          "WithholdingTaxRate": withHoldingTaxRate,
          "IsSelfManaged": userDetails?.isSelfManaged ?? false,
          "Documents": [],
          // EDIT
          "BalancesArray": [],
          "PaySlip": [],
          "DatapayCompany":employByModel?.datapayCompany ?? "",
          "PayGroup": employByModel?.payGroup,
        };*/
      } else if (selectedPayee?.title == StringResources.ORGANIZATION_PAYEE) {
        if (name.isEmpty) {
          context.showErrorDialog(
              "Name is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }
        if (statusProvider.state == null && employByModel == null) {
          context.showErrorDialog(
              "Status is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }
        if (email.isEmpty) {
          context.showErrorDialog(
              "Email is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }
        if (addressProvider.state == null && employByModel == null) {
          context.showErrorDialog(
              "Address is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }

        /* body = {
          "EmployeeId": employByModel == null ? 0 : employByModel?.employeeId,
          "FirstName": name,
          "EmployeeStatusName": statusProvider.state?.name ??
              employByModel?.employmentStatusContentList,
          "EmployeeStatusCode": statusProvider.state?.name?[0] ??
              employByModel?.employeeStatusCode,
          "EmployeeTypeCode": getEmployeeType(
              selectedPayee?.title ?? employByModel?.employeeTypeDisplay ?? ""),
          "EmployeeTypeDisplay":
              selectedPayee?.title ?? employByModel?.employeeTypeDisplay,
          "Address1": addressProvider.state ?? employByModel?.fullAddress,
          "HomePhone": phoneNumber,
          "Email": email,
          "EmployerId": userDetails?.employerId,
          "UserId": userDetails?.userId,
          "IsSelfManaged": userDetails?.isSelfManaged ?? false,
          "TitleContentList":
              titleProvider.state?.name ?? employByModel?.titleContentList,
          "TitleContentListId":
              titleProvider.state?.id ?? employByModel?.titleContentListId,
          "RegionContentList": regionProvider.state?.name ??
              employByModel?.regionContentList ??
              "Auckland",
          "RegionContentListId": regionProvider.state?.id ??
              employByModel?.regionContentListId ??
              "1064",
          "LeaveEntitlementContentListId": leaveEntitlementProvider.state?.id ??
              employByModel?.leaveEntitlementContentListId ??
              "61",
          "LeaveEntitlementContentList": leaveEntitlementProvider.state?.name ??
              employByModel?.leaveEntitlementContentList ??
              "20 days",
          "KiwiSaverContentListId": kiwisaverOptionsProvider.state?.id ??
              employByModel?.kiwiSaverContentListId,
          "KiwiSaverContentList": kiwisaverOptionsProvider.state?.name ??
              employByModel?.kiwiSaverContentList,
          "NightPayRate": nightPayRate,
          "StandardPayRate": standardPayRate,
          "TaxCodeContentList":
              taxCode.state?.name ?? employByModel?.taxCodeContentList,
          "TaxCodeContentListId":
              taxCode.state?.id ?? employByModel?.taxCodeContentListId,
          "WeekendPayRate": weekendPayRate,
          "Documents": [],
         // EDIT
          "BalancesArray": [],
          "PaySlip": [],
          "DatapayCompany":employByModel?.datapayCompany ?? "",
          "PayGroup": employByModel?.payGroup,

        };*/
      } else if (selectedPayee?.title ==
          StringResources.THIRD_PARTY_PROVIDER_PAYEE) {
        if (selectedThirdParty.state == null && employByModel == null) {
          context.showErrorDialog(
              "Provider Name is a required field, please fill it first before proceeding",
              title: "Warning");
          return;
        }

        /*     body = {
          "EmployeeId": employByModel == null ? 0 : employByModel?.employeeId,
          "EmployeeCode": customerNumber,
          "FirstName":
              selectedThirdParty.state?.name ?? employByModel?.fullName,
          "EmployeeStatusName": statusProvider.state?.name ??
              employByModel?.employmentStatusContentList,
          "EmployeeStatusCode": statusProvider.state?.name?[0] ??
              employByModel?.employeeStatusCode,
          "ThirdPartyProviderId": selectedThirdParty.state?.id ??
              employByModel?.thirdPartyProviderId,
          "EmployeeTypeCode": getEmployeeType(
              selectedPayee?.title ?? employByModel?.employeeTypeDisplay ?? ""),
          "EmployeeTypeDisplay":
              selectedPayee?.title ?? employByModel?.employeeTypeDisplay,
          "Address1": addressProvider.state ?? employByModel?.fullAddress,
          "HomePhone": phoneNumber,
          "Email": email,
          "EmployerId": userDetails?.employerId,
          "UserId": userDetails?.userId,
          "IsSelfManaged": userDetails?.isSelfManaged ?? false,
          "TitleContentList":
              titleProvider.state?.name ?? employByModel?.titleContentList,
          "TitleContentListId":
              titleProvider.state?.id ?? employByModel?.titleContentListId,
          "RegionContentList": regionProvider.state?.name ??
              employByModel?.regionContentList ??
              "Auckland",
          "RegionContentListId": regionProvider.state?.id ??
              employByModel?.regionContentListId ??
              "1064",
          "LeaveEntitlementContentListId": leaveEntitlementProvider.state?.id ??
              employByModel?.leaveEntitlementContentListId ??
              "61",
          "LeaveEntitlementContentList": leaveEntitlementProvider.state?.name ??
              employByModel?.leaveEntitlementContentList ??
              "20 days",
          "KiwiSaverContentListId": kiwisaverOptionsProvider.state?.id ??
              employByModel?.kiwiSaverContentListId,
          "KiwiSaverContentList": kiwisaverOptionsProvider.state?.name ??
              employByModel?.kiwiSaverContentList,
          "NightPayRate": nightPayRate,
          "StandardPayRate": standardPayRate,
          "TaxCodeContentList":
              taxCode.state?.name ?? employByModel?.taxCodeContentList,
          "TaxCodeContentListId":
              taxCode.state?.id ?? employByModel?.taxCodeContentListId,
          "WeekendPayRate": weekendPayRate,
          "Documents": [],
          // EDIT
          "BalancesArray": [],
          "PaySlip": [],
          "DatapayCompany":employByModel?.datapayCompany ?? "",
          "PayGroup": employByModel?.payGroup,
        };*/
      }

      if (employByModel == null) {
        newEmployByModel = EmployByModel();
      } else {
        newEmployByModel = employByModel;
      }

      if (selectedDocument.state.isNotEmpty) {}

      newEmployByModel?.address1 =
          addressProvider.state ?? employByModel?.fullAddress;
      newEmployByModel?.bankSuffix = bankSuffix.toInt();
      newEmployByModel?.bankCompany = bankCompany.toInt();
      newEmployByModel?.bankBranch = bankBranch.toInt();
      newEmployByModel?.bankAccountNumber = bankAccountNumber.toInt();
      newEmployByModel?.childSupportAmount = childSupportAmount.toDouble();
      newEmployByModel?.dateofBirth =
          dateOfBirthProvider.state?.toString() ?? employByModel?.dateofBirth;
      newEmployByModel?.email = email;
      newEmployByModel?.employeeId =
          employByModel == null ? 0 : employByModel?.employeeId;
      newEmployByModel?.employeeStatusCode =
          statusProvider.state?.name?[0] ?? employByModel?.employeeStatusCode;
      newEmployByModel?.employeeStatusName =
          statusProvider.state?.name ?? employByModel?.employeeStatusName;
      newEmployByModel?.employeeTypeCode = getEmployeeType(
          selectedPayee?.title ?? employByModel?.employeeTypeDisplay ?? "");
      newEmployByModel?.employeeTypeDisplay =
          selectedPayee?.title ?? employByModel?.employeeTypeDisplay;
      newEmployByModel?.employerId = userDetails?.employerId;
      newEmployByModel?.firstName = firstName.isEmpty ? name : firstName;
      newEmployByModel?.genderContentList =
          genderProvider.state?.name ?? employByModel?.genderContentList;
      newEmployByModel?.genderContentListId =
          genderProvider.state?.id?.toInt() ??
              employByModel?.genderContentListId;
      newEmployByModel?.gstRegistered = employByModel?.gstRegistered ?? false;
      newEmployByModel?.hasKiwiSaver = employByModel?.hasKiwiSaver ?? false;
      newEmployByModel?.homePhone = phoneNumber;
      newEmployByModel?.inviteToPortal = employByModel?.inviteToPortal ?? false;
      newEmployByModel?.privacyNoticeChecked =
          employByModel?.privacyNoticeChecked ?? false;
      newEmployByModel?.irdNumber = irdNumber;
      newEmployByModel?.isAgent = employByModel?.isAgent ?? false;
      newEmployByModel?.isAgentEmployee =
          employByModel?.isAgentEmployee ?? false;
      newEmployByModel?.kiwiSaverContentListId =
          kiwisaverOptionsProvider.state?.id?.toInt() ??
              employByModel?.kiwiSaverContentListId;
      newEmployByModel?.kiwiSaverContentList =
          kiwisaverOptionsProvider.state?.name ??
              employByModel?.kiwiSaverContentList;
      newEmployByModel?.lastName = lastName;
      newEmployByModel?.knownAs = knownAs;
      newEmployByModel?.leaveEntitlementContentListId =
          leaveEntitlementProvider.state?.id?.toInt() ??
              employByModel?.leaveEntitlementContentListId;
      newEmployByModel?.leaveEntitlementContentList =
          leaveEntitlementProvider.state?.name ??
              employByModel?.leaveEntitlementContentList;
      newEmployByModel?.nightPayRate = nightPayRate.toDouble();
      newEmployByModel?.occupation = occupation;
      newEmployByModel?.regionContentList =
          regionProvider.state?.name ?? employByModel?.regionContentList;
      newEmployByModel?.regionContentListId =
          regionProvider.state?.id?.toInt() ??
              employByModel?.regionContentListId;
      newEmployByModel?.standardPayRate = standardPayRate.toDouble();
      newEmployByModel?.startDate =
          startDateProvider.state?.toString() ?? employByModel?.startDate;
      newEmployByModel?.taxCodeContentListId =
          taxCode.state?.id?.toInt() ?? employByModel?.taxCodeContentListId;
      newEmployByModel?.taxCodeContentList =
          taxCode.state?.name ?? employByModel?.taxCodeContentList;
      newEmployByModel?.titleContentList =
          taxCode.state?.name ?? employByModel?.titleContentList;
      newEmployByModel?.titleContentListId =
          titleProvider.state?.id?.toInt() ?? employByModel?.titleContentListId;
      newEmployByModel?.userId = userDetails?.userId;
      newEmployByModel?.weekendPayRate = weekendPayRate.toDouble();
      newEmployByModel?.withholdingTaxRate = withHoldingTaxRate.toDouble();
      newEmployByModel?.isSelfManaged = userDetails?.isSelfManaged ?? false;
      newEmployByModel?.documents = selectedDocument.state.isEmpty
          ? employByModel?.documents
          : convertToDocumentsModelList(selectedDocument.state);
      newEmployByModel?.datapayCompany = employByModel?.datapayCompany ?? "";
      newEmployByModel?.payGroup = employByModel?.payGroup ?? "";
      newEmployByModel?.thirdPartyProviderId =
          selectedThirdParty.state?.id?.toInt() ??
              employByModel?.thirdPartyProviderId ??
              0;

      if (context.mounted) context.showProgressDialog();
      await viewModel.addUpdateEmployee(newEmployByModel!.toJson());
      if (context.mounted) {
        context.pop();
      }
    }

    getEmployeeDocumentTypeBy(String title) async {
      var body = {
        ApiParamKeys.KEY_USER_ID_SMALL: userDetails?.userId ?? "",
        ApiParamKeys.KEY_EMPLOYEE_TYPE_CODE: getEmployeeType(title),
        ApiParamKeys.KEY_IS_SELF_MANAGED: userDetails?.isSelfManaged ?? "",
        ApiParamKeys.KEY_EMPLOYEE_ID: userDetails?.employeeId ?? "0",
      };
      await viewModel.getEmployeeDocumentTypeBy(body);
    }

    getEmployeePayeeInitials(String title) async {
      var body = {
        ApiParamKeys.KEY_USER_ID_SMALL: userDetails?.userId ?? "",
        ApiParamKeys.KEY_EMPLOYER_ID: userDetails?.employerId ?? "",
        ApiParamKeys.KEY_USER_ROLE: userDetails?.roleCode ?? "",
        ApiParamKeys.KEY_IS_SELF_MANAGED: userDetails?.isSelfManaged ?? "",
        ApiParamKeys.KEY_EMPLOYEE_TYPE: getEmployeeType(title),
      };
      await viewModel.getEmployeePayeeInitials(body);
      getEmployeeDocumentTypeBy(title);
    }

    getNzPostAuthToken(String title) async {
      var body = {
        ApiParamKeys.KEY_CLIENT_ID_NZ: StringResources.CLIENT_ID,
        ApiParamKeys.KEY_CLIENT_SECRET_NZ: StringResources.CLIENT_SECRET,
        ApiParamKeys.KEY_GRANT_TYPE_NZ: StringResources.GRANT_TYPE,
      };
      await nzViewModel.getNzPostAuthToken(body);
      getEmployeePayeeInitials(title);
    }

    useEffect(() {
      setGlobalHeaders(userDetails, apiClient);
      return null;
    }, []);

    useEffect(() {
      if (employByModel != null) {
        getNzPostAuthToken(employByModel?.employeeTypeDisplay ?? "");
      }
      return null;
    }, []);

    return WillPopScope(
      onWillPop: () async {
        ref.invalidatePayeesScreenProvider();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: customAppBar(() {
          ref.invalidatePayeesScreenProvider();
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
                                savePayee();
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
                                  fontSize: 16)),
                    ],
                  );
                }),
          if (employByModel == null)
            TextButton(
                onPressed: () {
                  savePayee();
                },
                child: TextView(
                    text: "Save",
                    textColor: AppColors.primaryColor,
                    textFontWeight: FontWeight.normal,
                    fontSize: 16)),
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

                      /// Body
                      const SizedBox(
                        height: 32,
                      ),
                      const SectionTitle(
                        title: "Payee Details",
                        iconData: Icons.help,
                      ),
                      StreamBuilder<ApiResult<GetNZPostAuthTokenResponse>>(
                        stream: nzViewModel.responseGetNZAuthTokenStream,
                        builder: (context, snapshot) {
                          final selectedPayee =
                              ref.watch(selectedPayeeProvider);

                          if (selectedPayee == null) {
                            return const NoPayeeSelectedWidget();
                          }

                          if (!snapshot.hasData) {
                            return SizedBox(
                                height: context.fullHeight(multiplier: 0.5),
                                child: const Center(
                                    child: CircularProgressIndicator()));
                          }

                          final nzAuthResponse = snapshot.data?.data;

                          return StreamBuilder<
                              ApiResult<GetEmployeePayeeInitialsResponse>>(
                            stream:
                                viewModel.responseGetEmployPayeeInitialsStream,
                            builder: (context, snapshot) {
                              if (selectedPayee == null) {
                                return const NoPayeeSelectedWidget();
                              }

                              if (!snapshot.hasData) {
                                return SizedBox(
                                    height: context.fullHeight(multiplier: 0.5),
                                    child: const Center(
                                        child: CircularProgressIndicator()));
                              }

                              final employeePayeeInitialsResponse =
                                  snapshot.data?.data;

                              return StreamBuilder<
                                  ApiResult<GetEmployeeDocumentsResponse>>(
                                stream: viewModel
                                    .responseGetEmployeeDocumentTypeByStream,
                                builder: (context, snapshot) {
                                  if (selectedPayee == null) {
                                    return const NoPayeeSelectedWidget();
                                  }

                                  if (!snapshot.hasData) {
                                    return SizedBox(
                                        height:
                                            context.fullHeight(multiplier: 0.5),
                                        child: const Center(
                                            child:
                                                CircularProgressIndicator()));
                                  }

                                  final employeeDocumentResponse =
                                      snapshot.data?.data;

                                  final payeeType = selectedPayee.title;

                                  return PayeeDetailsWidget(
                                    employee: employByModel,
                                    nzPostAuthTokenResponse: nzAuthResponse,
                                    isEditing: isPayeeEditingState.state,
                                    type: getPayeeTypeFromTitle(payeeType),
                                    response: employeePayeeInitialsResponse,
                                    documentResponse: employeeDocumentResponse,
                                  );
                                },
                              );
                            },
                          );
                        },
                      )
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

class PayeeDetailsWidget extends ConsumerWidget {
  const PayeeDetailsWidget(
      {super.key,
      required this.employee,
      required this.type,
      required this.isEditing,
      required this.response,
      required this.documentResponse,
      required this.nzPostAuthTokenResponse});

  final EmployByModel? employee;
  final PayeesType? type;
  final GetEmployeePayeeInitialsResponse? response;
  final GetNZPostAuthTokenResponse? nzPostAuthTokenResponse;
  final GetEmployeeDocumentsResponse? documentResponse;
  final bool isEditing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPayeeStatus = ref.watch(selectedPayeeStatusProvider.notifier);
    final selectedPayeeRegion = ref.watch(selectedPayeeRegionProvider.notifier);
    final selectedThirdParty =
        ref.watch(selectedThirdPartyProviderNameProvider.notifier);

    final selectedAddressProvider =
        ref.watch(selectedAddressPayeeProvider.notifier);
    final userDetails = ref.watch(userDetailsProvider);
    var mandatoryTrueDocuments = documentResponse?.response?.documents
        ?.where((doc) => doc.mandatory == true)
        .toList();
    var mandatoryFalseDocuments = documentResponse?.response?.documents
        ?.where((doc) => doc.mandatory == false)
        .toList();

    return Column(
      children: [
        // ///PAYEES DETAILS INFO
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
              /// Payees Name
              PayeesNameWidget(
                  employee: employee, type: type, isEditing: isEditing),

              if (type == PayeesType.THIRD_PARTY_PROVIDER)
                StreamBuilder<GenericIdValueModel?>(
                    stream: selectedThirdParty.stream,
                    builder: (context, snapshot) {
                      return DataChooseWidget(
                        title: "Provider Name*",
                        value: selectedThirdParty.state?.name ??
                            employee?.fullName,
                        onPress: () {
                          if (employee == null) {
                            BottomSheetChooseGeneralModal.show(
                              context,
                              "Choose Provider Name",
                              response?.response?.thirdPartyPaymentProviders,
                              selectedThirdParty.state,
                              userDetails,
                              (p0) {
                                ref
                                    .watch(
                                        selectedThirdPartyProviderNameProvider
                                            .notifier)
                                    .state = p0;
                              },
                            );
                          }
                        },
                      );
                    }),
              // return DataTextInputWidget(
              // isEditing: isEditing,
              // title: "Provider Name*",
              // controller: nameController,
              // textInputType: TextInputType.text,
              // onChanged: (value) {},
              // value: employee?.fullName ?? "",
              // );

              /// Payees DOB
              PayeesDobTitleWidget(
                  employee: employee,
                  type: type,
                  ref: ref,
                  list: response?.response?.title,
                  isEditing: isEditing),

              /// Gender, Known As
              PayeesGenderKnownAsWidget(
                employee: employee,
                type: type,
                ref: ref,
                isEditing: isEditing,
                genderList: response?.response?.gender,
              ),

              ///STATUS + PHONE NUMBER ONLY FOR ORGANIZATION
              if (type == PayeesType.ORGANIZATION)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      StreamBuilder<GenericIdValueModel?>(
                          stream: selectedPayeeStatus.stream,
                          builder: (context, snapshot) {
                            return Expanded(
                                child: DataChooseWidget(
                              title: "Status*",
                              value: selectedPayeeStatus.state?.name ??
                                  employee?.employeeStatusName,
                              onPress: () {
                                if (isEditing) {
                                  BottomSheetChooseGeneralModal.show(
                                    context,
                                    "Choose Status",
                                    response?.response?.status,
                                    selectedPayeeStatus.state,
                                    userDetails,
                                    (p0) {
                                      ref
                                          .watch(selectedPayeeStatusProvider
                                              .notifier)
                                          .state = p0;
                                    },
                                  );
                                }
                              },
                            ));
                          }),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: DataTextInputWidget(
                        isEditing: isEditing,
                        title: "Phone Number*",
                        textInputType: TextInputType.number,
                        maxLength: 15,
                        controller: phoneNumberController,
                        onChanged: (value) {},
                        value: employee?.homePhone ?? "",
                      )),
                    ],
                  ),
                ),

              /// EMAIL
              const SizedBox(
                height: 8,
              ),
              DataTextInputWidget(
                isEditing: isEditing,
                controller: emailController,
                onChanged: (value) {},
                title: "Email*",
                textInputType: TextInputType.emailAddress,
                value: employee?.email,
              ),

              ///CONSUMER NUMBER + PHONE NUMBER ONLY FOR THIRD PARTY PROVIDER
              if (type == PayeesType.THIRD_PARTY_PROVIDER)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Expanded(
                          child: DataTextInputWidget(
                        isEditing: isEditing,
                        title: "Phone Number",
                        textInputType: TextInputType.number,
                        maxLength: 15,
                        controller: phoneNumberController,
                        onChanged: (value) {},
                        value: employee?.homePhone ?? "",
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: DataTextInputWidget(
                          isEditing: isEditing,
                          title: "Customer Number",
                          controller: customerNumberController,
                          onChanged: (value) {},
                          value: employee?.employeeCode ?? "",
                        ),
                      ),
                    ],
                  ),
                ),

              /// Address
              const SizedBox(
                height: 8,
              ),
              StreamBuilder<String?>(
                  stream: selectedAddressProvider.stream,
                  builder: (context, snapshot) {
                    return DataChooseWidget(
                      title: "Address*",
                      value: selectedAddressProvider.state ??
                          employee?.fullAddress ??
                          "Search",
                      onPress: () {
                        ref.watch(manuallyAddressPayeeProvider.notifier).state =
                            false;
                        BottomSheetSearchModal.show(
                            context,
                            selectedAddressProvider.state ??
                                employee?.fullAddress ??
                                "",
                            nzPostAuthTokenResponse,
                            (p0) => {console("Selected address - $p0")});
                      },
                    );
                  }),

              /// Region
              if (type != PayeesType.CONTRACTOR &&
                  type != PayeesType.ORGANIZATION &&
                  type != PayeesType.THIRD_PARTY_PROVIDER)
                StreamBuilder<GenericIdValueModel?>(
                    stream: selectedPayeeRegion.stream,
                    builder: (context, snapshot) {
                      return Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: DataChooseWidget(
                          title: "Region*",
                          value: ref
                                  .watch(selectedPayeeRegionProvider.notifier)
                                  .state
                                  ?.name ??
                              employee?.regionContentList,
                          onPress: () {
                            if (isEditing) {
                              BottomSheetChooseGeneralModal.show(
                                context,
                                "Choose Region",
                                response?.response?.region,
                                snapshot.data,
                                userDetails,
                                (p0) {
                                  console("REGION -> ${p0?.name}");
                                  ref
                                      .watch(
                                          selectedPayeeRegionProvider.notifier)
                                      .state = p0;
                                },
                              );
                            }
                          },
                        ),
                      );
                    }),

              ///IRD NUMBER + PHONE NUMBER
              if (type != PayeesType.ORGANIZATION &&
                  type != PayeesType.THIRD_PARTY_PROVIDER)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: DataTextInputWidget(
                          isEditing: isEditing,
                          controller: irdNumberController,
                          onChanged: (value) {
                            String formattedText = formatTextWithHyphens(value);
                            irdNumberController.text = formattedText;
                            irdNumberController.selection =
                                TextSelection.fromPosition(
                                    TextPosition(offset: formattedText.length));
                          },
                          title: "IRD Number*",
                          textInputType: TextInputType.number,
                          maxLength: 11,
                          value: employee?.irdNumber,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: DataTextInputWidget(
                        isEditing: isEditing,
                        controller: phoneNumberController,
                        onChanged: (value) {},
                        title: "Phone Number",
                        textInputType: TextInputType.number,
                        maxLength: 15,
                        value: employee?.homePhone ?? "",
                      )),
                    ],
                  ),
                ),

              /// Status
              if (type != PayeesType.ORGANIZATION)
                StreamBuilder<GenericIdValueModel?>(
                    stream: selectedPayeeStatus.stream,
                    builder: (context, snapshot) {
                      return Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: DataChooseWidget(
                          title: "Status*",
                          value: selectedPayeeStatus.state?.name ??
                              employee?.employeeStatusName,
                          onPress: () {
                            if (isEditing) {
                              BottomSheetChooseGeneralModal.show(
                                context,
                                "Choose Status",
                                response?.response?.status,
                                selectedPayeeStatus.state,
                                userDetails,
                                (p0) {
                                  ref
                                      .watch(
                                          selectedPayeeStatusProvider.notifier)
                                      .state = p0;
                                },
                              );
                            }
                          },
                        ),
                      );
                    }),

              ///INVITE TO PORTAL + PRIVACY NOTICE SIGNED
              if (type != PayeesType.ORGANIZATION &&
                  type != PayeesType.THIRD_PARTY_PROVIDER)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      if (type != PayeesType.CONTRACTOR)
                        Expanded(
                            child: DataSwitchWidget(
                          onChanged: (value) {},
                          isEditing: isEditing,
                          title: "Invite to Portal",
                          isSelected: employee?.inviteToPortal ?? false,
                        )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: DataSwitchWidget(
                        title: "Privacy Notice Signed",
                        isEditing: isEditing,
                        onChanged: (value) {},
                        isSelected: employee?.inviteToPortal ?? false,
                      )),
                    ],
                  ),
                ),
            ],
          ),
        ),

        ///PAYEES PAYROLL INFO
        PayeesPayrollInfoWidget(
            employee: employee,
            type: type,
            ref: ref,
            response: response,
            isEditing: isEditing),

        ///MANDATORY FORM FOR ONLY NEW PAYEE
        if (mandatoryTrueDocuments?.isNotEmpty == true && isEditing)
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 16, bottom: 16),
                child: const SectionTitle(
                  title: "Mandatory Forms",
                  iconData: Icons.help,
                ),
              ),
              ListView.builder(
                itemCount: mandatoryTrueDocuments?.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return DocumentFormWidget(
                      item: mandatoryTrueDocuments?[index]);
                },
              ),
            ],
          ),

        ///OPTIONAL FORM FOR ONLY NEW PAYEE
        if (mandatoryFalseDocuments?.isNotEmpty == true && isEditing)
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 16, bottom: 16),
                child: const SectionTitle(
                  title: "Optional Forms",
                  iconData: Icons.help,
                ),
              ),
              ListView.builder(
                itemCount: mandatoryFalseDocuments?.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return DocumentFormWidget(
                      item: mandatoryFalseDocuments?[index]);
                },
              ),
            ],
          ),

        ///SELECTED PAYEE DOCUMENTS
        PayeeSelectedDocumentsWidget(employee: employee, isEditing: isEditing),
      ],
    );
  }
}

class PayeeSelectedDocumentsWidget extends ConsumerWidget {
  const PayeeSelectedDocumentsWidget(
      {super.key, required this.employee, required this.isEditing});

  final EmployByModel? employee;
  final bool isEditing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPayeeDocument = ref.watch(selectedDocumentsProvider.notifier);
    return StreamBuilder<List<EmployeeDocumentsItem?>>(
        stream: selectedPayeeDocument.stream,
        builder: (context, snapshot) {
          console("snapshot -> ${snapshot.data?.length}");
          if (snapshot.hasData) {
            return Consumer(
              builder: (context, ref, child) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 16, bottom: 16),
                        child: const SectionTitle(
                          title: "Uploaded Files",
                          iconData: Icons.help,
                        ),
                      ),
                      ListView.builder(
                        itemCount: snapshot.data?.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: Colors.black, // Border color
                                  width: 0.05, // Border width
                                )),
                            child: ListTile(
                              onTap: () {
                                openFile(snapshot.data?[index]?.selectedFile);
                              },
                              leading:
                                  const Icon(Icons.document_scanner_outlined),
                              title: TextView(
                                  text: snapshot.data?[index]?.documentTitle ??
                                      "",
                                  textColor: Colors.black,
                                  textFontWeight: FontWeight.normal,
                                  fontSize: 16),
                              trailing: const Icon(Icons.remove_red_eye),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            );
          } else {
            if (employee?.documents?.isNotEmpty == true) {
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16, bottom: 16),
                    child: const SectionTitle(
                      title: "Uploaded Files",
                      iconData: Icons.help,
                    ),
                  ),
                  ListView.builder(
                    itemCount: employee?.documents?.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var item = employee?.documents?[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Colors.black, // Border color
                              width: 0.05, // Border width
                            )),
                        child: ListTile(
                          onTap: () {
                            // openFile(
                            //     snapshot.data?[index]?.selectedFile);
                          },
                          leading: const Icon(Icons.document_scanner_outlined),
                          title: TextView(
                              text: item?.documentTitle ?? "",
                              textColor: Colors.black,
                              textFontWeight: FontWeight.normal,
                              fontSize: 16),
                          trailing: const Icon(Icons.remove_red_eye),
                        ),
                      );
                    },
                  ),
                ],
              );
            } else {
              return Container();
            }
          }
        });
  }
}

class PayeesNameWidget extends StatelessWidget {
  const PayeesNameWidget({
    super.key,
    required this.employee,
    required this.type,
    required this.isEditing,
  });

  final EmployByModel? employee;
  final PayeesType? type;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    if (type != PayeesType.ORGANIZATION &&
        type != PayeesType.THIRD_PARTY_PROVIDER) {
      // FIRST AND LAST NAME
      return Row(
        children: [
          Expanded(
              child: DataTextInputWidget(
            isEditing: isEditing,
            title: "First Name*",
            textInputType: TextInputType.text,
            controller: firstNameController,
            onChanged: (value) {},
            value: employee?.firstName ?? "",
          )),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: DataTextInputWidget(
            isEditing: isEditing,
            title: "Last Name*",
            textInputType: TextInputType.text,
            onChanged: (e) {},
            controller: lastNameController,
            value: employee?.lastName,
          )),
        ],
      );
    }
    if (type == PayeesType.ORGANIZATION) {
      return DataTextInputWidget(
        isEditing: isEditing,
        title: "Name*",
        textInputType: TextInputType.text,
        controller: nameController,
        onChanged: (value) {},
        value: employee?.fullName ?? "",
      );
    }

    return Container();
  }
}

class PayeesGenderKnownAsWidget extends StatelessWidget {
  const PayeesGenderKnownAsWidget(
      {super.key,
      required this.employee,
      required this.type,
      required this.isEditing,
      required this.ref,
      required this.genderList});

  final EmployByModel? employee;
  final PayeesType? type;
  final bool isEditing;
  final WidgetRef ref;
  final List<GenericIdValueModel>? genderList;

  @override
  Widget build(BuildContext context) {
    final selectedGenderProvider =
        ref.watch(selectedPayeeGenderProvider.notifier);
    final userDetails = ref.watch(userDetailsProvider);
    if (type != PayeesType.CONTRACTOR &&
        type != PayeesType.ORGANIZATION &&
        type != PayeesType.THIRD_PARTY_PROVIDER) {
      return Container(
        margin: const EdgeInsets.only(top: 8),
        child: Row(
          children: [
            StreamBuilder<GenericIdValueModel?>(
                stream: selectedGenderProvider.stream,
                builder: (context, snapshot) {
                  return Expanded(
                      child: DataChooseWidget(
                    title: "Gender",
                    value: selectedGenderProvider.state?.name ??
                        employee?.genderContentList,
                    onPress: () {
                      if (isEditing) {
                        BottomSheetChooseGeneralModal.show(
                          context,
                          "Choose Gender",
                          genderList,
                          selectedGenderProvider.state,
                          userDetails,
                          (p0) {
                            ref
                                .watch(selectedPayeeGenderProvider.notifier)
                                .state = p0;
                          },
                        );
                      }
                    },
                  ));
                }),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: DataTextInputWidget(
              isEditing: isEditing,
              controller: knownAsController,
              onChanged: (value) {},
              title: "Known As",
              textInputType: TextInputType.text,
              value: employee?.knownAs,
            )),
          ],
        ),
      );
    }

    return Container();
  }
}

class PayeesDobTitleWidget extends StatelessWidget {
  const PayeesDobTitleWidget(
      {super.key,
      required this.employee,
      required this.type,
      required this.isEditing,
      required this.ref,
      required this.list});

  final EmployByModel? employee;
  final PayeesType? type;
  final bool isEditing;
  final WidgetRef ref;
  final List<GenericIdValueModel>? list;

  @override
  Widget build(BuildContext context) {
    final selectedPayeeTitleNotifier =
        ref.watch(selectedPayeeTitleProvider.notifier);
    final selectedPayeeDateOfBirth =
        ref.watch(selectedPayeeDateOfBirthProvider.notifier);
    final userDetails = ref.watch(userDetailsProvider);
    if (type != PayeesType.ORGANIZATION &&
        type != PayeesType.THIRD_PARTY_PROVIDER) {
      return Container(
        margin: const EdgeInsets.only(top: 8),
        child: Row(
          children: [
            StreamBuilder<DateTime?>(
                stream: selectedPayeeDateOfBirth.stream,
                builder: (context, snapshot) {
                  return Expanded(
                      child: DataChooseWidget(
                    title: "Date of Birth*",
                    value: selectedPayeeDateOfBirth.state
                            ?.convertDateToMMDDYYYY() ??
                        employee?.dateofBirth?.convertStringDateToMMMDDYYY(),
                    onPress: () {
                      if (isEditing) {
                        customDatePicker(
                          context,
                          employee?.dateofBirth ??
                              DateTime.now().convertDateToMMDDYYYY(),
                          (pickedTime) {
                            ref
                                .watch(
                                    selectedPayeeDateOfBirthProvider.notifier)
                                .state = pickedTime;
                          },
                        );
                      }
                    },
                  ));
                }),
            const SizedBox(
              width: 10,
            ),
            if (type != PayeesType.CONTRACTOR)
              StreamBuilder<GenericIdValueModel?>(
                  stream: selectedPayeeTitleNotifier.stream,
                  builder: (context, snapshot) {
                    return Expanded(
                        child: DataChooseWidget(
                      title: "Title",
                      value: selectedPayeeTitleNotifier.state?.name ??
                          employee?.titleContentList,
                      onPress: () {
                        if (isEditing) {
                          BottomSheetChooseGeneralModal.show(
                            context,
                            "Choose Title",
                            list,
                            selectedPayeeTitleNotifier.state,
                            userDetails,
                            (p0) {
                              ref
                                  .watch(selectedPayeeTitleProvider.notifier)
                                  .state = p0;
                            },
                          );
                        }
                      },
                    ));
                  }),
          ],
        ),
      );
    }
    return Container();
  }
}

class PayeesPayrollInfoWidget extends StatelessWidget {
  const PayeesPayrollInfoWidget({
    super.key,
    required this.employee,
    required this.type,
    required this.response,
    required this.ref,
    required this.isEditing,
  });

  final EmployByModel? employee;
  final PayeesType? type;
  final bool isEditing;
  final WidgetRef ref;
  final GetEmployeePayeeInitialsResponse? response;

  @override
  Widget build(BuildContext context) {
    final selectedPayeeStartDateState =
        ref.watch(selectedPayeeStartDateProvider.notifier);
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
                      StreamBuilder<DateTime?>(
                          stream: selectedPayeeStartDateState.stream,
                          builder: (context, snapshot) {
                            return Expanded(
                                child: DataChooseWidget(
                              title: "Start Date*",
                              value: selectedPayeeStartDateState.state
                                      ?.convertDateToMMDDYYYY() ??
                                  employee?.startDate,
                              onPress: () {
                                if (isEditing) {
                                  customDatePicker(
                                    context,
                                    selectedPayeeStartDateState.state
                                            ?.convertDateToMMDDYYYY() ??
                                        employee?.dateofBirth ??
                                        DateTime.now().convertDateToMMDDYYYY(),
                                    (pickedTime) {
                                      ref
                                          .watch(selectedPayeeStartDateProvider
                                              .notifier)
                                          .state = pickedTime;
                                    },
                                  );
                                }
                              },
                            ));
                          }),
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
                        textInputType: TextInputType.number,
                        title: "Child Support Amount",
                        value: "${employee?.childSupportAmount ?? ""}",
                      ),
                    ),

                  ///BANK ACCOUNT NUMBER
                  const SizedBox(
                    height: 8,
                  ),
                  CustomBankAccountTextInputWidget(
                    isEditing: isEditing,
                    controllerBankAccountNumber: bankAccountController,
                    controllerBankBranch: bankBranchController,
                    controllerBankCompany: bankCompanyController,
                    controllerBankSuffix: bankSuffixController,
                    onChanged: (value) {},
                    title: "Bank Account Number*",
                    textInputType: TextInputType.number,
                    valueCompany: employee?.bankCompany.toString() ?? "",
                    valueBranch: employee?.bankBranch.toString() ?? "",
                    valueSuffix: employee?.bankSuffix.toString() ?? "",
                    valueAccountNumber:
                        employee?.bankAccountNumber.toString() ?? "",
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
                              textInputType: TextInputType.number,
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
                              textInputType: TextInputType.number,
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
                              textInputType: TextInputType.number,
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
                        textInputType: TextInputType.number,
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
