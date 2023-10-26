import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manawanui/core/providers/auth_providers.dart';
import 'package:manawanui/core/providers/payee_providers.dart';
import 'package:manawanui/data/models/get_employ_by_response.dart';
import 'package:manawanui/data/models/get_employee_payee_initials_response.dart';
import 'package:manawanui/helpers/enums/payees_type.dart';
import 'package:manawanui/helpers/extension/date_time_functions.dart';
import 'package:manawanui/helpers/extension/string_extensions.dart';
import 'package:manawanui/screens/modals/bottom_sheet_choose_general_modal.dart';
import 'package:manawanui/screens/modals/custom_date_picker.dart';
import 'package:manawanui/widgets/data_choose_widget.dart';

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
    final viewModel = ref.watch(payeesViewModelProvider);
    final selectedPayeeTitleNotifier =
        ref.watch(selectedPayeeTitleProvider.notifier);
    final selectedPayeeDateOfBirth =
        ref.watch(selectedPayeeDateOfBirthProvider);
    final userDetails = ref.watch(userDetailsProvider);
    if (type != PayeesType.ORGANIZATION &&
        type != PayeesType.THIRD_PARTY_PROVIDER) {
      return Container(
        margin: const EdgeInsets.only(top: 8),
        child: Row(
          children: [
            Expanded(
                child: DataChooseWidget(
              title: "Date of Birth*",
              value: selectedPayeeDateOfBirth?.convertDateToMMDDYYYY() ??
                  employee?.dateofBirth?.convertStringDateToMMMDDYYY(),
              onPress: () {
                if (isEditing) {
                  customDatePicker(
                    context,
                    employee?.dateofBirth ?? DateTime.now().toString(),
                    (pickedTime) {
                      ref
                          .watch(selectedPayeeDateOfBirthProvider.notifier)
                          .state = pickedTime;
                    },
                  );
                }
              },
            )),
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
