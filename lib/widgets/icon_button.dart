import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {Key? key,
      required this.iconData,
      required this.onPressed,
      double? iconSize = 32})
      : _iconSize = iconSize,
        super(key: key);

  final IconData iconData;
  final VoidCallback onPressed;
  final double? _iconSize;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: IconButton(
        icon: Icon(iconData, color: Colors.black),
        disabledColor: Colors.grey,
        iconSize: _iconSize,
        onPressed: onPressed,
      ),
    );
  }
}
