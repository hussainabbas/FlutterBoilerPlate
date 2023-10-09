import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manawanui/helpers/resources/colors.dart';

class MyTheme {
  static ColorScheme lightColorScheme = ColorScheme.light(
    primary: AppColors.primaryColor,
    secondary: AppColors.primaryColor,
    background: Colors.white,
    error: AppColors.primaryColor,
    onPrimary: Colors.black,
    onSecondary: Colors.blue,
    onSurface: Colors.black,
    onBackground: Colors.purple,
    onError: Colors.white,
  );

  static ColorScheme darkColorScheme = ColorScheme.dark(
    primary: AppColors.primaryColor,
    onPrimary: Colors.white,
    secondary: Colors.white,
    onSecondary: AppColors.primaryColor,
    onSurface: Colors.white,
    error: AppColors.primaryColor,
    onError: AppColors.primaryColor,
  );

  static const TextTheme lightTextTheme = TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'Century',
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Century',
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Century',
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Century',
      fontSize: 16.0,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Century',
      fontSize: 14.0,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Century',
      fontSize: 12.0,
    ),
  );

  static const TextTheme darkTextTheme = TextTheme(
    // Define your font family for dark mode
    headlineLarge: TextStyle(
      fontFamily: 'Century',
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Century',
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Century',
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Century',
      fontSize: 16.0,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Century',
      fontSize: 14.0,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Century',
      fontSize: 12.0,
    ),
  );

  // static final ThemeData lightTheme = ThemeData.from(
  //   colorScheme: lightColorScheme,
  //   textTheme: lightTextTheme,
  // );
  static final ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      color: MyTheme.darkColorScheme.background, // Set the app bar color
    ),
    colorScheme: MyTheme.darkColorScheme,
    textTheme: darkTextTheme,
    // Other theme configurations...
  );

  static final ThemeData lightTheme = ThemeData(
      appBarTheme: AppBarTheme(
        color: MyTheme.lightColorScheme.background, // Set the app bar color
      ),
      colorScheme: MyTheme.lightColorScheme,
      textTheme: lightTextTheme
      // Other theme configurations...
      );

  static SystemUiOverlayStyle get systemUiOverlayStyle {
    return SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryColor,
      statusBarIconBrightness: Brightness.light,
    );
  }
}
