import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mx_companion/screens/tab_view/tab_view.dart';
import '../../Services/Authentication/auth_exceptions.dart';
import '../../Services/Authentication/auth_service.dart';
import '../../widgets/alert_widget.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import '../forgot_password/forgot_password.dart';
import '../register_screen/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  bool _isLoading = false;
  late TextEditingController emailController, passwordController;

  var email = '';
  var password = '';

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  String? get userName => FirebaseAuth.instance.currentUser!.displayName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 80,
                bottom: 40,
              ),
              child: Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                ),
              ),
            ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  BigText(
                    text: "Account Login",
                    size: 30,
                    brightness: Brightness.light,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmallText(
                    text: "Login with your registered email",
                    color: Colors.grey.shade500,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (value) {
                        email = value!;
                      },
                      validator: (String? value) {
                        if (!GetUtils.isEmail(value!)) {
                          return 'Enter a valid email address';
                        } else if (value.isEmpty) {
                          return 'Enter cannot be empty';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Jost',
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.mark_as_unread,
                          color: Colors.grey.shade500,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white.withAlpha(20), width: 3.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white.withAlpha(20), width: 3.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "Enter your email address",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontFamily: "Jost",
                          fontWeight: FontWeight.bold,
                        ),
                        labelText: 'Email',
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontFamily: "Jost",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onSaved: (value) {
                        password = value!;
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Password cannot be empty';
                        } else if (value.length < 6) {
                          return 'Password is at least six characters long';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.text,
                      obscureText: _isHidden,
                      obscuringCharacter: '*',
                      controller: passwordController,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Jost',
                      ),
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey.shade500,
                        ),
                        suffixIcon: IconButton(
                          splashRadius: 5,
                          onPressed: () {
                            setState(() {
                              _isHidden = !_isHidden;
                            });
                          },
                          icon: Icon(
                            _isHidden ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white.withAlpha(20), width: 3.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white.withAlpha(20), width: 3.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "Input your password",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontFamily: "Jost",
                          fontWeight: FontWeight.bold,
                        ),
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontFamily: "Jost",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        var email = emailController.text.trim().capitalizeFirst;
                        var password = passwordController.text.trim();
                        final isValid = _formKey.currentState!.validate();
                        if (!isValid) {
                          return;
                        } else {
                          _formKey.currentState!.save();
                          try {
                            _isLoading = true;
                            setState(() {});
                            await AuthService.firebase().logIn(
                              email: email!,
                              password: password,
                            );
                            setState(() {});
                            _isLoading = false;
                            Get.offAll(() => const ScreensTabView(),
                                transition: Transition.fadeIn);
                          } on UserNotFoundAuthException {
                            setState(() {});
                            _isLoading = false;
                            await authInfoErrorRegister(
                                context,
                                'No account found with this email.',
                                'Error Logging In',
                                );
                          } on WrongPasswordAuthException {
                            setState(() {});
                            _isLoading = false;
                            await authInfoErrorForgotPassword(
                                context,
                                'Your password is incorrect.',
                                'Error Logging In',
                                    );
                          } on UnknownAuthException {
                            setState(() {});
                            _isLoading = false;
                            await authInfoError(
                                context,
                                'Text fields cannot be empty',
                                'Error Logging In',
                                );
                          } on InvalidEmailAuthException {
                            setState(() {});
                            _isLoading = false;
                            await authInfoError(
                                context,
                                'The email address is invalid',
                                'Error Logging In',
                                );
                          } on NetworkRequestFailedAuthException {
                            setState(() {});
                            _isLoading = false;
                            await authInfoError(
                                context,
                                'You are not connected to the internet. Ensure you have a stable connection.',
                                'Error Logging In',
                                );
                          } on TooManyRequestAuthException {
                            setState(() {});
                            _isLoading = false;
                            await authInfoErrorForgotPassword(
                                context,
                                'You have entered too many incorrect passwords. Please try again later or reset your password.',
                                'Error Logging In',
                                    );
                          } on GenericAuthException {
                            setState(() {});
                            _isLoading = false;
                            await authInfoError(
                                context,
                                'Log in failed. Please try again later.',
                                'Error Logging In',
                                );
                          }
                        }
                        setState(() {});
                        _isLoading = false;
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 15),
                        width: double.maxFinite,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue.shade800,
                        ),
                        child: Center(
                          child: !_isLoading
                              ? const BigText(text: 'Login')
                              : LoadingAnimationWidget.prograssiveDots(
                                  color: Colors.white, size: 50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.offAll(() => const RegisterScreen(),
                          transition: Transition.fadeIn);
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Colors.blue,
                        ),
                        SmallText(
                          text: 'Register',
                          color: Colors.blue,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(() => const ForgotPassword(),
                          transition: Transition.fadeIn);
                    },
                    child: Row(
                      children: const [
                        SmallText(
                          text: 'Forgot password ',
                          color: Colors.blue,
                          size: 15,
                        ),
                        Icon(
                          Icons.arrow_back_ios,
                          size: 15,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
