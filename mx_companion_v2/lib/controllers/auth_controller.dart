import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mx_companion_v2/screens/login/login.dart';

import '../firebase_ref/references.dart';
import '../widgets/alert_user.dart';

class AuthController extends GetxController {
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

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
    navigateToIntroduction();
  }

  signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final _authAccount = await account.authentication;
        final _credential = GoogleAuthProvider.credential(
          idToken: _authAccount.idToken,
          accessToken: _authAccount.accessToken,
        );

        await _auth.signInWithCredential(_credential);
        await saveUser(account);
      }
    } on Exception catch (error) {
      print(error);
    }
  }

  saveUser(GoogleSignInAccount account) {
    userRF.doc(account.email).set({
      'email': account.email,
      'name': account.displayName,
      'profile_pic': account.photoUrl,
    });
  }

  void navigateToIntroduction() {
    Get.offAllNamed("/homepage");
  }

  void navigateToHome() {
    Get.offAllNamed("/homepage");
  }

  void navigateToLogin(){
    Get.toNamed(LoginScreen.routeName);
  }

  void showLoginAlertDialog() {
    Get.dialog(
      Dialogs.paperStartDialog(onTap: () {
        Get.back();
        navigateToLogin();
      }),
      barrierDismissible: true,
    );
  }

  bool isLoggedIn(){
    return _auth.currentUser != null;
  }
}
