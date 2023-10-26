import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/core/providers/auth_providers.dart';
import 'package:manawanui/core/providers/payee_providers.dart';
import 'package:manawanui/helpers/extension/context_function.dart';
import 'package:manawanui/helpers/extension/widget_ref_functions.dart';
import 'package:manawanui/helpers/resources/api_param_keys.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/helpers/resources/strings.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';
import 'package:manawanui/widgets/text_view.dart';

class PayeeTypeWidget extends ConsumerWidget {
  final IconData? iconData;
  final String title;
  final bool? isEditable;

  const PayeeTypeWidget(
      {super.key, required this.title, this.iconData, this.isEditable = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(payeesViewModelProvider);
    final nzViewModel = ref.watch(nzPostViewModelProvider);
    final userDetails = ref.watch(userDetailsProvider);

    getEmployeeDocumentTypeBy() async {
      var body = {
        ApiParamKeys.KEY_USER_ID_SMALL: userDetails?.userId ?? "",
        ApiParamKeys.KEY_EMPLOYEE_TYPE_CODE: getEmployeeType(title),
        ApiParamKeys.KEY_IS_SELF_MANAGED: userDetails?.isSelfManaged ?? "",
        ApiParamKeys.KEY_EMPLOYEE_ID: userDetails?.employeeId ?? "0",
      };
      await viewModel.getEmployeeDocumentTypeBy(body);
    }

    getEmployeePayeeInitials() async {
      var body = {
        ApiParamKeys.KEY_USER_ID_SMALL: userDetails?.userId ?? "",
        ApiParamKeys.KEY_EMPLOYER_ID: userDetails?.employerId ?? "",
        ApiParamKeys.KEY_USER_ROLE: userDetails?.roleCode ?? "",
        ApiParamKeys.KEY_IS_SELF_MANAGED: userDetails?.isSelfManaged ?? "",
        ApiParamKeys.KEY_EMPLOYEE_TYPE: getEmployeeType(title),
      };
      await viewModel.getEmployeePayeeInitials(body);
      getEmployeeDocumentTypeBy();
    }

    getNzPostAuthToken() async {
      var body = {
        ApiParamKeys.KEY_CLIENT_ID_NZ: StringResources.CLIENT_ID,
        ApiParamKeys.KEY_CLIENT_SECRET_NZ: StringResources.CLIENT_SECRET,
        ApiParamKeys.KEY_GRANT_TYPE_NZ: StringResources.GRANT_TYPE,
      };
      await nzViewModel.getNzPostAuthToken(body);
      getEmployeePayeeInitials();
    }

    return GestureDetector(
      onTap: () async {
        if (isEditable == true) {
          if (ref.watch(selectedPayeeProvider.notifier).state != null) {
            context.showConfirmationDialog("Warning!",
                "Do you wish to leave this page and discard changes?",
                () async {
              getNzPostAuthToken();
              ref.watch(selectedPayeeProvider.notifier).state =
                  PayeeTypeWidget(title: title, iconData: iconData);
              ref.invalidateSelectedPayeesFieldsProvider();
            });
          } else {
            getNzPostAuthToken();
            ref.watch(selectedPayeeProvider.notifier).state =
                PayeeTypeWidget(title: title, iconData: iconData);
            ref.invalidateSelectedPayeesFieldsProvider();
          }
        }
      },
      child: SizedBox(
          width: context.fullWidth(multiplier: 0.18),
          child: Consumer(
            builder: (context, ref, child) {
              final selectedPayee = ref.watch(selectedPayeeProvider);
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                        border: Border.all(
                            color: selectedPayee?.title == title
                                ? AppColors.primaryColor
                                : Colors.white,
                            width: 1.0)),
                    child: Icon(
                      iconData,
                      color: selectedPayee?.title == title
                          ? AppColors.primaryColor
                          : Colors.black,
                    ),
                  ),
                  Expanded(
                    child: TextView(
                        text: title,
                        align: TextAlign.center,
                        textColor: selectedPayee?.title == title
                            ? AppColors.primaryColor
                            : Colors.black,
                        textFontWeight: FontWeight.normal,
                        fontSize: 12),
                  )
                ],
              );
            },
          )),
    );
  }
}
