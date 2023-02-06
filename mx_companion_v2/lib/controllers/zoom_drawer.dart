import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mx_companion_v2/controllers/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart';
import '../config/themes/app_dark_theme.dart';
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
      showSnackBar('Could not open Email App.');
    }
  }

  Future<void> openWhatsapp() async {
    var whatsappURlAndroid =
        "whatsapp://send?phone=+2347087840509&text=Hi, send us your enquiry, we will be sure to respond as soon as possible.";
    var whatsappURLIos =
        "https://wa.me/+2347087840509?text=${Uri.tryParse('Hi, send us your enquiry, we will be sure to respond as soon as possible.')}";
    try {
      if (Platform.isIOS) {
        await launchUrl(
          Uri.parse(
            whatsappURLIos,
          ),
        );
      } else {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      }
    } catch (e) {
      showSnackBar('Could not open WhatsApp.');
    }
  }

  Future<void> openFacebook() async {
    String fbProtocolUrl;
    if (Platform.isIOS) {
      fbProtocolUrl = 'fb://profile/100018248824645';
    } else {
      fbProtocolUrl = 'fb://page/100018248824645';
    }
    String fallBackUrl = 'https://www.facebook.com/100018248824645';
    try {
      Uri fbBundleUri = Uri.parse(fbProtocolUrl);
      var canLaunchNatively = await canLaunchUrl(fbBundleUri);
      if (canLaunchNatively) {
        launchUrl(fbBundleUri);
      } else {
        await launchUrl(Uri.parse(fallBackUrl),
            mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      showSnackBar('Could not open Facebook.');
    }
  }

  Future<void> openTelegram() async {
    String telegramPage =
        'https://t.me/Tee4Tee';
    try {
      Uri telegramBundleUri = Uri.parse(telegramPage);
      var canLaunchNatively = await canLaunchUrl(telegramBundleUri);
      if (canLaunchNatively) {
        launchUrl(telegramBundleUri);
      } else {
        await launchUrl(Uri.parse(telegramPage),
            mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      showSnackBar('Could not open telegram.');
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

  void showSnackBar(String message, {IconData icon = Icons.info_outline_rounded, Color containerColor = Colors.red}) {
    Get.snackbar(
      message,
      '',
      messageText: Container(),
      padding: const EdgeInsets.only(left: 0,),
      icon: Container(
        height: 30,
        width: 30,
        margin: const EdgeInsets.only(right: 10,),
        decoration: BoxDecoration(
          color: containerColor,
          //borderRadius: const BorderRadius.all(Radius.circular(15),),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: altTextColor,),
      ),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      margin: const EdgeInsets.only(left: 25, right: 25, top: 20,),
      borderRadius: 15,
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: Theme.of(Get.context!).highlightColor,
    );
  }

}