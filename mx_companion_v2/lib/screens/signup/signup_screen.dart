import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../config/themes/app_dark_theme.dart';
import '../../config/themes/ui_parameters.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/app_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/text_button_with_icon.dart';
import '../../widgets/text_field.dart';
import '../../widgets/text_field_password.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  static const String routeName = "/signup";

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthController controller = Get.find();

  Color btnColor = maroonColor;

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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller){
      return Scaffold(
        backgroundColor: primaryDarkColor1,
        appBar: AppBar(
          backgroundColor: primaryDarkColor1,
          shadowColor: Colors.transparent,
          leading: Container(
            margin: const EdgeInsets.only(
              left: 15,
            ),
            child: CustomIconButton(
              onPressed: () {
                controller.navigateToHome();
              },
              icon: Icons.home,
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: UIParameters.mobileScreenPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryDark,
                  ),
                  child: const Center(
                    child: Icon(CupertinoIcons.person, size: 90, color: altTextColor,),
                  ),
                ),
                Text(
                  'MX Companion',
                  style: GoogleFonts.jost(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),

                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      CustomTextField(
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
                        hintText: 'Department',
                        labelText: 'Department',
                        prefixIcon: Icons.school,
                        textInputType: TextInputType.text,
                        controller: departmentController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        onSaved: (value) {
                          phoneNumber = value!;
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Phone number field is required';
                          } else if (value.length != 11) {
                            return 'Phone number must be 11 digits long';
                          } else {
                            return null;
                          }
                        },
                        hintText: 'Phone number',
                        labelText: 'Phone number',
                        prefixIcon: Icons.mail,
                        textInputType: TextInputType.phone,
                        controller: phoneNumberController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        onSaved: (value) {
                          userName = value!;
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Username field is required';
                          } else if(value.length > 15) {
                            return 'Username should be at most 15 characters';
                          }
                          else {
                            return null;
                          }
                        },
                        hintText: 'Username',
                        labelText: 'Username',
                        prefixIcon: Icons.person,
                        textInputType: TextInputType.text,
                        controller: userNameController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
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
                        hintText: 'Email',
                        labelText: 'Email',
                        prefixIcon: Icons.mail,
                        textInputType: TextInputType.emailAddress,
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFieldPW(
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
                        hintText: 'Password',
                        labelText: 'Password',
                        prefixIcon: Icons.password,
                        controller: passwordController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppButton(
                        noSplash: true,
                        onTap: () {
                          var email = emailController.text.trim().capitalizeFirst;
                          var password = passwordController.text.trim();
                          var userName =
                              userNameController.text.trim().capitalizeFirst;
                          var department =
                              departmentController.text.trim().capitalizeFirst;
                          var phoneNumber = phoneNumberController.text.trim();
                          var url = 'https://pixabay.com/get/g1a15e8abc18a61f2df80b2b18a5d07950815f2bc3cb9fa515f4d05fca938b9f32adfaaff469550813ddea11cf47d4bb7f9063109d33d9ab1346e594ea8b266dba274160a6856d1b0c02c6a830f2b01f0_640.jpg';
                          var created = DateTime.now();
                          final isValid = _formKey.currentState!.validate();
                          if (!isValid) {
                            return;
                          } else {
                            _formKey.currentState!.save();
                            setState(() {});
                            controller.signUpWithEmail(
                              email!,
                              password,
                              userName!,
                              department!,
                              phoneNumber,
                              url,
                              created,
                            );
                          }
                        },
                        buttonWidget: controller.isLoading == false ? Text(
                          'Sign Up',
                          style: GoogleFonts.jost(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: altTextColor,
                          ),
                        ) : LoadingAnimationWidget.prograssiveDots(color: altTextColor, size: 60,),
                        btnColor: btnColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButtonWithIcon(
                      onTap: () {
                        controller.navigateToLogin();
                      },
                      text: 'Sign In',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
