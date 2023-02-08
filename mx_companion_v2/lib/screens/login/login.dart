import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mx_companion_v2/controllers/auth_controller.dart';
import 'package:mx_companion_v2/widgets/app_button.dart';
import '../../config/themes/ui_parameters.dart';
import '../../widgets/text_button_with_icon.dart';
import '../../widgets/text_field.dart';
import '../../widgets/text_field_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  late TextEditingController emailController, passwordController;
  var email = '';
  var password = '';

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
          toolbarHeight: 70,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              'Login',
              style: Theme.of(context).textTheme.titleLarge!.merge(
                const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              textAlign: TextAlign.center,
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
                icon: const Icon(
                  Icons.home,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: UIParameters.mobileScreenPadding,
            child: Center(
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
                            image: AssetImage("assets/images/password.png"),
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
                          inputFormatter: [
                            FilteringTextInputFormatter(' ', allow: false)
                          ],
                          onSaved: (value) {
                            email = value!.removeAllWhitespace;
                          },
                          validator: (String? value) {
                            if (!GetUtils.isEmail(value!)) {
                              return 'Enter a valid email address';
                            } else if (value.isEmpty) {
                              return 'Enter cannot be empty';
                            } else if (value.contains(' ')){
                              return 'Remove all whitespaces';
                            }else {
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
                            var email =
                                emailController.text.trim().capitalizeFirst;
                            var password = passwordController.text.trim();
                            final isValid = _formKey.currentState!.validate();
                            if (!isValid) {
                              return;
                            } else {
                              _formKey.currentState!.save();
                              setState(() {});
                              controller.signInWithEmail(email!, password);
                            }
                          },
                          buttonWidget: controller.isLoading.isFalse
                              ? const Text(
                            'Login', style: TextStyle(fontSize: 20,),
                          )
                              : LoadingAnimationWidget.prograssiveDots(
                            color: Colors.blue,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButtonWithIcon(
                        onTap: () {
                          controller.navigateToReset();
                        },
                        text: 'Reset Password',
                      ),
                      TextButtonWithIcon(
                        onTap: () {
                          controller.navigateToSignup();
                        },
                        text: 'Register',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
