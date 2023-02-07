import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../config/themes/app_dark_theme.dart';
import '../../config/themes/ui_parameters.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/app_button.dart';
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
    AuthController controller = Get.find();
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: FlexColorScheme.themedSystemNavigationBar(
          context,
          systemNavBarStyle: FlexSystemNavBarStyle.scaffoldBackground,
          useDivider: false,
          opacity: 1,
        ),
        child: Scaffold(
          appBar: AppBar(
            shadowColor: Colors.transparent,
            scrolledUnderElevation: 0,
            toolbarHeight: 70,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                'Register',
                style: Theme.of(context).textTheme.titleLarge!.merge(
                  const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            actions: [
              Container(
              margin: const EdgeInsets.only(
                right: 15,
              ),
              child: IconButton(
                onPressed: () {
                  controller.navigateToHome();
                },
                icon: const Icon(Icons.home, size: 30,),
              ),
            ),
        ],
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
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Center(
                      child: Container(
                        height: 130,
                        width: 130,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/signup.png"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Obx(() => Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
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
                          inputFormatter: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          hintText: 'Phone number',
                          prefixIcon: Icons.phone_android_rounded,
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
                          prefixIcon: Icons.person,
                          textInputType: TextInputType.text,
                          controller: userNameController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          inputFormatter: [
                            FilteringTextInputFormatter(' ', allow: false)
                          ],
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
                          prefixIcon: Icons.password,
                          controller: passwordController,

                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppButton(
                          onTap: () {
                            var email = emailController.text.trim().capitalizeFirst;
                            var password = passwordController.text.trim();
                            var userName =
                                userNameController.text.trim().capitalizeFirst;
                            var department =
                                departmentController.text.trim().capitalizeFirst;
                            var phoneNumber = phoneNumberController.text.trim();
                            var url = '';
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
                          buttonWidget: controller.isLoading.isFalse
                              ? const Text(
                            'Register', style: TextStyle(fontSize: 20,),
                          )
                              : LoadingAnimationWidget.prograssiveDots(
                            color: textColor,
                            size: 60,
                          ),

                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButtonWithIcon(
                        onTap: () {
                          controller.navigateToLogin();
                        },
                        text: 'Login',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  }
}
