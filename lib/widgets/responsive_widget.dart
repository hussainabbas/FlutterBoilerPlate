import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget Function(BuildContext context, bool isMobile, bool isWeb)
      builder;

  const ResponsiveWidget({super.key, required this.builder});

  bool get isWeb => kIsWeb;

  bool get isMobile => !kIsWeb;

  @override
  Widget build(BuildContext context) {
    return builder(context, isMobile, isWeb);
  }
}
