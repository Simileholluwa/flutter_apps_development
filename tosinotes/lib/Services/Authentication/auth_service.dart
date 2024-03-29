import 'package:firebase_core/firebase_core.dart';
import 'package:tosinotes/Services/Authentication/auth_provider.dart';
import 'package:tosinotes/Services/Authentication/auth_user.dart';
import 'package:tosinotes/Services/Authentication/firebase_auth_provider.dart';

import '../../firebase_options.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
    required String userName,
  }) =>
      provider.createUser(
        email: email,
        password: password,
        userName: userName,
      );

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      provider.logIn(
        email: email,
        password: password,
      );

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<AuthUser> resetPassword({required String email}) => provider.resetPassword(email: email);
}
