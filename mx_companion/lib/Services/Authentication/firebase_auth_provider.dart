import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mx_companion/Services/Authentication/auth_user.dart';
import 'package:mx_companion/Services/Authentication/auth_provider.dart';
import 'package:mx_companion/Services/Authentication/auth_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../firebase_options.dart';

class FirebaseAuthProvider implements AuthProvider {

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
    required String userName,
    required String department,
    required String phoneNumber,
    required String url,
    required DateTime created,
  }) async {
    try {

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseAuth.instance.currentUser!.updateDisplayName(userName);
      addUserDetails(email, department, phoneNumber, userName, created, url);

      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {

      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else if (e.code == 'unknown') {
        throw UnknownAuthException();
      } else if (e.code == 'network-request-failed') {
        throw NetworkRequestFailedAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }

  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    try {

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {

      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else if (e.code == 'unknown') {
        throw UnknownAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else if (e.code == 'network-request-failed') {
        throw NetworkRequestFailedAuthException();
      } else if (e.code == 'too-many-requests') {
        throw TooManyRequestAuthException();
      } else {
        throw GenericAuthException();
      }
    }
    catch (e) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }


  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<AuthUser> resetPassword({required String email}) async {
    try {

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {

      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'network-request-failed') {
        throw NetworkRequestFailedAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (e){
      throw GenericAuthException();
    }
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  Future addUserDetails(String email, String department, String phoneNumber, String userName, DateTime created, String url) async {
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('userDetails').add(
        {
          'email' : email,
          'department' : department,
          'phoneNumber' : phoneNumber,
          'userName' : userName,
          'url' : url,
          'created' : created,
        });
  }
}





