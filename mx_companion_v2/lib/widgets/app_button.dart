import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/themes/app_dark_theme.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget? buttonImage;
  final Widget buttonWidget;
  final Color btnColor;
  const AppButton({Key? key, required this.onTap, this.buttonImage, required this.buttonWidget, required this.btnColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          color: btnColor,
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buttonWidget,
          ],
        ),

      ),
    );
  }
}
