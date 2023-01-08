import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  static const routeName = "/reset";

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthController controller = Get.find();

  Color btnColor = maroonColor;

  late TextEditingController emailController, passwordController;
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
                    child: Icon(FontAwesomeIcons.shield, size: 70, color: altTextColor,),
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
                        inputAction : TextInputAction.done,
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
                      AppButton(
                        noSplash: true,
                        onTap: () {
                          var email = emailController.text.trim().capitalizeFirst;
                          final isValid = _formKey.currentState!.validate();
                          if(!isValid){
                            return;
                          } else {
                            _formKey.currentState!.save();
                            setState((){});
                            controller.resetPassword(email!);
                          }
                        },
                        buttonWidget: controller.isLoading == false ? Text(
                          'Reset',
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
                        controller.navigateToLogin();
                      },
                      text: 'Sign In',
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
      );
    });
  }
}
