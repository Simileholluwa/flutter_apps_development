import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';

class MyZoomDrawerController extends GetxController{
  final zoomDrawerController = ZoomDrawerController();
  void toggleDrawer (){
    zoomDrawerController.toggle?.call();
    update();
  }

  @override
  void onReady(){

    super.onReady();
  }

  void signOut(){

  }

  void signIn(){

  }

  void website(){

  }

  void email(){

  }
}