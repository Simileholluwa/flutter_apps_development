import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mx_companion_v2/screens/login/login.dart';
import 'package:mx_companion_v2/services/Authentication/auth_exceptions.dart';
import '../config/themes/app_dark_theme.dart';
import '../firebase_ref/loading_status.dart';
import '../history/history.dart';
import '../screens/home/home_screen.dart';
import '../screens/home/menu_screen.dart';
import '../screens/reset_password/reset_password.dart';
import '../screens/signup/signup_screen.dart';
import '../services/Authentication/auth_service.dart';
import '../widgets/alert_user.dart';

class AuthController extends GetxController {
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs;
  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

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
      await AuthService.firebase().logIn(email: email, password: password,);
      _isLoading.value = false;
      navigateToHome();
      showSnackBar('Sign in', 'You have successfully signed in',  icon: Icons.check_circle, containerColor: Colors.green,);
    } on UserNotFoundAuthException {
      _isLoading.value = false;
      showSnackBar('An Error Occurred', 'No account found with this email.');
    } on WrongPasswordAuthException {
      _isLoading.value = false;
      showSnackBar('An Error Occurred', 'Your password is incorrect.');
    } on UnknownAuthException {
      _isLoading.value = false;
      showSnackBar('An Error Occurred', 'Text fields cannot be empty.');
    } on InvalidEmailAuthException {
      _isLoading.value = false;
      showSnackBar('An Error Occurred', 'The email address is invalid.');
    } on NetworkRequestFailedAuthException {
      _isLoading.value = false;
      showSnackBar('An Error Occurred', 'You are not connected to the internet.');
    } on TooManyRequestAuthException {
      _isLoading.value = false;
      showSnackBar('An Error Occurred', 'Your account is locked due to too many incorrect password. Please, try again later.');
    } on GenericAuthException {
      _isLoading.value = false;
      showSnackBar('An Error Occurred', 'Sign in failed. Try again later.');
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
      );
      _isLoading.value = false;
      navigateToLogin();
      showSnackBar('Sign up', 'You have successfully signed up',  icon: Icons.check_circle, containerColor: Colors.green,);

    } on WeakPasswordAuthException {
      _isLoading.value = false;
      showSnackBar('An Error Occurred', 'Password is too weak.');
    } on EmailAlreadyInUseAuthException {
      _isLoading.value = false;
      showSnackBar('An Error Occurred', 'This email already exist.');
    } on UnknownAuthException {
      _isLoading.value = false;
      showSnackBar('An Error Occurred', 'Text fields cannot be empty.');
    } on InvalidEmailAuthException {
      _isLoading.value = false;
      showSnackBar('An Error Occurred', 'The email address is invalid.');
    } on NetworkRequestFailedAuthException {
      _isLoading.value = false;
      showSnackBar('An Error Occurred', 'You are not connected to the internet.');
    } on TooManyRequestAuthException {
      _isLoading.value = false;
      showSnackBar('An Error Occurred', 'Too many incorrect password. Try again later.');
    } on GenericAuthException {
      _isLoading.value = false;
      showSnackBar('An Error Occurred', 'Sign in failed. Try again later.');
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
      showSnackBar('Reset password', 'Please check your email...',  icon: Icons.check_circle, containerColor: Colors.green,);

    } on UserNotFoundAuthException {
      _isLoading.value = false;
      showSnackBar('An Error Occurred', 'No account found with this email.');
    } on UnknownAuthException {
      _isLoading.value = false;
      showSnackBar('An Error Occurred', 'Text fields cannot be empty.');
    } on InvalidEmailAuthException {
      _isLoading.value = false;
      showSnackBar('An Error Occurred', 'The email address is invalid.');
    } on NetworkRequestFailedAuthException {
      _isLoading.value = false;
      showSnackBar('An Error Occurred', 'You are not connected to the internet.');
    } on TooManyRequestAuthException {
      _isLoading.value = false;
      showSnackBar('An Error Occurred', 'Too many requests sent. Try again later.');
    } on GenericAuthException {
      _isLoading.value = false;
      navigateToLogin();
      showSnackBar('Reset password', 'Please check your email including your spam folder.',  icon: Icons.check_circle, containerColor: Colors.green,);
    }
  }

  signOut() async {
    try {
      await AuthService.firebase().logOut();
      navigateToHome();
      showSnackBar('Sign out', 'You have successfully signed out',  icon: Icons.check_circle, containerColor: Colors.green,);

    } on UserNotLoggedInAuthException {
      showSnackBar('An Error Occurred', 'You are currently not signed in.');
    }

  }

  void navigateToHome() {
    Get.offAllNamed(HomeScreen.routeName);
  }

  void navigateToMenu() {
    Get.toNamed(MenuScreen.routeName);
  }

  void navigateToReset() {
    Get.toNamed(ResetPassword.routeName);
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
      Dialogs.appDialog(onTap: () {
        Get.back();
        navigateToLogin();
      }, onPressed: () {
        Get.back();
      },
          action: 'Sign In',
          text: 'Hello there!',
          message: 'To start practicing your selected course, you need to sign in. It will only take a while..',
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
      }, onPressed: () {
        Get.back();
      },
        action: 'Sign Out',
        text: 'Sign Out',
        message: 'Are you sure you want to sign out?',
      ),
      barrierDismissible: true,
    );
  }

  void showDeleteAllHistory(VoidCallback onTap) {
    Get.dialog(
      Dialogs.appDialog(
        onTap: onTap,
        onPressed: () {
          Get.back();
        },
        action: 'Delete',
        text: 'Delete All',
        message: 'Are you sure you want to delete all courses practice history?',
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

  void showSnackBar(String title, String message, {IconData icon = Icons.info_outline_rounded, Color containerColor = Colors.red}) {
    Get.snackbar(
      title,
      message,
      padding: const EdgeInsets.only(left: 25,),
      icon: Container(
        height: 60,
        width: 60,
        margin: const EdgeInsets.only(right: 10,),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: const BorderRadius.all(Radius.circular(10),),
        ),
        child: Icon(icon, size: 30, color: altTextColor,),
      ),
      margin: const EdgeInsets.only(left: 25, right: 25, top: 20,),
      borderRadius: 10,
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
      duration: const Duration(seconds: 3,),
    );
  }
}
