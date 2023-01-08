import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tosinotes/Constants/Bottom_navigation_bar.dart';
import 'package:tosinotes/Screens/Welcome/welcomeScreen.dart';
import 'package:tosinotes/Services/Authentication/auth_service.dart';
import 'Constants/Routes.dart';
import 'Screens/Login/LoginScreen.dart';
import 'Screens/Main Application/firstInterface.dart';
import 'Screens/Signup/SignupScreen.dart';
import 'Screens/Verify/verifyEmailView.dart';
import 'firebase_options.dart';

//main function
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AuthService.firebase().initialize();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome Screen',
      home: const LoginScreen(),
      routes: {
        loginRoute: (context) => const LoginScreen(),
        registerRoute: (context) => const SignupScreen(),
        verifyRoute: (context) => const VerifyEmailView(),
        welcomeRoute : (context) => const WelcomeScreen(),
        mainRoute: (context) => const NotesView(),
        homeRoute: (context) => const HomePage(),
      },
    ),
  );
}

//Homepage class returns a screen based on executed condition
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black12,
      body: BottomNavigation(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(
      const Duration(seconds: 3), () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const HomePage()))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset('asset/images/logo.png'),
      ),
    );
  }
}
