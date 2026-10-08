import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manawanui/core/providers/payee_providers.dart';
import 'package:manawanui/data/models/get_employee_documents_response.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';
import 'package:manawanui/screens/modals/bottom_sheet_pick_document.dart';
import 'package:manawanui/widgets/text_view.dart';

class DocumentFormWidget extends ConsumerWidget {
  const DocumentFormWidget({super.key, required this.item});

  final EmployeeDocumentsItem? item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPayeeDocument = ref.watch(selectedDocumentsProvider.notifier);
    return GestureDetector(
      onTap: () {
        BottomSheetPickDocument.show(context, "Options", item, (p0) {});
      },
      child: StreamBuilder<List<EmployeeDocumentsItem?>>(
          stream: selectedPayeeDocument.stream,
          builder: (context, snapshot) {
            console("snapshot -> ${snapshot.data?.length}");
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
              child: Row(
                children: [
                  Expanded(
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
                                child: GestureDetector(
                              onTap: () {
                                if (item?.urlLink != null ||
                                    item?.urlLink?.isNotEmpty == true) {
                                  openURL(item?.urlLink ?? "");
                                }
                              },
                              child: TextView(
                                  text: "(download form)",
                                  textColor: AppColors.primaryColor,
                                  textFontWeight: FontWeight.normal,
                                  fontSize: 16),
                            )),
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
                                TextView(
                                    text: item?.name ?? "",
                                    textColor: Colors.black,
                                    textFontWeight: FontWeight.normal,
                                    fontSize: 16),
                                const SizedBox(
                                  height: 4,
                                ),
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
                  ),
                  if (snapshot.data?.contains(item) == true)
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )
                ],
              ),
            );
          }),
    );
  }
}
