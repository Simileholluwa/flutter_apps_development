import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mx_companion_v2/controllers/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class MyZoomDrawerController extends GetxController{


  Rxn<User?> user = Rxn();
  @override
  void onReady(){
    user.value = Get.find<AuthController>().getUser();
    super.onReady();
  }

  void signOut(){
    Get.find<AuthController>().showSignOutAlertDialog();
  }

  void signIn(){
    Get.find<AuthController>().navigateToLogin();
  }

  void signUp(){
    Get.find<AuthController>().navigateToSignup();
  }

  void menu(){
    Get.find<AuthController>().navigateToMenu();
  }

  void website(){

  }

  Future<void> openEmail() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    try {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'maxoluwatosin@gmail.com',
        query: encodeQueryParameters(
            <String, String>{'subject': 'I have an enquiry.'}),
      );
      launchUrl(emailLaunchUri);
    } catch (e) {
      return ;
    }
  }

}