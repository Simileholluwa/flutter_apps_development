import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final AssetImage icon;
  final double size;
  const CustomIconButton({Key? key, required this.onPressed, required this.icon, this.size = 30,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: 25,
      icon: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: icon,
          ),
        ),
      ),
    );
  }
}
