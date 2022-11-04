import 'package:flutter/material.dart';

import '../config/themes/app_dark_theme.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final double size;
  final Color color;
  const CustomIconButton({Key? key, required this.onPressed, required this.icon, this.size = 30, this.color = textColor,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: 25,
      splashColor: maroonColor,
      highlightColor: maroonColor,
      icon: Icon(
        icon,
        size: size,
        color: color,
      ),
    );
  }
}
