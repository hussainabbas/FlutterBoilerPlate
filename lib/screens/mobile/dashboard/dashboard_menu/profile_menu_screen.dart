import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/widgets/custom_text_field.dart';
import 'package:manawanui/widgets/section_title.dart';

class ProfileMenuScreen extends HookConsumerWidget {
  const ProfileMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Account Profile Details
              const SectionTitle(
                title: "Account Profile Details",
                iconData: Icons.edit,
              ),
              const SizedBox(
                height: 8,
              ),
              SectionTextFieldWithIcon(
                  controller: TextEditingController(),
                  title: "Login Email",
                  iconData: Icons.email_outlined),
              const SizedBox(
                height: 8,
              ),
              SectionTextFieldWithIcon(
                  controller: TextEditingController(),
                  title: "Mobile Number",
                  iconData: Icons.phone_android),
              const SizedBox(
                height: 8,
              ),
              SectionTextFieldWithIcon(
                  controller: TextEditingController(),
                  title: "First Name",
                  iconData: Icons.person),
              const SizedBox(
                height: 8,
              ),
              SectionTextFieldWithIcon(
                  controller: TextEditingController(),
                  title: "Last Name",
                  iconData: Icons.person),
              const SizedBox(
                height: 8,
              ),
              SectionTextFieldWithIcon(
                  controller: TextEditingController(),
                  title: "Preferred Name",
                  iconData: Icons.person),
              const SizedBox(
                height: 8,
              ),
              SectionTextFieldWithIcon(
                  controller: TextEditingController(),
                  title: "Login Emil",
                  iconData: Icons.email_outlined),
              // Coach Details
              const SizedBox(
                height: 16,
              ),
              const SectionTitle(
                title: "Coach Details",
                iconData: Icons.edit,
              ),
              const SizedBox(
                height: 8,
              ),
              SectionTextFieldWithIcon(
                  controller: TextEditingController(),
                  title: "Coach Name",
                  iconData: Icons.person),
              // Agent Details
              const SizedBox(
                height: 16,
              ),
              const SectionTitle(
                title: "Agent Details",
                iconData: Icons.edit,
              ),
              const SizedBox(
                height: 8,
              ),
              SectionTextFieldWithIcon(
                  controller: TextEditingController(),
                  title: "Agent Name",
                  iconData: Icons.person),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: SectionTextFieldWithIcon(
                          controller: TextEditingController(),
                          title: "Home Phone",
                          iconData: Icons.phone)),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: SectionTextFieldWithIcon(
                          controller: TextEditingController(),
                          title: "Mobile",
                          iconData: Icons.phone)),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              SectionTextFieldWithIcon(
                  controller: TextEditingController(),
                  title: "Email",
                  iconData: Icons.email_outlined),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: SectionTextFieldWithIcon(
                          controller: TextEditingController(),
                          title: "Business Phone",
                          iconData: Icons.email_outlined)),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: SectionTextFieldWithIcon(
                          controller: TextEditingController(),
                          title: "Region",
                          iconData: Icons.pin_drop)),
                ],
              ),
              // Contact Details
              const SizedBox(
                height: 16,
              ),
              const SectionTitle(
                title: "Contact Details",
                iconData: Icons.edit,
              ),
              const SizedBox(
                height: 8,
              ),
              SectionTextFieldWithIcon(
                  controller: TextEditingController(),
                  title: "Mailing Address",
                  iconData: Icons.quick_contacts_mail_outlined),
              const SizedBox(
                height: 8,
              ),
              SectionTextFieldWithIcon(
                  controller: TextEditingController(),
                  title: "Primary Email",
                  iconData: Icons.email_outlined),

              // Funding Plan
              const SizedBox(
                height: 16,
              ),
              const SectionTitle(
                title: "Funding Plan",
                iconData: Icons.edit,
              ),
              // Documents
              const SizedBox(
                height: 16,
              ),
              const SectionTitle(
                title: "Documents",
                iconData: Icons.edit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTextFieldWithIcon extends StatelessWidget {
  const SectionTextFieldWithIcon(
      {super.key,
      required this.controller,
      required this.title,
      required this.iconData});

  final TextEditingController controller;
  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        children: [
          Icon(
            iconData,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: CustomTextField(
                controller: controller,
                title: title,
                isContainBottomBorder: false,
                onChanged: (value) {}),
          )
        ],
      ),
    );
  }
}
