import 'package:app_name/helpers/resources/colors.dart';
import 'package:flutter/material.dart';

extension CustomDialog on BuildContext {
  void showErrorSnackBar(String msg) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.red, // Set the background color to red
      ),
    );
  }

  void showSuccessSnackBar(String msg) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.green, // Set the background color to red
      ),
    );
  }

  void showCustomDialog() {
    showGeneralDialog(
      context: this,
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                primaryColor), // Change the color here
          ),
        );
      },
      // transitionBuilder: (_, anim, __, child) {
      //   Tween<Offset> tween;
      //   if (anim.status == AnimationStatus.reverse) {
      //     tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
      //   } else {
      //     tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
      //   }
      //
      //   return SlideTransition(
      //     position: tween.animate(anim),
      //     child: FadeTransition(
      //       opacity: anim,
      //       child: child,
      //     ),
      //   );
      // },
    );
  }
}
