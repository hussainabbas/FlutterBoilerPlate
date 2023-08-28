import 'package:app_name/config/config.dart';
import 'package:app_name/helpers/resources/routes_resources.dart';
import 'package:app_name/helpers/themes/my_theme.dart';
import 'package:app_name/helpers/utils/util_functions.dart';
import 'package:app_name/screens/mobile/auth/getStarted/get_started_screen.dart';
import 'package:app_name/screens/mobile/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  const environment = String.fromEnvironment('FLAVOR', defaultValue: 'staging');
  console("Environment = $environment");
  await dotenv.load(fileName: 'lib/.env.$environment');
  var flavor = AppConfig(
    flavorName: dotenv.env['FLAVOR_NAME']!,
    baseUrl: dotenv.env['BASE_URL']!,
    child: const MyApp(),
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(flavor);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      initialRoute: Routes.getStartedScreen,
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      // Set light theme as default
      darkTheme: MyTheme.darkTheme,
      // Set dark theme
      themeMode: ThemeMode.light,
      // Use system theme mode (light/dark based on device settings)
      routes: {
        Routes.getStartedScreen: (context) => const GetStartedScreen(),
        Routes.loginScreen: (context) => const LoginScreen(),
      },
    );
  }
}
