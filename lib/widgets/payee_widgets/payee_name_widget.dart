import 'package:flutter/material.dart';
import 'package:manawanui/data/models/get_employ_by_response.dart';
import 'package:manawanui/helpers/enums/payees_type.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';
import 'package:manawanui/widgets/data_text_input_widget.dart';

class PayeesNameWidget extends StatelessWidget {
  const PayeesNameWidget(
      {super.key,
      required this.employee,
      required this.type,
      required this.isEditing,
      required this.firstNameController,
      required this.lastNameController,
      required this.nameController});

  final EmployByModel? employee;
  final PayeesType? type;
  final bool isEditing;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    console("ISEDITING => $isEditing");
    if (type != PayeesType.ORGANIZATION &&
        type != PayeesType.THIRD_PARTY_PROVIDER) {
      // FIRST AND LAST NAME
      return Row(
        children: [
          Expanded(
              child: DataTextInputWidget(
            isEditing: isEditing,
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
            isEditing: isEditing,
            title: "Last Name*",
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
        controller: nameController,
        onChanged: (value) {},
        value: employee?.fullName ?? "",
      );
    }
    if (type == PayeesType.THIRD_PARTY_PROVIDER) {
      return DataTextInputWidget(
        isEditing: isEditing,
        title: "Provider Name*",
        controller: nameController,
        onChanged: (value) {},
        value: employee?.fullName ?? "",
      );
    }

    return Container();
  }
}
