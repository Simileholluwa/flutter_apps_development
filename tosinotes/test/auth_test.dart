import 'package:flutter_test/flutter_test.dart';
import 'package:tosinotes/Services/Authentication/auth_exceptions.dart';
import 'package:tosinotes/Services/Authentication/auth_provider.dart';
import 'package:tosinotes/Services/Authentication/auth_user.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();
    test('Should not be initialized at first', () {
      expect(provider.isInitialized, false);
    });

    test('Cannot logout if not initialized', () {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitializedException>()),
      );
    });

    test('Should be able to be initialized', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });

    test('User should be null after initialization', () {
      expect(provider.currentUser, null);
    });

    test('Should be able to be initialized in less than two seconds', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    }, timeout: const Timeout(Duration(seconds: 2)));

    test('Create user should delegate to log in function', () async {
      final badEmail = provider.createUser(
        userName: 'Tosin',
        email: 'foo@bar.com',
        password: 'anyPassword',
      );
      expect(badEmail, throwsA(const TypeMatcher<UserNotFoundAuthException>()));
      final badPassword = provider.createUser(
        email: 'someone@bar.com',
        password: 'foobar', userName: 'Mike',
      );
      expect(badPassword,
          throwsA(const TypeMatcher<WrongPasswordAuthException>()));
      final user = await provider.createUser(
        email: 'someone@gmail.com',
        password: 'anyPassword', userName: 'Mike',
      );
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });

    test('Logged in user should be able to ge verified', () {
      provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    test('Should be able to logout and login', () async {
      await provider.logOut();
      await provider.logIn(
        email: 'user',
        password: 'password',
      );
      final user = provider.currentUser;
      expect(user, isNotNull);
    });

  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialaized = false;
  bool get isInitialized => _isInitialaized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
    required String userName,
  }) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialaized = true;
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) {
    if (!isInitialized) throw NotInitializedException();
    if (email == 'foo@bar.com') throw UserNotFoundAuthException();
    if (password == 'foobar') throw WrongPasswordAuthException();
    const user = AuthUser(isEmailVerified: (false));
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(isEmailVerified: true);
    _user = newUser;
  }

  @override
  Future<AuthUser> resetPassword({required String email}) {
      if (!isInitialized) throw NotInitializedException();
      if (email == 'foo@bar.com') throw UserNotFoundAuthException();
      const user = AuthUser(isEmailVerified: (false));
      _user = user;
      return Future.value(user);

  }
}
