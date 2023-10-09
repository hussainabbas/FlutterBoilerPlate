import 'package:flutter/material.dart';
import 'package:manawanui/helpers/resources/routes_resources.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';
import 'package:manawanui/navigations/my_router_path.dart';
import 'package:manawanui/screens/mobile/auth/getStarted/get_started_screen.dart';
import 'package:manawanui/screens/mobile/auth/splash_screen.dart';

class MyRouterDelegate extends RouterDelegate<MyRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  MyRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  MyRoutePath? _currentConfiguration;

  @override
  Future<void> setNewRoutePath(MyRoutePath path) async {
    _currentConfiguration = path;
    notifyListeners();
  }

  @override
  MyRoutePath get currentConfiguration =>
      _currentConfiguration ?? MyRoutePath.splash();

  @override
  Widget build(BuildContext context) {
    final route = currentConfiguration;
    console("route => ${route.route}");
    return Navigator(
      key: navigatorKey,
      pages: [
        // Add a Page for the SplashScreen
        const MaterialPage(
          key: ValueKey(Routes.SPLASH_SCREEN),
          child: SplashScreen(),
        ),
        if (route.route == Routes.GET_STARTED_SCREEN)
          MaterialPage(
            key: const ValueKey(Routes.GET_STARTED_SCREEN),
            child: GetStartedScreen(
              flavor: route.dynamicParam ??
                  "", // Pass the dynamic flavor parameter if needed
            ),
          ),
        // Add other pages based on your routes
        // ...
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        // Handle pop if necessary
        return true;
      },
    );
    // final route = currentConfiguration;
    // // You can use a switch statement to build the corresponding widget based on the route
    // switch (route.route) {
    //   case Routes.SPLASH_SCREEN:
    //     return const SplashScreen();
    //   case Routes.GET_STARTED_SCREEN:
    //     {
    //       final flavor = route.dynamicParam ?? "";
    //       return GetStartedScreen(flavor: flavor);
    //       //return GetStartedScreen(flavor: flavor);
    //     }
    //   case Routes.LOGIN_SCREEN:
    //     return const LoginScreen();
    //   case Routes.HOME_ROUTE:
    //     return const DashboardScreen();
    //   case Routes.ADD_EDIT_TIMESHEET:
    //     return const AddEditTimeSheet();
    //   case Routes.ADD_EDIT_PAYEE:
    //     return const AddEditPayee();
    //   case Routes.ADD_VIEW_MAIL_SCREEN:
    //     return const AddViewMailScreen();
    //   case Routes.CONTACT_US_SCREEN:
    //     return const ContactUsMenuScreen(showAppBar: true);
    //   default:
    //     return const SizedBox.shrink(); // Handle unknown routes appropriately
    // }
  }
}
