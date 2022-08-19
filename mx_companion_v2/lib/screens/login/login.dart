import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mx_companion_v2/controllers/auth_controller.dart';
import 'package:mx_companion_v2/widgets/app_button.dart';
import '../../firebase_ref/loading_status.dart';
import '../../config/themes/app_dark_theme.dart';
import '../../config/themes/app_light_theme.dart';
import '../../config/themes/ui_parameters.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    AuthController response = Get.find();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor:
            UIParameters.isDarkMode() ? transparentColor : primaryLightColor1,
        systemNavigationBarIconBrightness:
            UIParameters.isDarkMode() ? Brightness.light : Brightness.dark,
        statusBarIconBrightness:
            UIParameters.isDarkMode() ? Brightness.light : Brightness.dark,
        statusBarColor:
            UIParameters.isDarkMode() ? transparentColor : primaryLightColor1,
      ),
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         AppButton(
             onTap: () {
               if (response.loadingStatus.value == LoadingStatus.loading) {
                 _authResponse(context, 'Signing in...');
               }
               else if (response.loadingStatus.value == LoadingStatus.completed) {
                 _authResponse(context, 'Signed in successfully...');
               }
               else {
                 _authResponse(context, 'Error signing in...');
               }
               controller.signInWithGoogle();
             },
             buttonImage: SvgPicture.asset('assets/icons/google.svg'),
             buttonText: 'Sign In With Google',
         ),
          const SizedBox(height: 20,),
          Text(
            'OR',
            style: GoogleFonts.jost(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20,),
          AppButton(
              onTap: (){}, 
              buttonImage: const Icon(Icons.mail_sharp, size: 30,),
              buttonText: 'Sign In With Email',
          ),
        ],
      ),
    );
  }
}

 void _authResponse(BuildContext context, String responseText){
   ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
       content: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text(responseText, style: GoogleFonts.jost(
             color: Colors.white,
           ),),
         ],
       ),
       backgroundColor: altBackgroundColor,
       margin: const EdgeInsets.all(20),
       behavior: SnackBarBehavior.floating,
       shape: const RoundedRectangleBorder(
         borderRadius: BorderRadius.all(
           Radius.circular(10),
         ),
       ),
     ),
   );
 }


