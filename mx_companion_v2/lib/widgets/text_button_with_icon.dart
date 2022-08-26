import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/themes/app_dark_theme.dart';

class TextButtonWithIcon extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const TextButtonWithIcon({Key? key, required this.onTap, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      icon: Icon(
        Icons.arrow_forward_ios,
        color: standoutBlue,
      ),
      label: Text(
        text,
        style: GoogleFonts.jost(
          fontSize: 15,
          color: standoutBlue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
