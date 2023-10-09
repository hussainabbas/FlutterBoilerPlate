import 'package:flutter/services.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';

class MyAppetizeIntent {
  static const platfrom = MethodChannel("myappetizeintent");

  static Future<bool> getAppetizeIntent() async {
    try {
      return await platfrom.invokeMethod("getIsAppetizeIntent");
    } on PlatformException catch (e) {
      console("MyAppetizeIntent -> PlatformException: $e");
      return false;
    }
  }
}
