import 'auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();
  AuthUser? get currentUser;
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });
  Future<AuthUser> createUser({
    required String email,
    required String password,
    required String userName,
    required String department,
    required String phoneNumber,
    required String url,
    required DateTime created,
    required String deviceToken,
  });

  Future<AuthUser> resetPassword({
  required String email,
});

  Future<void> logOut();
  Future<void> sendEmailVerification();
}
