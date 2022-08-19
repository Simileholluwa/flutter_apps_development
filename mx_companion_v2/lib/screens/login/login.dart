import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mx_companion_v2/controllers/auth_controller.dart';
import '../../config/themes/app_dark_theme.dart';
import '../../config/themes/app_light_theme.dart';
import '../../config/themes/ui_parameters.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: UIParameters.isDarkMode()
            ? transparentColor
            : primaryLightColor1,
        systemNavigationBarIconBrightness: UIParameters.isDarkMode()
            ? Brightness.light
            : Brightness.dark,
        statusBarIconBrightness: UIParameters.isDarkMode()
            ? Brightness.light
            : Brightness.dark,
        statusBarColor: UIParameters.isDarkMode()
            ? transparentColor
            : primaryLightColor1,
      ),
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              controller.signInWithGoogle();
            },
            child: Container(
              margin: const EdgeInsets.only(
                top: 40,
                right: 20,
                left: 20,
                bottom: 20,
              ),
              width: double.maxFinite,
              height: 70,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: primaryDarkColor1,
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 20,
                    child: SvgPicture.asset('assets/icons/google.svg'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Center(
                          child: Text(
                            'Sign In With Google',
                            style: GoogleFonts.jost(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
