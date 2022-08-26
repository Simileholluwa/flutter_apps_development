import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/themes/app_dark_theme.dart';

class IconWithName extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  const IconWithName({Key? key, required this.icon, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: moreTransparent,
            ),
            child: Icon(
              icon,
              size: 40,
            ),
          ),
          const SizedBox(height: 5,),
          Text(text,
            style: GoogleFonts.lobsterTwo(
              color: standoutBlue,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
