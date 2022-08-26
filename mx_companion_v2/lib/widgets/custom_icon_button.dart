import 'package:flutter/material.dart';

import '../config/themes/app_dark_theme.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final double size;
  const CustomIconButton({Key? key, required this.onPressed, required this.icon, this.size = 30,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: 25,
      splashColor: altBackgroundColor,
      highlightColor: altBackgroundColor,
      hoverColor: altBackgroundColor,
      icon: Icon(
        icon,
        size: size,
        color: textColor,
      ),
    );
  }
}
