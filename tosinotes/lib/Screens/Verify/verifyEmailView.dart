import 'package:flutter/material.dart';
import 'package:tosinotes/Constants/Bottom_navigation_bar.dart';
import 'package:tosinotes/Constants/Routes.dart';
import 'package:tosinotes/Services/Authentication/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Column(
        children: [
          //const BottomNavigation(),
          const Text('Email verification sent, check your email.'),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().sendEmailVerification();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text('Resend E-mail Verification'),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text('Email verified? Sign in'),
          ),
        ],
      ),
    );
  }
}
