import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_seraph_hymns/home_screen/home_screen.dart';
import '../widgets/big_text.dart';
import 'package:get/get.dart';

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
      const Duration(seconds: 10,),
      () => _goHome()
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const BigText(text: 'My Seraph Hymns', size: 40),
            const SizedBox(height: 10),
            LoadingAnimationWidget.fourRotatingDots(
              size: 80,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

 _goHome() {
    return Get.offAll(() => const HomeScreen(),
        transition: Transition.rightToLeftWithFade,
    );
  }
}
