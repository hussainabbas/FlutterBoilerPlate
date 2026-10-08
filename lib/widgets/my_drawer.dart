import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:manawanui/data/models/drawer_item.dart';
import 'package:manawanui/data/models/user_details_response.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/helpers/resources/routes_resources.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';
import 'package:manawanui/screens/mobile/dashboard/dashboard_screen.dart';
import 'package:manawanui/widgets/text_view.dart';

class MyDrawer extends ConsumerWidget {
  final List<DrawerItem> drawerItems;
  final UserDetailsResponse? userDetails;
  final String? unreadCount;

  const MyDrawer(
      {super.key,
      required this.drawerItems,
      required this.userDetails,
      this.unreadCount});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider.notifier);
    return Drawer(
        child: Column(
      children: [
        UserAccountsDrawerHeader(
          accountName: TextView(
              text: "${userDetails?.firstName} ${userDetails?.lastName}",
              textColor: Colors.white,
              textFontWeight: FontWeight.bold,
              fontSize: 18),
          // Display the user's name
          accountEmail: TextView(
            text: getEmployerType(userDetails?.roleCode ?? ""),
            textColor: Colors.white,
            textFontWeight: FontWeight.normal,
            fontSize: 16,
          ),
          // Display the user's email
          currentAccountPicture: ClipOval(
            child: Image.memory(
              base64.decode(userDetails?.profilePicture ?? ""),
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: drawerItems.length,
            itemBuilder: (context, index) {
              final item = drawerItems[index];
              return ListTile(
                selectedColor: AppColors.primaryColor,
                selectedTileColor: AppColors.primaryColor42,
                leading: item.icon,
                selected: index == selectedIndex.state,
                title: Row(
                  children: [
                    TextView(
                        text: item.title,
                        textColor: Colors.black,
                        textFontWeight: FontWeight.normal,
                        fontSize: 16),
                    const SizedBox(
                      width: 8,
                    ),
                    if (item.title == 'Mail')
                      Badge(
                        label: TextView(
                            text: unreadCount ?? "",
                            textColor: Colors.white,
                            textFontWeight: FontWeight.normal,
                            fontSize: 12),
                      )
                  ],
                ),
                onTap: () async {
                  if (item.title == "Logout") {
                    logout(ref, context);
                  }
                  if (item.route != Routes.FORMS_RESOURCES &&
                      item.route != Routes.LOGOUT) {
                    ref.watch(selectedIndexProvider.notifier).state = index;
                  }
                  if (!kIsWeb) {
                    if (context.mounted)
                      context.pop(); //Navigator.pop(context);
                  }
                },
              );
            },
          ),
        ),
        const AboutListTile(
          // <-- SEE HERE
          icon: Icon(
            Icons.info,
          ),
          applicationIcon: Icon(
            Icons.local_play,
          ),
          applicationName: 'Manawanui',
          applicationVersion: '1.0.0',
          applicationLegalese: '©Manawanui 2019 Company',
          aboutBoxChildren: [
            ///Content goes here...
          ],
          child: Text('About app'),
        ),
      ],
    ));
  }
}
