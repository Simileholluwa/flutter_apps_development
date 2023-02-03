import 'package:flutter/material.dart';

class TextButtonWithIcon extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const TextButtonWithIcon({Key? key, required this.onTap, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      icon: const Icon(
        Icons.arrow_forward_ios,
        size: 20,
      ),
      label: Text(
        text,
      ),
    );
  }
}
