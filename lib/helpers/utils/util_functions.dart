import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:manawanui/core/network/network_operations.dart';
import 'package:manawanui/core/providers/auth_providers.dart';
import 'package:manawanui/core/providers/login_form_provider.dart';
import 'package:manawanui/core/providers/payee_providers.dart';
import 'package:manawanui/core/providers/timesheet_providers.dart';
import 'package:manawanui/data/models/user_details_response.dart';
import 'package:manawanui/helpers/enums/user_type.dart';
import 'package:manawanui/helpers/resources/app_preference_resources.dart';
import 'package:manawanui/helpers/resources/routes_resources.dart';
import 'package:manawanui/helpers/utils/app_preferences.dart';
import 'package:manawanui/screens/mobile/dashboard/dashboard_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../resources/api_param_keys.dart';

console(message) {
  if (kDebugMode) {
    debugPrint(message);
  }
}

String getEmployerType(String employerCode) {
  switch (employerCode) {
    case 'R':
      return "Employer";
    default:
      return "Employee";
  }
}

String getDeviceType() {
  try {
    if (Platform.isAndroid) {
      return "Android";
    } else if (Platform.isIOS) {
      return "ios";
    } else {
      return "web";
    }
  } catch (e) {
    return "web";
  }
}

Future<String> getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

UserType getUserTypeCode(String roleCode, bool isSelfManaged) {
  console("getUserTypeCode => $roleCode");

  if (roleCode == "r" || roleCode == "R") {
    return isSelfManaged ? UserType.S : UserType.P;
  } else {
    return UserType.E;
  }
}

String getIsAppetize() {
  return "0";
}

void setGlobalHeaders(
    UserDetailsResponse? userDetailsResponse, NetworkOperations? apiClient) {
  apiClient?.setHeaders({
    ApiParamKeys.KEY_TOKEN: userDetailsResponse?.token ?? "",
    ApiParamKeys.KEY_USER_TYPE_CODE: getUserTypeCode(
            userDetailsResponse?.roleCode ?? "",
            userDetailsResponse?.isSelfManaged ?? false)
        .name,
    ApiParamKeys.KEY_USER_ROLE: userDetailsResponse?.roleCode ?? "",
    ApiParamKeys.KEY_USER_ID: userDetailsResponse?.userId.toString() ?? "",
    ApiParamKeys.KEY_DEVICE_TYPE_CAP: getDeviceType(),
    ApiParamKeys.KEY_IS_APPETIZE: getIsAppetize(),
  });
}

Future<String> getDeviceInfo() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    console('Running on ${androidInfo.model}');
    return '{"Model":"${androidInfo.model} A", "OSCodeName":"unknown","OSVersion":"${androidInfo.version.release}"}';
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    console('Running on ${iosInfo.utsname.machine}');
    return '{"Model":"${iosInfo.model} A", "OSCodeName":"unknown","OSVersion":"${iosInfo.systemVersion}"}';
  } else {
    WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
    console('Running on ${webBrowserInfo.userAgent}');
    return '{"Model":"${webBrowserInfo.userAgent} A", "OSCodeName":"unknown","OSVersion":"unknown"}';
  }
}

void logout(WidgetRef ref, BuildContext context) async {
  final deviceToken =
      await AppPreferences().getString(AppPreferenceResources.DEVICE_TOKEN);
  await AppPreferences().clear();
  await AppPreferences()
      .saveString(AppPreferenceResources.DEVICE_TOKEN, deviceToken ?? "");
  ref.invalidate(selectedIndexProvider);
  ref.invalidate(userDetailsProvider);
  ref.invalidate(loginFormProviderNotifier);
  ref.invalidate(loginViewModelProvider);
  ref.invalidate(loginViewModelProvider);
  ref.invalidate(selectedPayeeProvider);
  ref.invalidate(currentIndexProvider);
  ref.invalidate(timeSheetDataListProvider);
  ref.invalidate(expenseSheetDataListProvider);
  ref.invalidate(paymentsSheetDataListProvider);
  ref.invalidate(selectedMailIndexProvider);
  if (context.mounted) {
    // Navigator.of(context).pushReplacementNamed(Routes.LOGIN_SCREEN);
    context.go(Routes.LOGIN_SCREEN);
  }
}

Color getPayeeStatusColor(String status) {
  if (status == "Active") {
    return Colors.green;
  } else if (status == "Inactive") {
    return Colors.grey;
  } else if (status == "Draft") {
    return Colors.blue;
  } else {
    return Colors.red;
  }
}
