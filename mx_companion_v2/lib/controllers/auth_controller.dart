import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mx_companion_v2/screens/login/login.dart';
import 'package:mx_companion_v2/services/Authentication/auth_exceptions.dart';
import '../config/themes/app_dark_theme.dart';
import '../firebase_ref/loading_status.dart';
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
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late FirebaseAuth _auth;
  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;

  void initAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
    navigateToHome();
  }

  signInWithEmail(String email, String password) async {
    try {
      _isLoading = true;
      await AuthService.firebase().logIn(email: email, password: password,);
      _isLoading = false;
      navigateToHome();
      showSnackBar('Sign in', 'Signed in successfully...',  icon: Icons.check_circle, containerColor: Colors.green,);
    } on UserNotFoundAuthException {
      _isLoading = false;
      showSnackBar('An Error Occurred', 'No account found with this email.');
    } on WrongPasswordAuthException {
      _isLoading = false;
      showSnackBar('An Error Occurred', 'Your password is incorrect.');
    } on UnknownAuthException {
      _isLoading = false;
      showSnackBar('An Error Occurred', 'Text fields cannot be empty.');
    } on InvalidEmailAuthException {
      _isLoading = false;
      showSnackBar('An Error Occurred', 'The email address is invalid.');
    } on NetworkRequestFailedAuthException {
      _isLoading = false;
      showSnackBar('An Error Occurred', 'You are not connected to the internet.');
    } on TooManyRequestAuthException {
      _isLoading = false;
      showSnackBar('An Error Occurred', 'Too many incorrect password. Try again later.');
    } on GenericAuthException {
      _isLoading = false;
      showSnackBar('An Error Occurred', 'Sign in failed. Try again later.');
    }
    update();
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
      _isLoading = true;
      await AuthService.firebase().createUser(
        email: email,
        password: password,
        userName: userName,
        department: department,
        phoneNumber: phoneNumber,
        url: url,
        created: created,
      );
      _isLoading = false;
      navigateToLogin();
      showSnackBar('Sign up', 'Signed up successfully...',  icon: Icons.check_circle, containerColor: Colors.green,);

    } on WeakPasswordAuthException {
      _isLoading = false;
      showSnackBar('An Error Occurred', 'Password is too weak.');
    } on EmailAlreadyInUseAuthException {
      _isLoading = false;
      showSnackBar('An Error Occurred', 'This email already exist.');
    } on UnknownAuthException {
      _isLoading = false;
      showSnackBar('An Error Occurred', 'Text fields cannot be empty.');
    } on InvalidEmailAuthException {
      _isLoading = false;
      showSnackBar('An Error Occurred', 'The email address is invalid.');
    } on NetworkRequestFailedAuthException {
      _isLoading = false;
      showSnackBar('An Error Occurred', 'You are not connected to the internet.');
    } on TooManyRequestAuthException {
      _isLoading = false;
      showSnackBar('An Error Occurred', 'Too many incorrect password. Try again later.');
    } on GenericAuthException {
      _isLoading = false;
      showSnackBar('An Error Occurred', 'Sign in failed. Try again later.');
    }
    update();
  }

  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }

  resetPassword(String email) async {
    try {
      _isLoading = true;
      await AuthService.firebase().resetPassword(email: email);
      _isLoading = false;
      navigateToLogin();
      showSnackBar('Reset password', 'Please check your email...',  icon: Icons.check_circle, containerColor: Colors.green,);

    } on UserNotFoundAuthException {
      _isLoading = false;
      showSnackBar('An Error Occurred', 'No account found with this email.');
    } on UnknownAuthException {
      _isLoading = false;
      showSnackBar('An Error Occurred', 'Text fields cannot be empty.');
    } on InvalidEmailAuthException {
      _isLoading = false;
      showSnackBar('An Error Occurred', 'The email address is invalid.');
    } on NetworkRequestFailedAuthException {
      _isLoading = false;
      showSnackBar('An Error Occurred', 'You are not connected to the internet.');
    } on TooManyRequestAuthException {
      _isLoading = false;
      showSnackBar('An Error Occurred', 'Too many requests sent. Try again later.');
    } on GenericAuthException {
      _isLoading = false;
      navigateToLogin();
      showSnackBar('Reset password', 'Please check your email including your spam folder.',  icon: Icons.check_circle, containerColor: Colors.green,);
    }
    update();
  }

  signOut() async {
    try {
      await AuthService.firebase().logOut();
      navigateToHome();
      showSnackBar('Sign out', 'Signed out successfully...',  icon: Icons.check_circle, containerColor: Colors.green,);

    } on UserNotLoggedInAuthException {
      showSnackBar('An Error Occurred', 'You are currently not signed in.');
    }

  }

  void navigateToHome() {
    Get.offAllNamed("/homepage");
  }

  void navigateToMenu() {
    Get.toNamed(MenuScreen.routeName);
  }

  void navigateToReset() {
    Get.offAllNamed(ResetPassword.routeName);
  }

  void navigateToLogin() {
    Get.toNamed(LoginScreen.routeName);
  }

  void navigateToSignup() {
    Get.toNamed(SignupScreen.routeName);
  }

  void showLoginAlertDialog() {
    Get.dialog(
      Dialogs.appDialog(onTap: () {
        Get.back();
        navigateToLogin();
      }, onPressed: () {
        Get.back();
        navigateToSignup();
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
        child: Icon(icon, size: 30,),
      ),
      margin: const EdgeInsets.only(left: 25, right: 25, bottom: 50,),
      borderRadius: 10,
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: primaryDarkColor,
    );
  }
}
