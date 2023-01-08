import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mx_companion/widgets/small_text.dart';
import '../Services/Authentication/auth_service.dart';
import '../screens/forgot_password/forgot_password.dart';
import '../screens/login_screen/login_screen.dart';
import '../screens/register_screen/register_screen.dart';
import 'big_text.dart';

Future<void> authInfoError(
  BuildContext context,
  String infoSubheading,
    String infoHeading,
   ) {
  return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            actionsPadding: const EdgeInsets.only(bottom: 10,),
            scrollable: true,
            backgroundColor: CupertinoColors.darkBackgroundGray,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.red,
                        child: ClipOval(
                          child: SizedBox(
                            height: 80,
                            width: 80,
                            child: Center(
                              child: Icon(
                                FontAwesomeIcons.ban,
                                color: Colors.white,
                                size: 80,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: BigText(
                      text: infoHeading,
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.blue.shade800,
                    endIndent: 30,
                    indent: 30,
                  ),
                  Center(
                    child: Text(
                      infoSubheading,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: (() => Get.back()),
                          child: Container(

                            height: 50,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue.shade800,
                            ),
                            child: const Center(
                              child: SmallText(text: 'Try Again'),
                            ),
                          ),
                        ),
                    ],
                  ),
            ],
          ),
        );
      });
}

Future<void> authInfoErrorRegister(
    BuildContext context,
    String infoSubheading,
    String infoHeading,
    ) {
  return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            actionsPadding: const EdgeInsets.only(bottom: 10,),
            scrollable: true,
            backgroundColor: CupertinoColors.darkBackgroundGray,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.red,
                        child: ClipOval(
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: Center(
                              child: Icon(
                                FontAwesomeIcons.ban,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: BigText(
                      text: infoHeading,
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.blue.shade800,
                    endIndent: 30,
                    indent: 30,
                  ),
                  Center(
                    child: Text(
                      infoSubheading,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Get.to(() => const RegisterScreen());
                    },
                    child: Container(

                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue.shade800,
                      ),
                      child: const Center(
                        child: SmallText(text: 'Register'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  InkWell(
                    onTap: (() => Get.back()),
                    child: Container(

                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue.shade800,
                      ),
                      child: const Center(
                        child: SmallText(text: 'Try Again'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}

Future<void> authInfoErrorLogin(
    BuildContext context,
    String infoSubheading,
    String infoHeading,
    ) {
  return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            actionsPadding: const EdgeInsets.only(bottom: 10,),
            scrollable: true,
            backgroundColor: CupertinoColors.darkBackgroundGray,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.red,
                        child: ClipOval(
                          child: SizedBox(
                            height: 80,
                            width: 80,
                            child: Center(
                              child: Icon(
                                FontAwesomeIcons.ban,
                                color: Colors.white,
                                size: 80,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: BigText(
                      text: infoHeading,
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.blue.shade800,
                    endIndent: 30,
                    indent: 30,
                  ),
                  Center(
                    child: Text(
                      infoSubheading,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Get.to(() => const LoginScreen());
                    },
                    child: Container(

                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue.shade800,
                      ),
                      child: const Center(
                        child: SmallText(text: 'Login'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  InkWell(
                    onTap: (() => Get.back()),
                    child: Container(

                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue.shade800,
                      ),
                      child: const Center(
                        child: SmallText(text: 'Try Again'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}

Future<void> authInfoErrorForgotPassword(
    BuildContext context,
    String infoSubheading,
    String infoHeading,
    ) {
  return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            actionsPadding: const EdgeInsets.only(bottom: 10,),
            scrollable: true,
            backgroundColor: CupertinoColors.darkBackgroundGray,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.red,
                        child: ClipOval(
                          child: SizedBox(
                            height: 80,
                            width: 80,
                            child: Center(
                              child: Icon(
                                FontAwesomeIcons.ban,
                                color: Colors.white,
                                size: 80,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: BigText(
                      text: infoHeading,
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.blue.shade800,
                    endIndent: 30,
                    indent: 30,
                  ),
                  Center(
                    child: Text(
                      infoSubheading,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Get.to(() => const ForgotPassword());
                    },
                    child: Container(

                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue.shade800,
                      ),
                      child: const Center(
                        child: SmallText(text: 'Reset'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  InkWell(
                    onTap: (() => Get.back()),
                    child: Container(

                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue.shade800,
                      ),
                      child: const Center(
                        child: SmallText(text: 'Try Again'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}

Future<void> authInfoSuccessRegister(
    BuildContext context,
    String infoSubheading,
    String infoHeading,
    ) {
  return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            actionsPadding: const EdgeInsets.only(bottom: 10,),
            scrollable: true,
            backgroundColor: CupertinoColors.darkBackgroundGray,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.green,
                        child: ClipOval(
                          child: SizedBox(
                            height: 90,
                            width: 90,
                            child: Center(
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 90,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: BigText(
                      text: infoHeading,
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.blue.shade800,
                    endIndent: 30,
                    indent: 30,
                  ),
                  Center(
                    child: Text(
                      infoSubheading,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => const LoginScreen());
                    },
                    child: Container(

                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue.shade800,
                      ),
                      child: const Center(
                        child: SmallText(text: 'Login'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}


Future<void> logoutInfo(
    BuildContext context,) {
  return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            actionsPadding: const EdgeInsets.only(bottom: 10,),
            scrollable: true,
            backgroundColor: CupertinoColors.darkBackgroundGray,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.blue.shade800,
                        child: const ClipOval(
                          child: SizedBox(
                            height: 90,
                            width: 90,
                            child: Center(
                              child: Icon(
                                Icons.info,
                                color: Colors.white,
                                size: 90,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: BigText(
                      text: 'Confirm Logout',
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.blue.shade800,
                    endIndent: 30,
                    indent: 30,
                  ),
                  const Center(
                    child: Text(
                      'Are you sure you want to logout?',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(

                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue.shade800,
                      ),
                      child: const Center(
                        child: SmallText(text: 'Cancel'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      AuthService.firebase().logOut();
                      Get.offAll(
                            () => const LoginScreen(),
                        transition: Transition.leftToRightWithFade,
                      );
                    },
                    child: Container(

                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue.shade800,
                      ),
                      child: const Center(
                        child: SmallText(text: 'Logout'),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      });
}


