import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/core/providers/auth_providers.dart';
import 'package:manawanui/core/providers/common_providers.dart';
import 'package:manawanui/core/providers/flavor_providers.dart';
import 'package:manawanui/helpers/customChannels/my_appetize_intent_android.dart';
import 'package:manawanui/helpers/extension/context_function.dart';
import 'package:manawanui/helpers/resources/app_preference_resources.dart';
import 'package:manawanui/helpers/resources/image_resources.dart';
import 'package:manawanui/helpers/resources/routes_resources.dart';
import 'package:manawanui/helpers/resources/strings.dart';
import 'package:manawanui/helpers/utils/app_preferences.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(mainViewModelProvider);
    final apiClient = ref.read(apiClientProvider).value;

    useEffect(() {
      final subscription =
          viewModel.responseGetLatestVersionStream.listen((response) async {
        final userDetails = await AppPreferences().getUserDetails();
        if (userDetails?.token?.isNotEmpty == true) {
          ref.read(userDetailsProvider.notifier).state = userDetails;
          setGlobalHeaders(userDetails, apiClient);
          if (context.mounted) {
            context.go(Routes.HOME_ROUTE);
            // Navigator.of(context).pushReplacementNamed(Routes.HOME_ROUTE);
          }
        } else {
          if (context.mounted) {
            context.go(Routes.GET_STARTED_SCREEN);
            //Navigator.of(context).pushReplacementNamed(Routes.GET_STARTED_SCREEN);
          }
        }
      });

      return subscription.cancel;
    }, const []);

    useEffect(() {
      viewModel.getLatestVersion({"": ""});
      return null;
    }, const []);

    void initAppetizeIntent() async {
      final isAppetize = await MyAppetizeIntent.getAppetizeIntent();
      await AppPreferences()
          .saveBool(AppPreferenceResources.IS_APPETIZE, isAppetize);
    }

    useEffect(() {
      initAppetizeIntent();
      return null;
    }, const []);

    final flavorValue = ref.watch(flavorProvider).value;
    // Future.delayed(const Duration(seconds: 3), () async {
    //   final userDetails = await AppPreferences().getUserDetails();
    //   if (userDetails?.token?.isNotEmpty == true) {
    //     ref.read(userDetailsProvider.notifier).state = userDetails;
    //     setGlobalHeaders(userDetails, apiClient);
    //     if (context.mounted) {
    //       Navigator.of(context).pushReplacementNamed(Routes.HOME_ROUTE);
    //     }
    //   } else {
    //     if (context.mounted) {
    //       Navigator.of(context).pushReplacementNamed(Routes.GET_STARTED_SCREEN);
    //       // Navigator.of(context).pushReplacementNamed(Routes.GET_STARTED_SCREEN , arguments: flavorValue);
    //     }
    //   }
    // });
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            ImageResources.SPLASH_BG,
            fit: BoxFit.cover,
            height: context.fullHeight(),
            width: context.fullWidth(),
          ),
          Center(
            child: Image.asset(
              flavorValue == StringResources.MLMW
                  ? ImageResources.LOGO_MLMW
                  : ImageResources.LOGO_MANA,
              width: 240,
              height: 240,
            ),
          ),
        ],
      ),
    );
  }
}
