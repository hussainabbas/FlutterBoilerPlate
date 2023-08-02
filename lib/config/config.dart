import 'package:flutter/cupertino.dart';

class AppConfig extends InheritedWidget {
  final String flavorName, baseUrl;

  const AppConfig(
      {Key? key,
        required this.flavorName,
        required this.baseUrl,
        required Widget child})
      : super(key: key, child: child);

  static AppConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
