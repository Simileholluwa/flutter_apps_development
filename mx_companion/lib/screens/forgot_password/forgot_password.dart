import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mx_companion/Services/Authentication/auth_service.dart';
import 'package:mx_companion/widgets/alert_widget.dart';
import '../../Services/Authentication/auth_exceptions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import '../login_screen/login_screen.dart';
import '../register_screen/register_screen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  late TextEditingController emailController;
  var email = '';

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

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
                    text: "Password Reset",
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
                    text: "Enter your registered email below",
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
                    GestureDetector(
                      onTap: () async {
                        var email = emailController.text.trim().capitalizeFirst;
                        final isValid = _formKey.currentState!.validate();
                        if (!isValid) {
                          return;
                        } else {
                          _formKey.currentState!.save();
                          try {
                            _isLoading = true;
                            setState(() {});
                            await AuthService.firebase()
                                .resetPassword(email: email!);
                            setState(() {});
                            _isLoading = false;
                            authInfoSuccessRegister(
                              context,
                              'Password reset link has been sent to your email. Follow the link to reset your password.',
                              'Password Reset Link Sent',
                            );
                          } on UserNotFoundAuthException {
                            setState(() {});
                            _isLoading = false;
                            await authInfoErrorRegister(
                                context,
                                'No account found with this email.',
                                'Error Resetting Password',
                                    );
                          } on TooManyRequestAuthException {
                            setState(() {});
                            _isLoading = false;
                            await authInfoError(
                                context,
                                'Please check your email for your password reset link.',
                                'Error Resetting Password',
                                );
                          } on GenericAuthException {
                            setState(() {});
                            _isLoading = false;
                            authInfoSuccessRegister(
                              context,
                              'Password reset link has been sent to your email. Follow the link to reset your password.',
                              'Password Reset Link Sent',
                            );
                          } on NetworkRequestFailedAuthException {
                            setState(() {});
                            _isLoading = false;
                            await authInfoError(
                                context,
                                'You are not connected to the internet. Ensure you have a stable connection.',
                                'Error Resetting Password',
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
                              ? const BigText(text: 'Reset Password')
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
                      Get.offAll(() => const LoginScreen(),
                          transition: Transition.fadeIn);
                    },
                    child: Row(
                      children: const [
                        SmallText(
                          text: 'Login ',
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
