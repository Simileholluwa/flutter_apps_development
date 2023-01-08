import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:image_picker/image_picker.dart';
import '../../Services/Authentication/auth_exceptions.dart';
import '../../Services/Authentication/auth_service.dart';
import '../../app_course_data.dart';
import '../../widgets/alert_widget.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import '../login_screen/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  bool _isLoading = false;
  late TextEditingController emailController,
      passwordController,
      phoneNumberController,
      departmentController,
      userNameController;

  var email = '';
  var password = '';
  var userName = '';
  var phoneNumber = '';
  var department = '';

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    userNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    departmentController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    phoneNumberController.dispose();
    departmentController.dispose();
    super.dispose();
  }

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _photo = File(pickedFile!.path);
    });
  }

  Future uploadImage(BuildContext context) async {
    if (_photo != null) {
      setState(() {});
      Reference ref = FirebaseStorage.instance.ref();
      TaskSnapshot addImg = await ref.child("image/img").putFile(_photo!);
      if (addImg.state == TaskState.success) {
        setState(() {});
        if (kDebugMode) {
          print("Image added");
        }
      }
    }
  }

  DropdownMenuItem<String> buildMenuItem(String gender) => DropdownMenuItem(
        value: gender,
        child: SmallText(
          text: gender,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 80, bottom: 40),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                BigText(
                  text: "Let's Get You Registered",
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
                  text: "Just a few information and you are onboard!",
                  color: Colors.grey.shade500,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 30,
            ),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (value) {
                      department = value!;
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Department field is required';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                    controller: departmentController,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Jost',
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.school,
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
                      hintText: "Enter your department",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontFamily: "Jost",
                        fontWeight: FontWeight.bold,
                      ),
                      labelText: 'Department',
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
                      phoneNumber = value!;
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Phone number field is required';
                      } else if (value.length != 11) {
                        return 'Phone number must be 11 digits long';
                      }
                      else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.phone,
                    controller: phoneNumberController,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Jost',
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone_iphone_sharp,
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
                      hintText: "Enter your phone number",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontFamily: "Jost",
                        fontWeight: FontWeight.bold,
                      ),
                      labelText: 'Phone Number',
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
                      userName = value!;
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Username field is required';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                    controller: userNameController,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Jost',
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
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
                      hintText: "Enter a unique username",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontFamily: "Jost",
                        fontWeight: FontWeight.bold,
                      ),
                      labelText: 'Username',
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
                      suffixIcon: Container(
                        margin: const EdgeInsets.only(right: 15,),
                        child: IconButton(
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
                      var userName = userNameController.text.trim().capitalizeFirst;
                      var department = departmentController.text.trim().capitalizeFirst;
                      var phoneNumber = phoneNumberController.text.trim();
                      final isValid = _formKey.currentState!.validate();
                      if (!isValid) {
                        return;
                      } else {
                        _formKey.currentState!.save();
                        try {
                          _isLoading = true;
                          setState(() {});
                          await AuthService.firebase().createUser(
                            email: email!,
                            password: password,
                            userName: userName!,
                            department: department!,
                            phoneNumber: phoneNumber,
                            url: '',
                            created: DateTime.now(),
                          );
                          _isLoading = false;
                          setState(() {});
                          authInfoSuccessRegister(
                            context,
                            'Your account has been successfully created, click the button below to Log in to your new account.',
                            'Sign Up Successful',
                          );
                        } on WeakPasswordAuthException {
                          setState(() {});
                          _isLoading = false;
                          await authInfoError(
                              context,
                              'Your password is too weak.',
                              'Error Signing Up', );
                        } on EmailAlreadyInUseAuthException {
                          setState(() {});
                          _isLoading = false;
                          await authInfoErrorLogin(
                              context,
                              'This email already exist.',
                              'Error Signing Up',);
                        } on InvalidEmailAuthException {
                          setState(() {});
                          _isLoading = false;
                          await authInfoError(
                              context,
                              'Please enter a valid email.',
                              'Error Signing Up', );
                        } on UnknownAuthException {
                          setState(() {});
                          _isLoading = false;
                          await authInfoError(
                              context,
                              'Text fields cannot be empty',
                              'Error Signing Up',);
                        } on NetworkRequestFailedAuthException {
                          setState(() {});
                          _isLoading = false;
                          await authInfoError(
                              context,
                              'You are not connected to the internet. Ensure you have a stable connection.',
                              'Error Signing Up', );
                        } on GenericAuthException {
                          setState(() {});
                          _isLoading = false;
                          authInfoSuccessRegister(
                            context,
                            'Your account has been successfully created, click the button below to Log in to your new account.',
                            'Sign Up Successful',
                          );
                        }
                      }
                      _isLoading = false;
                      setState(() {});
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 10),
                      width: double.maxFinite,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue.shade800,
                      ),
                      child: Center(
                        child: !_isLoading
                            ? const BigText(text: 'Register')
                            : LoadingAnimationWidget.prograssiveDots(
                                color: Colors.white, size: 50),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.offAll(() => const LoginScreen(),
                  transition: Transition.fadeIn);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: Colors.blue,
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const SmallText(
                      text: 'Login',
                      color: Colors.blue,
                      size: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
