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
              'Reset Password',
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
                            image: AssetImage("assets/images/reset-password.png"),
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
                          prefixIcon: Icons.mail,
                          textInputType: TextInputType.emailAddress,
                          controller: emailController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppButton(
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
                          buttonWidget: controller.isLoading.isFalse ? const Text(
                            'Reset Password', style: TextStyle(fontSize: 20,),
                          ) : LoadingAnimationWidget.prograssiveDots(color: textColor, size: 60,),
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
                          controller.navigateToLogin();
                        },
                        text: 'Login',
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
      );
  }
}
