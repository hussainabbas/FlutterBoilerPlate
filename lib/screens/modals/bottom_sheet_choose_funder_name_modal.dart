import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manawanui/data/models/funder_model.dart';
import 'package:manawanui/data/models/user_details_response.dart';
import 'package:manawanui/helpers/extension/context_function.dart';
import 'package:manawanui/helpers/resources/api_param_keys.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/screens/mobile/dashboard/dashboard_view_model.dart';
import 'package:manawanui/widgets/text_view.dart';

class BottomSheetChooseFunderNameModal {
  static void show(
      BuildContext context,
      List<FunderModel>? list,
      FunderModel selectedCategory,
      DashboardViewModel viewModel,
      UserDetailsResponse? userDetails) {
    showModalBottomSheet(
        barrierLabel: "Funder Name",
        barrierColor: Colors.black.withOpacity(0.5),
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Column(
              children: [
                TextView(
                    text: "Choose Funder Name",
                    textColor: AppColors.primaryColor,
                    textFontWeight: FontWeight.bold,
                    fontSize: 16),
                const Divider(
                  color: Colors.grey,
                  height: 24,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: list?.length,
                    itemBuilder: (context, index) {
                      final category = list?[index];
                      return ListTile(
                        onTap: () async {
                          if (context.mounted) context.showProgressDialog();
                          await viewModel.getStatementNew({
                            ApiParamKeys.KEY_USER_ID_SMALL:
                                userDetails?.userId ?? "",
                            ApiParamKeys.KEY_EMPLOYER_ID:
                                userDetails?.employerId ?? "",
                            ApiParamKeys.KEY_IS_SELF_MANAGED:
                                userDetails?.isSelfManaged ?? false,
                            ApiParamKeys.KEY_SUPPORT_PLAN_ID: category?.id ?? ""
                          });
                          if (context.mounted) {
                            // Navigator.pop(context);
                            // Navigator.pop(context);
                            context.pop();
                            context.pop();
                          }
                        },
                        title: Text(category?.name ?? ""),
                        leading: Radio<String>(
                          value: category?.name ?? "",
                          groupValue: selectedCategory.name,
                          onChanged: (value) {},
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
