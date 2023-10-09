import 'package:flutter/cupertino.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';

class AppColors {
  static late Color primaryColor;
  static late Color primaryColorDark;
  static late Color primaryColorLight;
  static late Color accentColor;
  static late Color primaryColor42;
  Color errorColor = const Color(0xffEE0064);
  Color successColor = const Color(0xff00B09B);
  Color colorGrey = const Color(0xff545454);
  Color colorCardBackground = const Color(0xffDFDFDF);
  Color colorWhite = const Color(0xffFFFFFF);
  Color colorBlack = const Color(0xff000000);
  Color colorSplashForeground = const Color(0xff181818);

  AppColors(String flavor) {
    console("getAppColors => $flavor");
    switch (flavor.toLowerCase()) {
      case 'mlmw':
        primaryColor = const Color(0xff00285b);
        primaryColorDark = const Color(0xff00285b);
        primaryColorLight = const Color(0xff00285b);
        accentColor = const Color(0xff00285b);
        primaryColor42 = const Color(0x6f00285b);
        break;
      default:
        primaryColor = const Color(0xfff44248); // Default color
        primaryColorDark = const Color(0xfff44248); // Default color
        primaryColorLight = const Color(0xfff44248); // Default color
        accentColor = const Color(0xfff44248); // Default color
        primaryColor42 = const Color(0x6ff44248); // Default color
    }
  }
}
