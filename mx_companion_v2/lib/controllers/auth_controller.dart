
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mx_companion_v2/screens/login/login.dart';
import 'package:mx_companion_v2/services/Authentication/auth_exceptions.dart';
import '../firebase_ref/loading_status.dart';
import '../screens/faq/faq.dart';
import '../screens/history/history.dart';
import '../screens/home/home_screen.dart';
import '../screens/home/menu_screen.dart';
import '../screens/notification/notification.dart';
import '../screens/reset_password/reset_password.dart';
import '../screens/signup/signup_screen.dart';
import '../services/Authentication/auth_service.dart';
import '../widgets/alert_user.dart';

class AuthController extends GetxController {
  @override
  void onReady() {
    initAuth();
    getToken();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs;
  final RxBool _isLoading = false.obs;

  RxBool get isLoading => _isLoading;
  String? m_token = "";
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  late FirebaseAuth _auth;
  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;

  void initAuth() async {
    await Future.delayed(const Duration(seconds: 10));
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
    //navigateToUploader();
    navigateToHome();
  }

  signInWithEmail(String email, String password) async {
    try {
      _isLoading.value = true;
      await AuthService.firebase().logIn(
        email: email,
        password: password,
      );
      _isLoading.value = false;
      navigateToHome();
      showSnackBar('Signed in as ${_user.value!.displayName}');
    } on UserNotFoundAuthException {
      _isLoading.value = false;
      showSnackBar('No account found with this email.');
    } on WrongPasswordAuthException {
      _isLoading.value = false;
      showSnackBar('Your password is incorrect.');
    } on UnknownAuthException {
      _isLoading.value = false;
      showSnackBar('Text fields cannot be empty.');
    } on InvalidEmailAuthException {
      _isLoading.value = false;
      showSnackBar('The email address is invalid.');
    } on NetworkRequestFailedAuthException {
      _isLoading.value = false;
      showSnackBar('You are not connected to the internet.');
    } on TooManyRequestAuthException {
      _isLoading.value = false;
      showSnackBar(
          'Your account is locked due to too many incorrect password. Please, try again later.');
    } on GenericAuthException {
      _isLoading.value = false;
      showSnackBar('Sign in failed. Try again later.');
    }
  }

  signUpWithEmail(
    String email,
    String password,
    String userName,
    String department,
    String phoneNumber,
    String url,
    DateTime created,
  ) async {
    try {
      _isLoading.value = true;
      await AuthService.firebase().createUser(
        email: email,
        password: password,
        userName: userName,
        department: department,
        phoneNumber: phoneNumber,
        url: url,
        created: created,
        deviceToken: m_token!,
      );
      _isLoading.value = false;
      navigateToLogin();
      showSnackBar(
        'Sign up successful.',
      );
    } on WeakPasswordAuthException {
      _isLoading.value = false;
      showSnackBar('Password is too weak.');
    } on EmailAlreadyInUseAuthException {
      _isLoading.value = false;
      showSnackBar('This email already exist.');
    } on UnknownAuthException {
      _isLoading.value = false;
      showSnackBar('Text fields cannot be empty.');
    } on InvalidEmailAuthException {
      _isLoading.value = false;
      showSnackBar('The email address is invalid.');
    } on NetworkRequestFailedAuthException {
      _isLoading.value = false;
      showSnackBar('You are not connected to the internet.');
    } on TooManyRequestAuthException {
      _isLoading.value = false;
      showSnackBar('Too many incorrect password. Try again later.');
    } on GenericAuthException {
      _isLoading.value = false;
      showSnackBar('Sign in failed. Try again later.');
    }
  }

  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }

  resetPassword(String email) async {
    try {
      _isLoading.value = true;
      await AuthService.firebase().resetPassword(email: email);
      _isLoading.value = false;
      navigateToLogin();
      showSnackBar(
        'Check your email for password reset instructions.',
      );
    } on UserNotFoundAuthException {
      _isLoading.value = false;
      showSnackBar('No account found with this email.');
    } on UnknownAuthException {
      _isLoading.value = false;
      showSnackBar('Text fields cannot be empty.');
    } on InvalidEmailAuthException {
      _isLoading.value = false;
      showSnackBar('The email address is invalid.');
    } on NetworkRequestFailedAuthException {
      _isLoading.value = false;
      showSnackBar('You are not connected to the internet.');
    } on TooManyRequestAuthException {
      _isLoading.value = false;
      showSnackBar('Too many requests sent. Try again later.');
    } on GenericAuthException {
      _isLoading.value = false;
      navigateToLogin();
      showSnackBar(
        'Check your email for password reset instructions.',
      );
    }
  }

  signOut() async {
    try {
      await AuthService.firebase().logOut();
      navigateToHome();
      showSnackBar(
        'Signed out successfully.',
      );
    } on UserNotLoggedInAuthException {
      showSnackBar('You are currently not signed in.');
    }
  }

  void navigateToHome() {
    Get.offAllNamed(HomeScreen.routeName);
  }

  void navigateToFaq() {
    Get.toNamed(FaqScreen.routeName);
  }

  void navigateToMenu() {
    Get.toNamed(MenuScreen.routeName);
  }

  void navigateToReset() {
    Get.toNamed(ResetPassword.routeName);
  }

  void navigateToNotifications(){
    Get.toNamed(NotificationScreen.routeName);
  }

  void navigateToUploader() {
    Get.offAllNamed("/uploader");
  }

  void navigateToLogin() {
    Get.toNamed(LoginScreen.routeName);
  }

  void navigateToSignup() {
    Get.toNamed(SignupScreen.routeName);
  }

  void navigateToHistory() {
    Get.toNamed(HistoryScreen.routeName);
  }

  void showLoginAlertDialog() {
    Get.dialog(
      Dialogs.appDialog(
        onTap: () {
          Get.back();
          navigateToLogin();
        },
        onPressed: () {
          Get.back();
        },
        action: 'Sign In',
        text: 'Hello there!',
        message:
            'To start practicing your selected course, you need to sign in. It will only take a while..',
      ),
      barrierDismissible: true,
    );
  }

  void showSignOutAlertDialog() {
    Get.dialog(
      Dialogs.appDialog(
        onTap: () {
          Get.back();
          signOut();
        },
        onPressed: () {
          Get.back();
        },
        action: 'Sign Out',
        text: 'Sign Out',
        message: 'Are you sure you want to sign out?',
      ),
      barrierDismissible: true,
    );
  }

  void showDeleteAllHistory(VoidCallback onTap, String message) {
    Get.dialog(
      Dialogs.appDialog(
        onTap: onTap,
        onPressed: () {
          Get.back();
        },
        action: 'Delete',
        text: 'Delete All',
        message: message,
      ),
      barrierDismissible: true,
    );
  }

  Future<bool?> showDeleteHistory(
    VoidCallback onTap,
    String text,
    String message,
  ) async {
    return Get.dialog(
      Dialogs.appDialog(
        onTap: onTap,
        onPressed: () {
          Get.back();
        },
        action: 'Delete',
        text: text,
        message: message,
      ),
      barrierDismissible: true,
    );
  }

  void showPracticeInfo(VoidCallback onTap, String message) {
    Get.dialog(
      Dialogs.appDialog(
        onTap: onTap,
        onPressed: () {
          Get.back();
        },
        action: 'Start',
        text: 'Heads Up!',
        message: message,
      ),
      barrierDismissible: true,
    );
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  void showSnackBar(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
    );
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      m_token = token;
      update();
    });
  }

}
