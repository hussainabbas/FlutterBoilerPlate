import 'package:flutter/material.dart';
import 'package:manawanui/widgets/simple_text_input.dart';
import 'package:manawanui/widgets/text_view.dart';

class CustomBankAccountTextInputWidget extends StatelessWidget {
  const CustomBankAccountTextInputWidget(
      {super.key,
      required this.title,
      this.valueCompany,
      this.valueBranch,
      this.valueAccountNumber,
      this.valueSuffix,
      required this.controllerBankCompany,
      required this.controllerBankBranch,
      required this.controllerBankAccountNumber,
      required this.controllerBankSuffix,
      required this.onChanged,
      required this.isEditing,
      this.textInputType,
      this.maxLength,
      this.error});

  final String title;
  final String? valueCompany;
  final String? valueBranch;
  final String? valueAccountNumber;
  final String? valueSuffix;
  final TextEditingController controllerBankCompany;
  final TextEditingController controllerBankBranch;
  final TextEditingController controllerBankAccountNumber;
  final TextEditingController controllerBankSuffix;
  final String? error;
  final bool isEditing;
  final ValueChanged<String> onChanged;
  final TextInputType? textInputType;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    controllerBankCompany.text = valueCompany ?? "";
    controllerBankBranch.text = valueBranch ?? "";
    controllerBankAccountNumber.text = valueAccountNumber ?? "";
    controllerBankSuffix.text = valueSuffix ?? "";
    FocusNode focusNode1 = FocusNode();
    FocusNode focusNode2 = FocusNode();
    FocusNode focusNode3 = FocusNode();
    FocusNode focusNode4 = FocusNode();
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.black, // Border color
            width: 0.05, // Border width
          ), // Border radius to make it rounded
        ),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextView(
                      text: title,
                      textColor: Colors.black,
                      textFontWeight: FontWeight.normal,
                      fontSize: 14),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.1),
                              borderRadius: BorderRadius.circular(8)),
                          child: SimpleTextField(
                            isEditable: isEditing,
                            controller: controllerBankCompany,
                            maxLength: 2,
                            hint: "00",
                            focusNode: focusNode1,
                            textInputType: textInputType,
                            onChanged: (e) {
                              onChanged(e);
                              if (e.length >= 2 && focusNode2 != null) {
                                FocusScope.of(context).requestFocus(focusNode2);
                              }
                            },
                            errorMessage: error,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.1),
                              borderRadius: BorderRadius.circular(8)),
                          child: SimpleTextField(
                            isEditable: isEditing,
                            controller: controllerBankBranch,
                            maxLength: 4,
                            focusNode: focusNode2,
                            hint: "0000",
                            textInputType: textInputType,
                            onChanged: (e) {
                              onChanged(e);
                              if (e.length >= 4 && focusNode3 != null) {
                                FocusScope.of(context).requestFocus(focusNode3);
                              }
                            },
                            errorMessage: error,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.1),
                              borderRadius: BorderRadius.circular(8)),
                          child: SimpleTextField(
                            isEditable: isEditing,
                            controller: controllerBankAccountNumber,
                            maxLength: 7,
                            focusNode: focusNode3,
                            textInputType: textInputType,
                            hint: "0000000",
                            onChanged: (e) {
                              onChanged(e);
                              if (e.length >= 7 && focusNode4 != null) {
                                FocusScope.of(context).requestFocus(focusNode4);
                              }
                            },
                            errorMessage: error,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.1),
                              borderRadius: BorderRadius.circular(8)),
                          child: SimpleTextField(
                            isEditable: isEditing,
                            controller: controllerBankSuffix,
                            maxLength: 3,
                            focusNode: focusNode4,
                            hint: "000",
                            textInputType: textInputType,
                            onChanged: (e) {
                              onChanged(e);
                            },
                            errorMessage: error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Positioned(
                right: 0,
                child: Opacity(opacity: 0.07, child: Icon(Icons.person_pin)))
          ],
        ),
      ),
    );
  }
}
