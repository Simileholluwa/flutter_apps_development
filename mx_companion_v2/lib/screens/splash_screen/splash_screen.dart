import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mx_companion_v2/config/themes/app_dark_theme.dart';
import 'package:mx_companion_v2/config/themes/custom_text.dart';
import 'package:mx_companion_v2/controllers/auth_controller.dart';
import '../../config/themes/app_colors.dart';
import '../data_uploader_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 10),
          () => AuthController(),
    );
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: primaryDarkColor1,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: primaryDarkColor1,
        systemNavigationBarDividerColor: primaryDarkColor1,
      ),
    );

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: mainGradient(context),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoadingAnimationWidget.beat(color: orangeColor, size: 70,),
            const SizedBox(height: 10,),
            Text('MX Companion',
                style: heading,
            ),
          ],
        ),
      ),
    );
  }

}
