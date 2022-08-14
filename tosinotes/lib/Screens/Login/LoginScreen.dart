import 'package:flutter/material.dart';
import 'package:tosinotes/Constants/Routes.dart';
import 'package:tosinotes/Services/Authentication/auth_exceptions.dart';
import 'package:tosinotes/Services/Authentication/auth_service.dart';
import '../../Constants/Bottom_navigation_bar.dart';
import '../../Constants/functions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          //const BottomNavigation(),
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Enter your E-mail',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter your Password',
            ),
          ),
          const SizedBox(height: 30),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;

              try {
                await AuthService.firebase().logIn(
                  email: email,
                  password: password,
                );
                final user = AuthService.firebase().currentUser;
                final emailVerified = user?.isEmailVerified  ?? false;
                if (!emailVerified) {
                  Navigator.of(context)
                      .pushNamed(verifyRoute);
                } else {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(mainRoute, (route) => false);
                }
              } on UserNotFoundAuthException {
                  await showErrorDialog(context, 'No account found');
                }
                on WrongPasswordAuthException {
                    await showErrorDialog(context, 'Incorrect password');
                }
                on UnknownAuthException {
                  await showErrorDialog(context, 'Input required');
                }
                on InvalidEmailAuthException {
                  await showErrorDialog(context, 'Invalid email address');
                }
                on NetworkRequestFailedAuthException {
                  await showErrorDialog(context, 'No internet connection');
                }
                on TooManyRequestAuthException {
                  await showErrorDialog(context, 'Too many incorrect passwords');
                }
                on GenericAuthException {
                  await showErrorDialog(context, 'Authentication failed');
                }
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text('Not Registered yet? Register here'),
          ),
        ],
      ),
    );
  }
}

