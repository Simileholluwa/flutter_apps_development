import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:mx_companion_v2/controllers/auth_controller.dart';

class MyZoomDrawerController extends GetxController{
  final zoomDrawerController = ZoomDrawerController();
  void toggleDrawer (){
    zoomDrawerController.toggle?.call();
    update();
  }

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

  void email(){

  }
}