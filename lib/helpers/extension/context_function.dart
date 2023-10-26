import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/widgets/text_view.dart';

extension CustomDialog on BuildContext {
  void showErrorSnackBar(String msg) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.red, // Set the background color to red
      ),
    );
  }

  double fullWidth({double multiplier = 1.0}) {
    return MediaQuery.of(this).size.width * multiplier;
  }

  double fullHeight({double multiplier = 1.0}) {
    return MediaQuery.of(this).size.height * multiplier;
  }

  void showSuccessSnackBar(String msg) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.green, // Set the background color to red
      ),
    );
  }

  void showProgressDialog() {
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
                AppColors.primaryColor), // Change the color here
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

  void showErrorDialog(String message, {String? title}) {
    showDialog(
      context: this,
      builder: (BuildContext context) {
        // Return an alert dialog
        return FractionallySizedBox(
          widthFactor: kIsWeb ? 0.4 : 1.0,
          child: AlertDialog(
            title: TextView(
                text: title ?? "Error",
                textColor: AppColors.primaryColor,
                textFontWeight: FontWeight.bold,
                fontSize: 24),
            content: TextView(
                text: message,
                textColor: Colors.black,
                textFontWeight: FontWeight.normal,
                fontSize: 18),
            actions: [
              // Define buttons for the dialog
              TextButton(
                onPressed: () {
                  // Close the dialog when the "OK" button is pressed
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  showConfirmationDialog(
    String title,
    String content,
    VoidCallback onYesPressed,
  ) {
    showDialog<void>(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          title: TextView(
              text: title,
              textColor: AppColors.primaryColor,
              textFontWeight: FontWeight.bold,
              fontSize: 16),
          content: TextView(
              text: content,
              textColor: Colors.black,
              textFontWeight: FontWeight.normal,
              fontSize: 14),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onYesPressed(); // Execute 'Yes' action
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
