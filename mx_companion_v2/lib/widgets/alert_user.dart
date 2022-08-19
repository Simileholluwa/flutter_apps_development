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

  static Widget paperStartDialog({
    required VoidCallback onTap,
  }) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        backgroundColor: transparentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello there!',
              style: GoogleFonts.jost(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: altTextColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'To start practicing your selected course, you need to sign in. It will only take a while..',
              style: GoogleFonts.jost(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                height: 1.3,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'Cancel',
              style: GoogleFonts.jost(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 17,
              ),
            )
          ),
          TextButton(
            onPressed: onTap,
            child: Text(
              'Login',
              style: GoogleFonts.jost(
                fontWeight: FontWeight.bold,
                color: altTextColor,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
