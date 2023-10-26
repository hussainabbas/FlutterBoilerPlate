import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:manawanui/core/network/network_operations.dart';
import 'package:manawanui/data/models/user_details_response.dart';
import 'package:manawanui/helpers/enums/payees_type.dart';
import 'package:manawanui/helpers/enums/user_type.dart';
import 'package:manawanui/helpers/extension/widget_ref_functions.dart';
import 'package:manawanui/helpers/resources/app_preference_resources.dart';
import 'package:manawanui/helpers/resources/routes_resources.dart';
import 'package:manawanui/helpers/resources/strings.dart';
import 'package:manawanui/helpers/utils/app_preferences.dart';
import 'package:open_file/open_file.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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
  ref.invalidateEverything();
  if (context.mounted) {
    // Navigator.of(context).pushReplacementNamed(Routes.LOGIN_SCREEN);
    context.go(Routes.LOGIN_SCREEN);
  }
}

Color getPayeeStatusColor(String status) {
  console("getPayeeStatusColor => $status");
  if (status == "Active") {
    return Colors.green;
  } else if (status == "Inactive") {
    return Colors.grey;
  } else if (status == "Draft") {
    return Colors.blue;
  } else if (status == "Paid") {
    return Colors.green;
  } else if (status == "Received for Processing") {
    return Colors.orange;
  } else if (status == "Awaiting Employer Approval") {
    return Colors.amber;
  } else {
    return Colors.red;
  }
}

String getEmployeeType(String payeeType) {
  if (payeeType == StringResources.PERMANENT_EMPLOYEE_PAYEE) {
    return "E";
  } else if (payeeType == StringResources.CASUAL_EMPLOYEE_PAYEE) {
    return "L";
  } else if (payeeType == StringResources.CONTRACTOR_PAYEE) {
    return "C";
  } else if (payeeType == StringResources.ORGANIZATION_PAYEE) {
    return "O";
  } else if (payeeType == StringResources.SCHEDULER_CONTRACTOR_PAYEE) {
    return "S";
  } else {
    return "T";
  }
}

PayeesType? getPayeeTypeFromTitle(String title) {
  switch (title) {
    case StringResources.PERMANENT_EMPLOYEE_PAYEE:
      return PayeesType.PERMANENT;
    case StringResources.CASUAL_EMPLOYEE_PAYEE:
      return PayeesType.CASUAL;
    case StringResources.CONTRACTOR_PAYEE:
      return PayeesType.CONTRACTOR;
    case StringResources.ORGANIZATION_PAYEE:
      return PayeesType.ORGANIZATION;
    case StringResources.SCHEDULER_CONTRACTOR_PAYEE:
      return PayeesType.SCHEDULAR_CONTRACTOR;
    case StringResources.THIRD_PARTY_PROVIDER_PAYEE:
      return PayeesType.THIRD_PARTY_PROVIDER;
    default:
      return null; // Handle unknown cases as needed
  }
}

String currentDateToMMDDYYYY() {
  DateTime currentDate = DateTime.now();
  return DateFormat('MM/dd/yyyy').format(currentDate);
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

void setGlobalHeadersContentTypeJSON(NetworkOperations? apiClient) {
  apiClient?.setHeaders({
    ApiParamKeys.KEY_CONTENT_TYPE: "application/json",
  });
}

void setGlobalHeadersContentTypeFORMURL(NetworkOperations? apiClient) {
  apiClient?.setHeaders({
    ApiParamKeys.KEY_CONTENT_TYPE: "application/x-www-form-urlencoded",
  });
}

Future<void> openURL(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

void openFile(XFile? file) {
  console("File => ${file?.path}");
  OpenFile.open(file?.path);
}

String formatTextWithHyphens(String text) {
  text = text.replaceAll(RegExp(r'\D'), ''); // Remove non-numeric characters
  if (text.length >= 3) {
    text = '${text.substring(0, 3)}-${text.substring(3)}';
  }
  if (text.length >= 7) {
    text = '${text.substring(0, 7)}-${text.substring(7)}';
  }
  return text;
}

Future<String> xFileToBase64(XFile xFile) async {
  File file = File(xFile.path);

  if (file.existsSync()) {
    List<int> fileBytes = await file.readAsBytes();
    String base64String = base64Encode(fileBytes);
    return base64String;
  } else {
    throw Exception("File does not exist: ${xFile.path}");
  }
}
