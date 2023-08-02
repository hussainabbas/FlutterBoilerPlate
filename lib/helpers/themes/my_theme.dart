import 'package:flutter/material.dart';
import 'package:FlutterBoilerPlater/helpers/resources/colors.dart';

class MyTheme {
  static ColorScheme lightColorScheme = ColorScheme.light(
    primary: Colors.white,
    secondary: primaryColor,
    background: Colors.white,
    error: primaryColor,
    onPrimary: primaryColor,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onBackground: primaryColor,
    onError: primaryColor,

  );

  static ColorScheme darkColorScheme = ColorScheme.dark(
    primary: primaryColor,
    onPrimary: Colors.white,
    secondary: Colors.white,
    onSecondary: primaryColor,
    onSurface: Colors.white,
    error: primaryColor,
    onError: primaryColor,
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

  static final ThemeData lightTheme = ThemeData.from(
    colorScheme: lightColorScheme,
    textTheme: lightTextTheme,
  );

  static final ThemeData darkTheme = ThemeData.from(
    colorScheme: darkColorScheme,
    textTheme: darkTextTheme,
  );
}
