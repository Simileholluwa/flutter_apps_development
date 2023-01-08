import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/themes/app_dark_theme.dart';

class IconWithName extends StatelessWidget {
  final Widget child;
  final String text;
  final Color color;
  final VoidCallback onTap;
  const IconWithName({Key? key, required this.child, required this.text, required this.onTap, this.color = altTextColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            splashColor: textColor,
            highlightColor: maroonColor,
            onTap: onTap,
            child: Container(
              height: 50,
              width: 50,
              decoration:  BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(.2),
              ),
              child: child,
            ),
          ),
        ),
        const SizedBox(height: 5,),
        Text(text,
          style: GoogleFonts.jost(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
