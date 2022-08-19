import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mx_companion_v2/screens/login/login.dart';
import '../firebase_ref/loading_status.dart';
import '../firebase_ref/references.dart';
import '../widgets/alert_user.dart';



class AuthController extends GetxController {
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs;

  late FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
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
    try {
      loadingStatus.value = LoadingStatus.loading;
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        loadingStatus.value = LoadingStatus.loading;
        final _authAccount = await account.authentication;
        final _credential = GoogleAuthProvider.credential(
          idToken: _authAccount.idToken,
          accessToken: _authAccount.accessToken,
        );
        await _auth.signInWithCredential(_credential);
        await saveUser(account);
        navigateToHome();
        loadingStatus.value = LoadingStatus.completed;
      }

    } on Exception catch (error) {
      print(error);
      loadingStatus.value = LoadingStatus.error;
    }
  }

  User? getUser(){
    _user.value = _auth.currentUser;
    return _user.value;
  }

  saveUser(GoogleSignInAccount account) {
    userRF.doc(account.email).set({
      'email': account.email,
      'name': account.displayName,
      'profile_pic': account.photoUrl,
    });
  }

  Future<void> signOut() async {
    try {
      loadingStatus.value = LoadingStatus.loading;
      await _googleSignIn.disconnect();
      await _auth.signOut();
      navigateToHome();
      loadingStatus.value = LoadingStatus.completed;
    } on FirebaseAuthException catch (e) {
      loadingStatus.value = LoadingStatus.error;
    } catch (e) {
      loadingStatus.value = LoadingStatus.error;
    }
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
