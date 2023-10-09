import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/helpers/extension/context_function.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/helpers/resources/image_resources.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';
import 'package:manawanui/widgets/custom_app_bar.dart';
import 'package:manawanui/widgets/text_view.dart';

class ContactUsMenuScreen extends HookConsumerWidget {
  const ContactUsMenuScreen({super.key, required this.showAppBar});

  final bool showAppBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    console("showAppBar => $showAppBar");
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: showAppBar == true
          ? customAppBar(() {
              context.pop();
            }, "Contact Us")
          : null,
      body: Container(
        padding: const EdgeInsets.all(16),
        height: context.fullHeight(multiplier: 0.89),
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 0.2)),
              width: context.fullWidth(multiplier: kIsWeb ? 0.25 : 0.7),
              height: context.fullHeight(multiplier: 0.70),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 0.2)),
              width: context.fullWidth(multiplier: kIsWeb ? 0.27 : 0.8),
              height: context.fullHeight(multiplier: 0.68),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 0.2)),
              width: context.fullWidth(multiplier: kIsWeb ? 0.29 : 0.8),
              height: context.fullHeight(multiplier: 0.66),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageResources.LOGO_MANA,
                        width: 80,
                      ),
                      TextView(
                          align: TextAlign.center,
                          text: "Contact Information",
                          textColor: AppColors.primaryColor,
                          textFontWeight: FontWeight.w500,
                          fontSize: 16),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextView(
                            align: TextAlign.center,
                            text: "For Technical Support",
                            textColor: AppColors.primaryColor,
                            textFontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        leading: const Icon(Icons.pin_drop),
                        title: const TextView(
                            text: "1 Parkhead Place 0632 Auckland, New Zealand",
                            textColor: Colors.black,
                            textFontWeight: FontWeight.normal,
                            fontSize: 14),
                        subtitle: TextView(
                            text: "View on map",
                            textColor: AppColors.primaryColor,
                            textFontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        leading: const Icon(Icons.phone),
                        title: const TextView(
                            text: "Call us at (0508 462 427)",
                            textColor: Colors.black,
                            textFontWeight: FontWeight.normal,
                            fontSize: 14),
                        subtitle: TextView(
                            text: "Make a call",
                            textColor: AppColors.primaryColor,
                            textFontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        leading: const Icon(Icons.email),
                        title: const TextView(
                            text: "cec@manawanui.org.nz",
                            textColor: Colors.black,
                            textFontWeight: FontWeight.normal,
                            fontSize: 14),
                        subtitle: TextView(
                            text: "Email us your Query",
                            textColor: AppColors.primaryColor,
                            textFontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        leading: const Icon(Icons.web),
                        title: const TextView(
                            text: "Link to the website",
                            textColor: Colors.black,
                            textFontWeight: FontWeight.normal,
                            fontSize: 14),
                        subtitle: TextView(
                            text: "Visit Website",
                            textColor: AppColors.primaryColor,
                            textFontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        leading: const Icon(Icons.phone),
                        title: const TextView(
                            text: "App Version",
                            textColor: Colors.black,
                            textFontWeight: FontWeight.normal,
                            fontSize: 14),
                        subtitle: TextView(
                            text: "5.0.0",
                            textColor: AppColors.primaryColor,
                            textFontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextView(
                          text: "Social Profiles",
                          textColor: AppColors.primaryColor,
                          textFontWeight: FontWeight.w500,
                          fontSize: 16),
                      const SizedBox(
                        height: 8,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.sensor_occupied),
                          Icon(Icons.sensor_occupied),
                          Icon(Icons.sensor_occupied),
                          Icon(Icons.sensor_occupied),
                          Icon(Icons.sensor_occupied),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: TextView(
                              text: "Privacy Policy",
                              textColor: AppColors.primaryColor,
                              textFontWeight: FontWeight.normal,
                              isUnderLine: true,
                              fontSize: 16)),
                      const SizedBox(
                        height: 8,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: TextView(
                              text: "Terms & conditions",
                              textColor: AppColors.primaryColor,
                              textFontWeight: FontWeight.normal,
                              isUnderLine: true,
                              fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
