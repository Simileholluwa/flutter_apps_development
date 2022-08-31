import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/themes/app_dark_theme.dart';

class Dialogs {
  static final Dialogs _singleton = Dialogs._internal();

  Dialogs._internal();

  factory Dialogs() {
    return _singleton;
  }

  static Widget appDialog({
    required VoidCallback onTap,
    required VoidCallback onPressed,
    required String text,
    required String message,
    required String action,
  }) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        backgroundColor: moreTransparent.withAlpha(50,),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: GoogleFonts.lobsterTwo(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: textColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              message,
              style: GoogleFonts.jost(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                height: 1.3,
                color: altTextColor,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: onPressed,
            child: Text(
              'Cancel',
              style: GoogleFonts.lobsterTwo(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 20,
              ),
            )
          ),
          TextButton(
            onPressed: onTap,
            child: Text(
              action,
              style: GoogleFonts.lobsterTwo(
                fontWeight: FontWeight.bold,
                color: textColor,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
