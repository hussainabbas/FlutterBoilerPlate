import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/widgets/text_view.dart';

AppBar? customAppBar(VoidCallback onBackPressed, String title,
    {TabBar? tabBar, List<Widget>? actions, bool? isBackButtonVisible = true}) {
  return kIsWeb
      ? null
      : AppBar(
          backgroundColor: Colors.white,
          elevation: 0.4,
          centerTitle: true,
          actions: actions,
          leading: isBackButtonVisible ?? false
              ? GestureDetector(
                  onTap: onBackPressed,
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                )
              : null,
          bottom: tabBar,
          title: TextView(
              text: title,
              textColor: AppColors.primaryColor,
              textFontWeight: FontWeight.bold,
              fontSize: 18),
        );
}
