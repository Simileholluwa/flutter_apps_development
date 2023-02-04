import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mx_companion_v2/controllers/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart';

import '../services/upload.dart';

class MyZoomDrawerController extends GetxController{
  final zoomDrawerController = ZoomDrawerController();
  void toggleZoomDrawer(){
    zoomDrawerController.toggle?.call();
    update();
  }

  Rxn<User?> user = Rxn();
  @override
  void onReady(){
    user.value = Get.find<AuthController>().getUser();
    super.onReady();
  }

  File? _photo;
  File? get photo => _photo;
  final ImagePicker _picker = ImagePicker();
  final RxBool _isPhoto = false.obs;
  RxBool get isPhoto => _isPhoto;
  final RxBool _isUploading = false.obs;
  RxBool get isUploading => _isUploading;
  UploadTask? task;

  void signOut(){
    Get.find<AuthController>().showSignOutAlertDialog();
  }

  void signIn(){
    Get.find<AuthController>().navigateToLogin();
  }

  void signUp(){
    Get.find<AuthController>().navigateToSignup();
  }

  void history(){
    Get.find<AuthController>().navigateToHistory();
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

  Future imgFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        _isPhoto.value = true;
        uploadFile();
        update();
      } else {
        return ;
      }
    } catch(e){
      return ;
    }
  }

  Future uploadFile() async {
    if(_photo == null){
      return;
    }
    try{
      if (_photo != null) {
        final fileName = basename(_photo!.path);
        final destination = 'images/$fileName';
        task = FirebaseApi.uploadFile(destination, _photo!);
        if (task == null) {
          return;
        } else {
          try {
            _isUploading.value = true;
            final snapShot = await task!.whenComplete(() {});
            final urlDownload = await snapShot.ref.getDownloadURL();
            await FirebaseAuth.instance.currentUser!.updatePhotoURL(urlDownload);
            update();
            _isUploading.value = false;
          } on FirebaseException catch (e) {
            return;
          } catch (e) {
            return;
          }
        }
        update();
      }
    } catch(e){
      return;
    }
  }

}