import 'package:app_name/helpers/resources/colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isValid,
    Color? backgroundColor,
    bool? isFullRounded = false,
    bool? isContainIcon = false,
    double? widthMultiplier = 0.7,
  })  : _backgroundColor = backgroundColor,
        _isFullRounded = isFullRounded,
        _isContainIcon = isContainIcon,
        _widthMultiplier = widthMultiplier,
        super(key: key);

  final String title;
  final VoidCallback onPressed;
  final Color? _backgroundColor;
  final bool? _isFullRounded;
  final bool? _isContainIcon;
  final bool? isValid;
  final double? _widthMultiplier;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * (_widthMultiplier ?? 0.7),
        child: ElevatedButton(
          onPressed: isValid ?? true ? onPressed : null,
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_isFullRounded ?? false
                    ? 100.0
                    : 8.0), // Set the corner radius here
              ),
              foregroundColor: Colors.white,
              backgroundColor: _backgroundColor ??
                  primaryColor // Set the background color here
              ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_isContainIcon ?? false)
                  const Icon(Icons.social_distance_outlined,
                      color: Colors.white),
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
