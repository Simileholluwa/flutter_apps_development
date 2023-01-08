import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mx_companion/screens/quiz_page/quiz_page.dart';
import 'package:mx_companion/widgets/big_text.dart';

class GetJsonData extends StatelessWidget {
  final String courseCode;
  final String courseName;
  const GetJsonData({
    Key? key,
    required this.courseCode,
    required this.courseName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String assetToLoad;
    switch (courseCode) {
      case 'MAT 111':
        assetToLoad = 'assets/mat111.json';
        break;
      case 'PHY 113':
        assetToLoad = 'assets/phy113.json';
        break;
      case 'PHY 123':
        assetToLoad = 'assets/phy123.json';
        break;
      case 'MAT 121':
        assetToLoad = 'assets/mat121.json';
        break;
      case 'CHM 111':
        assetToLoad = 'assets/chm111.json';
        break;
      default:
        assetToLoad = 'assets/mat111.json';
    }
    return FutureBuilder<String>(
      future:
      DefaultAssetBundle.of(context).loadString(assetToLoad, cache: false),
      builder: (context, snapshot) {
        List myData = json.decode(snapshot.data.toString()) ?? [];
        if (myData.isEmpty) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const BigText(
                      text: 'MX Companion', color: Colors.white, size: 40),
                  const SizedBox(height: 10),
                  LoadingAnimationWidget.fourRotatingDots(
                      color: Colors.white, size: 80),
                ],
              ),
            ),
          );
        } else {
          return QuizPage(
              myData: myData, courseCode: courseCode, courseName: courseName);
        }
      },
    );
  }
}