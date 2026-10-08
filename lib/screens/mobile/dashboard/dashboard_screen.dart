import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/core/providers/auth_providers.dart';
import 'package:manawanui/core/providers/common_providers.dart';
import 'package:manawanui/core/providers/dashboard_providers.dart';
import 'package:manawanui/data/models/drawer_item.dart';
import 'package:manawanui/data/models/get_mail_count_response.dart';
import 'package:manawanui/helpers/extension/context_function.dart';
import 'package:manawanui/helpers/resources/api_param_keys.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/helpers/resources/routes_resources.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';
import 'package:manawanui/screens/mobile/dashboard/dashboard_menu/announcements_menu_screen.dart';
import 'package:manawanui/screens/mobile/dashboard/dashboard_menu/budgeting_menu_screen.dart';
import 'package:manawanui/screens/mobile/dashboard/dashboard_menu/contact_us_menu_screen.dart';
import 'package:manawanui/screens/mobile/dashboard/dashboard_menu/help_and_resources_menu_screen.dart';
import 'package:manawanui/screens/mobile/dashboard/dashboard_menu/mail_menu_screen.dart';
import 'package:manawanui/screens/mobile/dashboard/dashboard_menu/payees_menu_screen.dart';
import 'package:manawanui/screens/mobile/dashboard/dashboard_menu/profile_menu_screen.dart';
import 'package:manawanui/screens/mobile/dashboard/dashboard_menu/reminders_menu_screen.dart';
import 'package:manawanui/screens/mobile/dashboard/dashboard_menu/statement_menu_screen.dart';
import 'package:manawanui/screens/mobile/dashboard/dashboard_menu/timesheet_menu_screen.dart';
import 'package:manawanui/widgets/my_drawer.dart';
import 'package:manawanui/widgets/responsive_widget.dart';
import 'package:manawanui/widgets/text_view.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class DashboardScreen extends HookConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = ref.read(userDetailsProvider);
    final selectedIndex = ref.watch(selectedIndexProvider);
    final viewModel = ref.watch(dashboardViewModelProvider);
    final apiClient = ref.watch(apiClientProvider).value;
    final List<DrawerItem> drawerItems = [
      DrawerItem(
          title: 'Statement',
          route: Routes.STATEMENT,
          icon: const Icon(Icons.notes_sharp)),
      DrawerItem(
          title: 'Budgeting',
          route: Routes.BUDGETING,
          icon: const Icon(Icons.monetization_on_rounded)),
      DrawerItem(
          title: 'Payees',
          route: Routes.PAYEES,
          icon: const Icon(Icons.person_rounded)),
      DrawerItem(
          title: 'Timesheet',
          route: Routes.TIMESHEET,
          icon: const Icon(Icons.alarm_add_rounded)),
      DrawerItem(
          title: 'Announcements',
          route: Routes.ANNOUNCEMENTS,
          icon: const Icon(Icons.announcement_rounded)),
      DrawerItem(
          title: 'Mail',
          route: Routes.MAIL,
          icon: const Icon(Icons.mail_lock_rounded)),
      DrawerItem(
          title: 'Reminders',
          route: Routes.REMINDERS,
          icon: const Icon(Icons.doorbell_rounded)),
      DrawerItem(
          title: 'Profile',
          route: Routes.PROFILE,
          icon: const Icon(Icons.support_agent_rounded)),
      DrawerItem(
          title: 'Contact us',
          route: Routes.CONTACT_US,
          icon: const Icon(Icons.contact_page_rounded)),
      DrawerItem(
          title: 'Forms & Resources',
          route: Routes.FORMS_RESOURCES,
          icon: const Icon(Icons.document_scanner_rounded)),
      DrawerItem(
          title: 'Help & Resources',
          route: Routes.HELP_RESOURCES,
          icon: const Icon(Icons.document_scanner_rounded)),
      DrawerItem(
          title: 'Logout',
          route: Routes.LOGOUT,
          icon: const Icon(Icons.logout_rounded)),
    ];
    Widget getDrawerItemWidget(String routeName) {
      switch (routeName) {
        case Routes.STATEMENT:
          return const StatementMenuScreen();
        case Routes.BUDGETING:
          return const BudgetingMenuScreen();
        case Routes.PAYEES:
          return const PayeesMenuScreen();
        case Routes.TIMESHEET:
          return const TimesheetMenuScreen();
        case Routes.ANNOUNCEMENTS:
          return const AnnouncementsMenuScreen();
        case Routes.MAIL:
          return const MailMenuScreen();
        case Routes.REMINDERS:
          return const RemindersMenuScreen();
        case Routes.PROFILE:
          return const ProfileMenuScreen();
        case Routes.CONTACT_US:
          return const ContactUsMenuScreen(
            showAppBar: false,
          );
        case Routes.HELP_RESOURCES:
          return const HelpAndResourcesMenuScreen();
        default:
          return const StatementMenuScreen();
      }
    }

    Widget returnAppBarActionDependsOnScreen() {
      if (drawerItems[selectedIndex].route == Routes.PAYEES) {
        return Icon(
          Icons.help,
          color: AppColors.primaryColor,
        );
      }
      if (drawerItems[selectedIndex].route == Routes.ANNOUNCEMENTS ||
          drawerItems[selectedIndex].route == Routes.MAIL ||
          drawerItems[selectedIndex].route == Routes.CONTACT_US) {
        return const SizedBox();
      }
      if (drawerItems[selectedIndex].route == Routes.REMINDERS) {
        return Icon(
          Icons.calendar_month,
          color: AppColors.primaryColor,
        );
      }
      if (drawerItems[selectedIndex].route == Routes.PROFILE) {
        return Icon(
          Icons.help,
          color: AppColors.primaryColor,
        );
      }

      if (drawerItems[selectedIndex].route == Routes.HELP_RESOURCES) {
        return Icon(
          Icons.help,
          color: AppColors.primaryColor,
        );
      }

      return Icon(
        Icons.more_horiz,
        color: AppColors.primaryColor,
      );
    }

    useEffect(() {
      setGlobalHeaders(userDetails, apiClient);
      viewModel.getMailCount({
        ApiParamKeys.KEY_USER_ID_SMALL: userDetails?.userId ?? "",
      });
      return null;
    }, []);

    return Scaffold(
      body: StreamBuilder<ApiResult<GetMailCountResponse>>(
        stream: viewModel.responseGetMailCountStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final response = snapshot.data;
          final data = response?.data;
          return ResponsiveWidget(builder: (context, isMobile, isWeb) {
            if (isMobile) {
              return Scaffold(
                body: getDrawerItemWidget(drawerItems[selectedIndex].route),
                backgroundColor: Colors.grey.shade100,
                appBar: AppBar(
                  elevation: 1,
                  centerTitle: true,
                  actions: [
                    returnAppBarActionDependsOnScreen(),
                    //Icon(Icons.more_horiz),
                    const SizedBox(
                      width: 8,
                    )
                  ],
                  title: TextView(
                      text: drawerItems[selectedIndex].title,
                      textColor: Colors.black,
                      textFontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                drawer: MyDrawer(
                  drawerItems: drawerItems,
                  userDetails: userDetails,
                  unreadCount: "${data?.response?.unreadCount ?? ""}",
                ),
              );
            } else {
              return Row(
                children: [
                  // Drawer
                  SizedBox(
                    width: context.fullWidth(multiplier: 0.2),
                    // Set the width of the drawer
                    child: MyDrawer(
                      drawerItems: drawerItems,
                      userDetails: userDetails,
                    ),
                  ),
                  // Main content
                  Expanded(
                      child:
                          getDrawerItemWidget(drawerItems[selectedIndex].route))
                ],
              );
            }
          });
        },
      ),
    );
  }
}
