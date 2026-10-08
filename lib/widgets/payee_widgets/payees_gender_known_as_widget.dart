import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manawanui/core/providers/auth_providers.dart';
import 'package:manawanui/core/providers/payee_providers.dart';
import 'package:manawanui/data/models/get_employ_by_response.dart';
import 'package:manawanui/data/models/get_employee_payee_initials_response.dart';
import 'package:manawanui/helpers/enums/payees_type.dart';
import 'package:manawanui/screens/modals/bottom_sheet_choose_general_modal.dart';
import 'package:manawanui/widgets/data_choose_widget.dart';
import 'package:manawanui/widgets/data_text_input_widget.dart';

class PayeesGenderKnownAsWidget extends StatelessWidget {
  const PayeesGenderKnownAsWidget(
      {super.key,
      required this.employee,
      required this.type,
      required this.isEditing,
      required this.ref,
      required this.genderList,
      required this.knownAsController});

  final EmployByModel? employee;
  final PayeesType? type;
  final bool isEditing;
  final WidgetRef ref;
  final List<GenericIdValueModel>? genderList;
  final TextEditingController knownAsController;

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(payeesViewModelProvider);
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
              value: employee?.knownAs,
            )),
          ],
        ),
      );
    }

    return Container();
  }
}
