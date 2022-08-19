import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/themes/app_dark_theme.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget buttonImage;
  final String buttonText;
  const AppButton({Key? key, required this.onTap, required this.buttonImage, required this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          right: 20,
          left: 20,
        ),
        width: double.maxFinite,
        height: 70,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: altBackgroundColor,
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buttonImage,
            const SizedBox(width: 10,),
            Text(
              buttonText,
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
