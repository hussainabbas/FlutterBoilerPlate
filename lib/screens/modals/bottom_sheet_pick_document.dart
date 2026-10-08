import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manawanui/core/providers/payee_providers.dart';
import 'package:manawanui/data/models/get_employee_documents_response.dart';
import 'package:manawanui/data/models/get_employee_payee_initials_response.dart';
import 'package:manawanui/helpers/extension/context_function.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';
import 'package:manawanui/widgets/text_view.dart';

class BottomSheetPickDocument {
  static void show(
    BuildContext context,
    String title,
    EmployeeDocumentsItem? item,
    Function(GenericIdValueModel?) onSelect,
  ) {
    showModalBottomSheet(
        barrierLabel: title,
        barrierColor: Colors.black.withOpacity(0.5),
        context: context,
        builder: (BuildContext context) {
          return Consumer(
            builder: (context, ref, child) {
              Future<void> pickImage() async {
                final picker = ImagePicker();
                final pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);

                if (pickedFile != null) {
                  item?.isPicked = true;
                  item?.selectedFile = pickedFile;
                  item?.selectedFileBase64 = await xFileToBase64(pickedFile);
                  item?.documentTitle = pickedFile.name;
                  item?.documentType = pickedFile.mimeType;
                  final selectedList = ref.watch(selectedDocumentsProvider);

                  ref.watch(selectedDocumentsProvider.notifier).state = [
                    ...selectedList,
                    item
                  ];
                  console(
                      "selectedDocumentsProvider -> ${ref.watch(selectedDocumentsProvider.notifier).state.length}");
                  if (context.mounted) context.pop();
                } else {}
              }

              Future<void> pickDocument() async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();

                if (result != null) {
                  PlatformFile file = result.files.first;
                  XFile xFile = XFile(file.path ?? "");
                  item?.isPicked = true;
                  item?.selectedFile = xFile;
                  item?.selectedFileBase64 = await xFileToBase64(xFile);
                  final selectedList = ref.watch(selectedDocumentsProvider);
                  ref.watch(selectedDocumentsProvider.notifier).state = [
                    ...selectedList,
                    item
                  ];
                  //ref.watch(selectedPayeeDocumentProvider.notifier).state = item;
                  if (context.mounted) context.pop();
                } else {
                  // User canceled the document picking operation.
                }
              }

              return Container(
                color: Colors.white,
                height: context.fullHeight(multiplier: 0.3),
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: Column(
                  children: [
                    TextView(
                        text: title,
                        textColor: AppColors.primaryColor,
                        textFontWeight: FontWeight.bold,
                        fontSize: 16),
                    const Divider(
                      color: Colors.grey,
                      height: 24,
                    ),
                    ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      onTap: () {
                        pickImage();
                      },
                      title: const TextView(
                        text: "Pick an Image",
                        textColor: Colors.black,
                        textFontWeight: FontWeight.normal,
                        fontSize: 16,
                        align: TextAlign.center,
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      onTap: () {
                        pickDocument();
                      },
                      title: const TextView(
                        text: "Pick a File",
                        textColor: Colors.black,
                        textFontWeight: FontWeight.normal,
                        fontSize: 16,
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
