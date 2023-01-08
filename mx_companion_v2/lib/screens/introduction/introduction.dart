import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../config/themes/app_colors.dart';
import '../../config/themes/app_dark_theme.dart';
import '../../config/themes/app_light_theme.dart';
import '../../config/themes/ui_parameters.dart';
import '../../widgets/circle_button.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController auth = Get.find();

    return Scaffold(
      backgroundColor: UIParameters.isDarkMode()
          ? primaryDarkColor1
          : primaryLightColor1,
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: mainGradient(context),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              const Icon(
                Icons.star,
                size: 65,
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'This app will guide you as a student of FUTMinna to study past questions and get familiar with the electronic exam mode of conducting exams.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 2,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              CircleButton(
                onTap: auth.navigateToHome,
                child: const Icon(

                  Icons.arrow_forward_ios,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
