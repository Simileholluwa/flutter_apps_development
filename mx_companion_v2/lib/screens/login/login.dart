import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mx_companion_v2/controllers/auth_controller.dart';
import 'package:mx_companion_v2/widgets/app_button.dart';
import '../../config/themes/app_dark_theme.dart';
import '../../config/themes/ui_parameters.dart';
import '../../widgets/custom_icon_button.dart';
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
  //AuthController controller = Get.find();

  Color btnColor = maroonColor;

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
    return GetBuilder<AuthController>(builder: (controller){
      return Scaffold(
        backgroundColor: primaryDarkColor1,
        appBar: AppBar(

          backgroundColor: primaryDarkColor1,
          shadowColor: Colors.transparent,
          leading: Container(
            margin: const EdgeInsets.only(left: 15,),
            child: CustomIconButton(
              onPressed: (){
                controller.navigateToHome();
              },
              icon:Icons.home,
            ),
          ),
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
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryDark,
                    ),
                    child: const Center(
                      child: Icon(FontAwesomeIcons.unlockKeyhole, size: 70, color: altTextColor,),
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
                            final isValid = _formKey.currentState!.validate();
                            if(!isValid){
                              return;
                            } else {
                              _formKey.currentState!.save();
                              setState((){
                              });
                              controller.signInWithEmail(email!, password);
                            }
                          },
                          buttonWidget: controller.isLoading == false ? Text(
                            'Sign In',
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButtonWithIcon(
                        onTap: () {
                          controller.navigateToReset();
                        },
                        text: 'Forgot Password',
                      ),
                      TextButtonWithIcon(
                        onTap: () {
                          controller.navigateToSignup();
                        },
                        text: 'Sign Up',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

