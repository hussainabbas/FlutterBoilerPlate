import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/core/providers/common_providers.dart';
import 'package:manawanui/core/providers/flavor_providers.dart';
import 'package:manawanui/data/models/get_employ_by_response.dart';
import 'package:manawanui/helpers/resources/app_preference_resources.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/helpers/resources/routes_resources.dart';
import 'package:manawanui/helpers/resources/strings.dart';
import 'package:manawanui/helpers/services/notification_services.dart';
import 'package:manawanui/helpers/themes/my_theme.dart';
import 'package:manawanui/helpers/utils/app_preferences.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';
import 'package:manawanui/screens/mobile/auth/getStarted/get_started_screen.dart';
import 'package:manawanui/screens/mobile/auth/login/login_screen.dart';
import 'package:manawanui/screens/mobile/auth/splash_screen.dart';
import 'package:manawanui/screens/mobile/dashboard/dashboard_menu/contact_us_menu_screen.dart';
import 'package:manawanui/screens/mobile/dashboard/dashboard_screen.dart';
import 'package:manawanui/screens/mobile/dashboard/mail/add_view_mail_screen.dart';
import 'package:manawanui/screens/mobile/dashboard/payees/add_edit_payee.dart';
import 'package:manawanui/screens/mobile/dashboard/timesheet/add_edit_timesheet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyCvU4clgdBdP99C1caQPggKj6rX84OP9AY',
            appId: 'manawanui-in-charge-limited',
            messagingSenderId: '1081762225832',
            projectId: 'manawanui-in-charge-limited'));
    usePathUrlStrategy();
  } else {
    await Firebase.initializeApp();
  }
  runApp(ProviderScope(
    overrides: [
      environmentProvider.overrideWithValue(
        const String.fromEnvironment('FLAVOR', defaultValue: 'uat'),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flavorAsyncValue = ref.watch(flavorProvider);
    final notificationService = ref.watch(notificationServiceProvider);
    final flavorBaseURLAsyncValue = ref.watch(flavorBaseUrlProvider);
    final currencySymbolState = ref.watch(currencySymbolProvider.notifier);
    final mApiClientProvider = ref.watch(apiClientProvider);

    ref.watch(environmentProvider);
    String flavor = '';
    void getDeviceToken() async {
      notificationService.requestNotificationPermission();
      final value = await notificationService.getDeviceToken();
      console("Device Token => $value");
      await AppPreferences()
          .saveString(AppPreferenceResources.DEVICE_TOKEN, value);
    }

    useEffect(() {
      getDeviceToken();
      notificationService.firebaseInit();
      return null;
    }, const []);

    flavorAsyncValue.when(
      data: (data) {
        flavor = data;
        AppColors(flavor);
        if (data == StringResources.MLMW) {
          currencySymbolState.state = "£";
        } else {
          currencySymbolState.state = "\$";
        }
      },
      loading: () {},
      error: (error, stackTrace) {},
    );

    // Only return MaterialApp when flavorAsyncValue has data
    if (flavorAsyncValue.hasValue) {
      return MaterialApp.router(
        routerConfig: MyRouter(flavor),
        debugShowCheckedModeBanner: false,
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        themeMode: ThemeMode.light,
        title: flavor == StringResources.MLMW ? "My Life My Way" : "Manawanui",
        /*   routes: {
          Routes.GET_STARTED_SCREEN: (context) => GetStartedScreen(
                flavor: flavor,
              ),
          Routes.LOGIN_SCREEN: (context) => const LoginScreen(),
          Routes.SPLASH_SCREEN: (context) => const SplashScreen(),
          Routes.HOME_ROUTE: (context) => const DashboardScreen(),
          Routes.ADD_EDIT_TIMESHEET: (context) => const AddEditTimeSheet(),
          Routes.ADD_EDIT_PAYEE: (context) => const AddEditPayee(),
          Routes.ADD_VIEW_MAIL_SCREEN: (context) => const AddViewMailScreen(),
          Routes.CONTACT_US_SCREEN: (context) => const ContactUsMenuScreen(
                showAppBar: true,
              ),
        },*/
        builder: (context, child) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: MyTheme.systemUiOverlayStyle,
            child: child!,
          );
        },
        /*onGenerateRoute: (settings) {
          switch (settings.name) {
            case Routes.SPLASH_SCREEN:
              return SlidePageRoute(page: const SplashScreen());
            case Routes.GET_STARTED_SCREEN:
              return SlidePageRoute(
                  page: GetStartedScreen(
                flavor: flavor,
              ));
            case Routes.LOGIN_SCREEN:
              return SlidePageRoute(page: const LoginScreen());
            case Routes.HOME_ROUTE:
              return SlidePageRoute(page: const DashboardScreen());
            case Routes.ADD_EDIT_TIMESHEET:
              {
                final arguments = settings.arguments as EmployByModel;

                return SlidePageRoute(
                    page: AddEditTimeSheet(
                  employByModel: arguments,
                ));
              }
            case Routes.ADD_EDIT_PAYEE:
              {
                if (settings.arguments != null) {
                  final arguments = settings.arguments as EmployByModel;
                  ref.watch(selectedPayeeProvider.notifier).state =
                      PayeeTypeWidget(title: arguments.employeeTypeDisplay ?? "", isEditable: false,);
                  return SlidePageRoute(
                      page: AddEditPayee(
                    employByModel: arguments,
                  ));
                } else {
                  return SlidePageRoute(page: const AddEditPayee());
                }
              }
            case Routes.ADD_VIEW_MAIL_SCREEN:
              return SlidePageRoute(page: const AddViewMailScreen());
            case Routes.CONTACT_US_SCREEN:
              return SlidePageRoute(
                  page: const ContactUsMenuScreen(
                showAppBar: true,
              ));

            default:
              return null;
          }
        },*/
      );
    } else {
      return Container();
    }
  }
}

class MyRouter extends GoRouter {
  MyRouter(String flavor)
      : super(
            // redirect: (context, state) {
            //   const isAuthenticated = true; // Add your logic to check whether a user is authenticated or not
            //   if (!isAuthenticated) {
            //     return '/auth';
            //   } else {
            //     return null;
            //   }
            // },
            navigatorKey: GlobalKey<NavigatorState>(),
            initialLocation: Routes.SPLASH_SCREEN,
            routes: [
              GoRoute(
                path: Routes.SPLASH_SCREEN,
                builder: (context, state) => const SplashScreen(),
              ),
              GoRoute(
                path: Routes.GET_STARTED_SCREEN,
                name: 'Get Started',
                builder: (context, state) => GetStartedScreen(flavor: flavor),
                pageBuilder: (context, state) =>
                    buildPageWithDefaultTransition<void>(
                  context: context,
                  state: state,
                  child: GetStartedScreen(flavor: flavor),
                ),
              ),
              GoRoute(
                  path: Routes.LOGIN_SCREEN,
                  name: 'Login',
                  pageBuilder: defaultPageBuilder(const LoginScreen()),
                  routes: [
                    GoRoute(
                      path: Routes.CONTACT_US_LOGIN,
                      builder: (context, state) => const ContactUsMenuScreen(
                          showAppBar: kIsWeb ? false : true),
                      pageBuilder: defaultPageBuilder(
                          const ContactUsMenuScreen(showAppBar: true)),
                    ),
                  ]),
              GoRoute(
                  path: Routes.HOME_ROUTE,
                  name: 'Dashboard',
                  builder: (context, state) {
                    final search = state.pathParameters;
                    console("StateExtra => ${state.extra}");
                    return const DashboardScreen();
                  },
                  pageBuilder: defaultPageBuilder(const DashboardScreen()),
                  routes: [
                    GoRoute(
                      path: Routes.ADD_EDIT_TIMESHEET,
                      name: 'Timesheet',
                      builder: (context, state) {
                        if (state.extra != null) {
                          return AddEditTimeSheet(
                            employByModel: state.extra as EmployByModel,
                          );
                        } else {
                          return const AddEditTimeSheet();
                        }
                      },
                      pageBuilder: defaultPageBuilder(const AddEditTimeSheet()),
                    ),
                    GoRoute(
                      path: Routes.ADD_EDIT_PAYEE,
                      name: 'Payees',
                      builder: (context, state) {
                        console("StateExtra => ${state.pathParameters}");
                        console("StateExtra => ${state.extra}");
                        if (state.extra != null) {
                          return AddEditPayee(
                            employByModel: state.extra as EmployByModel,
                          );
                        } else {
                          return const AddEditPayee();
                        }
                      },
                      // pageBuilder: defaultPageBuilder(const AddEditPayee()),
                    ),
                    GoRoute(
                      path: Routes.ADD_VIEW_MAIL_SCREEN,
                      name: 'Mail',
                      builder: (context, state) => const AddViewMailScreen(),
                      pageBuilder:
                          defaultPageBuilder(const AddViewMailScreen()),
                    ),
                  ]),

              // GoRoute(
              //   path: Routes.CONTACT_US,
              //   builder: (context, state) =>
              //       const ContactUsMenuScreen(showAppBar: true),
              //   pageBuilder:
              //       defaultPageBuilder(const ContactUsMenuScreen(showAppBar: true)),
              // ),
            ]);
}

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // Start position of the slide
      const end = Offset.zero; // End position of the slide
      const curve = Curves.easeInOut; // Animation curve

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

Page<dynamic> Function(BuildContext, GoRouterState) defaultPageBuilder<T>(
        Widget child) =>
    (BuildContext context, GoRouterState state) {
      return buildPageWithDefaultTransition<T>(
        context: context,
        state: state,
        child: child,
      );
    };

class SlidePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  SlidePageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Start position of the slide
            const end = Offset.zero; // End position of the slide
            const curve = Curves.easeInOut; // Animation curve

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
}
