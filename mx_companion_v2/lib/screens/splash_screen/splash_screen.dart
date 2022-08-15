import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../introduction/introduction.dart';

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
          () => const IntroductionScreen(),
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
            const Text('MX Companion',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                ),
            ),
            const SizedBox(height: 10),
            LoadingAnimationWidget.fourRotatingDots(
                color: Colors.black, size: 80),
          ],
        ),
      ),
    );
  }

}
