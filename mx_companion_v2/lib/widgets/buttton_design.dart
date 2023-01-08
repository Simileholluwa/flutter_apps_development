import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/themes/app_dark_theme.dart';

class ButtonDesign extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String text;
  final double width;
  const ButtonDesign({Key? key, required this.onTap, required this.icon, required this.text, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          color: moreTransparent.withAlpha(80),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: GoogleFonts.jost(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
