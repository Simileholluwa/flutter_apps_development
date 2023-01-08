import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mx_companion/Services/Authentication/auth_service.dart';
import 'package:mx_companion/screens/tab_view/tab_view.dart';
import 'package:mx_companion/widgets/big_text.dart';
import '../login_screen/login_screen.dart';

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
      () => _initialScreenCheck(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const BigText(text: 'MX Companion', color: Colors.white, size: 40),
            const SizedBox(height: 10),
            LoadingAnimationWidget.fourRotatingDots(
                color: Colors.white, size: 80),
          ],
        ),
      ),
    );
  }

  _initialScreenCheck() {
    var user = AuthService.firebase().currentUser;
    if (user == null) {
      Get.offAll(() => const LoginScreen(),
          transition: Transition.rightToLeftWithFade
      );
    } else {
      Get.offAll(() => const ScreensTabView(),
          transition: Transition.rightToLeftWithFade
      );
    }
  }
}
