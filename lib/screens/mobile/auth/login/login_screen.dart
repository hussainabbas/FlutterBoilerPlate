import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/core/providers/auth_providers.dart';
import 'package:manawanui/core/providers/common_providers.dart';
import 'package:manawanui/core/providers/login_form_provider.dart';
import 'package:manawanui/helpers/extension/context_function.dart';
import 'package:manawanui/helpers/resources/api_param_keys.dart';
import 'package:manawanui/helpers/resources/app_preference_resources.dart';
import 'package:manawanui/helpers/resources/image_resources.dart';
import 'package:manawanui/helpers/resources/routes_resources.dart';
import 'package:manawanui/helpers/utils/app_preferences.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';
import 'package:manawanui/widgets/custom_elevated_button.dart';
import 'package:manawanui/widgets/custom_text_field.dart';
import 'package:manawanui/widgets/responsive_widget.dart';
import 'package:manawanui/widgets/text_view.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  //final Map<String, dynamic> id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(loginViewModelProvider);
    final apiClient = ref.read(apiClientProvider).value;
    useEffect(() {
      final subscription =
          viewModel.responseLoginStream.listen((response) async {
        if (response.data?.status == true) {
          final loginResponse = response.data!;
          console("Login successful: ${loginResponse.response?.userId}");
          await AppPreferences().saveString(AppPreferenceResources.TOKEN,
              loginResponse.response?.token.toString() ?? "");
          setGlobalHeaders(loginResponse.response, apiClient);
          if (loginResponse.passwordExpired ?? false) {
            if (context.mounted) {
              context.showErrorDialog(
                  response.data?.message ?? response.error ?? "");
            }
            return;
          }
          if (loginResponse.twoFactorAuth ?? false) {
            return;
          }
          await AppPreferences().saveUserDetails(loginResponse.response);
          ref.read(userDetailsProvider.notifier).state = loginResponse.response;
          if (context.mounted) context.showProgressDialog();
          final body = {
            ApiParamKeys.KEY_USER_ID_SMALL:
                loginResponse.response?.userId ?? "",
          };
          viewModel.updateUserSession(body).then((_) {
            // if (context.mounted) Navigator.of(context).pop();
            if (context.mounted) context.pop();
          });
        } else {
          context.showErrorSnackBar(
              response.data?.message ?? response.error ?? "");
          context
              .showErrorDialog(response.data?.message ?? response.error ?? "");
          console("Error during login: ${response.error}");
        }
      });

      return subscription.cancel;
    }, const []);

    useEffect(() {
      final subscription =
          viewModel.responseUpdateUserSessionStream.listen((response) async {
        if (response.data?.status == true) {
          context.showSuccessSnackBar(response.data?.message ?? "");
          if (context.mounted) {
            context.go(Routes.HOME_ROUTE);
            //Navigator.of(context).pushReplacementNamed(Routes.HOME_ROUTE);
          }
        } else {
          context.showErrorSnackBar(
              response.data?.message ?? response.error ?? "");
          context
              .showErrorDialog(response.data?.message ?? response.error ?? "");
          console("Error during login: ${response.error}");
        }
      });

      return subscription.cancel;
    }, const []);

    return Scaffold(
      body: SafeArea(
        child: ResponsiveWidget(
          builder: (context, isMobile, isWeb) {
            return SingleChildScrollView(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    ImageResources.SPLASH_BG,
                    fit: BoxFit.fill,
                    height: context.fullHeight(),
                    width: context.fullWidth(),
                  ),
                  SizedBox(
                    width: context.fullWidth(multiplier: isWeb ? 0.3 : 1.0),
                    height: context.fullHeight(multiplier: 0.89),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8.0, 16, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    context.go(Routes.GET_STARTED_SCREEN);
                                    // Navigator.pop(context);
                                  },
                                  child: const Icon(Icons.back_hand)),
                              GestureDetector(
                                  onTap: () {
                                    context.go(
                                        "${Routes.LOGIN_SCREEN}/${Routes.CONTACT_US_LOGIN}");
                                    // Navigator.pushNamed(
                                    //     context, Routes.CONTACT_US);
                                  },
                                  child: const Icon(Icons.contacts_sharp)),
                            ],
                          ),
                        ),
                        const BuildLoginScreen(),
                        const SizedBox(height: 32),
                        TextButton(
                          onPressed: () {},
                          child: const TextView(
                            text: "Terms & Conditions?",
                            textColor: Colors.black,
                            isUnderLine: true,
                            textFontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const TextView(
                            text: "Privacy Policy?",
                            textColor: Colors.black,
                            isUnderLine: true,
                            textFontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class BuildLoginScreen extends HookConsumerWidget {
  const BuildLoginScreen({super.key});

  void handleSignIn(BuildContext context, String email, String password,
      WidgetRef ref) async {
    final deviceToken =
        await AppPreferences().getString(AppPreferenceResources.DEVICE_TOKEN) ??
            "";
    final viewModel = ref.read(loginViewModelProvider);
    if (context.mounted) context.showProgressDialog();
    final body = {
      ApiParamKeys.KEY_USER_NAME: email,
      ApiParamKeys.KEY_PASSWORD: password,
      ApiParamKeys.KEY_DEVICE_TYPE: getDeviceType(),
      ApiParamKeys.KEY_DEVICE_TOKEN: deviceToken,
      ApiParamKeys.KEY_APP_VERSION: await getAppVersion()
    };
    viewModel.getLoginResponse(body).then((_) {
      if (context.mounted) context.pop(); //Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 0.2)),
          width: context.fullWidth(multiplier: kIsWeb ? 0.25 : 0.7),
          height: context.fullHeight(multiplier: 0.66),
        ),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 0.2)),
          width: context.fullWidth(multiplier: kIsWeb ? 0.27 : 0.8),
          height: context.fullHeight(multiplier: 0.64),
        ),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 0.2)),
          width: context.fullWidth(multiplier: kIsWeb ? 0.29 : 0.9),
          height: context.fullHeight(multiplier: 0.62),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  ImageResources.LOGO_MANA,
                  width: 70,
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  width: context.fullWidth(multiplier: kIsWeb ? 0.4 : 0.8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const TextView(
                        text: "Login",
                        textColor: Colors.black,
                        textFontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                      const SizedBox(height: 32),
                      CustomTextField(
                        key: const Key("emailTextField"),
                        controller: emailController,
                        title: "Email",
                        prefixIcon: const Icon(Icons.person),
                        errorMessage: ref
                            .watch(loginFormProviderNotifier)
                            .form
                            .email
                            .errorMessage,
                        onChanged: (value) => ref
                            .read(loginFormProviderNotifier.notifier)
                            .setEmail(value),
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        key: const Key("passwordTextField"),
                        controller: passwordController,
                        title: "Password",
                        prefixIcon: const Icon(Icons.lock),
                        obscure: true,
                        errorMessage: ref
                            .watch(loginFormProviderNotifier)
                            .form
                            .password
                            .errorMessage,
                        onChanged: (value) => ref
                            .read(loginFormProviderNotifier.notifier)
                            .setPassword(value),
                      ),
                      const SizedBox(height: 40),
                      CustomElevatedButton(
                        title: "LOG IN",
                        widthMultiplier: kIsWeb ? 0.14 : 0.35,
                        isFullRounded: true,
                        isValid: ref
                                .watch(loginFormProviderNotifier)
                                .form
                                .password
                                .isValid &&
                            ref
                                .watch(loginFormProviderNotifier)
                                .form
                                .email
                                .isValid,
                        onPressed: () {
                          final field =
                              ref.read(loginFormProviderNotifier).form;
                          if (field.password.isValid && field.email.isValid) {
                            handleSignIn(context, field.email.value,
                                field.password.value, ref);
                            // Navigator.of(context)
                            //     .pushReplacementNamed(Routes.HOME_ROUTE);
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {},
                        child: const TextView(
                          text: "Forgot password?",
                          textColor: Colors.black,
                          textFontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
