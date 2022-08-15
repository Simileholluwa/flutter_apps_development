import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/circle_button.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.star, size: 65, color: Colors.amber,),
              SizedBox(height: 40,),
              Text('This app will guide you as a student of FUTMinna to study past questions and get familiar with the exam mode of conducting exams.',
              textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40,),
              CircleButton(
                child: Icon(Icons.arrow_forward_ios, size: 35,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
