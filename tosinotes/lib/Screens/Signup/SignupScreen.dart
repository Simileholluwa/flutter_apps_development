import 'package:flutter/material.dart';
import 'package:tosinotes/Constants/Bottom_navigation_bar.dart';
import 'package:tosinotes/Constants/Routes.dart';
import 'package:tosinotes/Services/Authentication/auth_exceptions.dart';
import '../../Constants/functions.dart';
import '../../Services/Authentication/auth_service.dart';
import '../../Services/Authentication/auth_service.dart';
import '../../Services/Authentication/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _userName;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _userName = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _userName.dispose();
    super.dispose();
  }

  //signup screen UI and logic
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
              final userName = _userName.text;
              try {
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                  userName: userName,
                );
                await AuthService.firebase().sendEmailVerification();
                Navigator.of(context).pushNamed(verifyRoute);
              } on WeakPasswordAuthException {
                  await showErrorDialog(context, 'Weak password');
                }
                on EmailAlreadyInUseAuthException {
                  await showErrorDialog(context, 'Email already exist');
                }
                on InvalidEmailAuthException {
                  await showErrorDialog(context, 'Invalid Email address');
                }
                on UnknownAuthException {
                  await showErrorDialog(context, 'Input required');
                }
                on NetworkRequestFailedAuthException {
                  await showErrorDialog(
                      context, 'No internet connection');
                }
              on GenericAuthException {
                await showErrorDialog(
                    context, 'Registration failed');
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text('Already have an account? Sign in'),
          ),
        ],
      ),
    );
  }
}
