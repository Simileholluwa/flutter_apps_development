import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../config/themes/app_colors.dart';
import '../../config/themes/app_dark_theme.dart';
import '../../config/themes/app_light_theme.dart';
import '../../config/themes/ui_parameters.dart';
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
      const Duration(seconds: 5),
          () => const DataUploaderScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor:
        UIParameters.isDarkMode() ? primaryDark : primaryLightColor1,
        systemNavigationBarIconBrightness:
        UIParameters.isDarkMode() ? Brightness.light : Brightness.dark,
        statusBarIconBrightness:
        UIParameters.isDarkMode() ? Brightness.light : Brightness.dark,
        statusBarColor:
        UIParameters.isDarkMode() ? primaryDark : primaryLightColor1,
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
            Image.asset("assets/images/app_splash_logo.png",
            height: 200,
            ),
            const SizedBox(height: 30,),
            const Text('MX Companion',
                style: TextStyle(
                    fontSize: 40,
                  fontWeight: FontWeight.w800,
                ),
            ),
          ],
        ),
      ),
    );
  }

}
