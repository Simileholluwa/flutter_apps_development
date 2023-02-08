import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mx_companion_v2/controllers/zoom_drawer.dart';
import '../../config/themes/app_dark_theme.dart';
import '../../widgets/alert_user.dart';
import '../../widgets/app_button.dart';
import '../../widgets/content_area.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/text_field.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  static const String routeName = "/menu";

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController phoneNumberController,
      departmentController,
      userNameController;

  var userName = '';
  var phoneNumber = '';
  var department = '';

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    departmentController = TextEditingController();
  }

  @override
  void dispose() {
    userNameController.dispose();
    phoneNumberController.dispose();
    departmentController.dispose();
    super.dispose();
  }

  final RxBool _isLoading = false.obs;

  @override
  Widget build(BuildContext context) {

    MyZoomDrawerController controller = Get.find();

    void showUpdateUserDetails(CollectionReference userDetails,) {
      Get.dialog(
        Dialogs.updateDetailsDialog(
          title: Column(
            children: [
              const SizedBox(height: 15,),
              Center(
                child: Text(
                  'Update Profile Details',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .merge(
                    const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Divider(
                thickness: 3,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ],
          ),
          content: StreamBuilder(
            stream: userDetails.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                departmentController.text =
                streamSnapshot.data!.docs[0]['department'];
                userNameController.text =
                streamSnapshot.data!.docs[0]['userName'];
                phoneNumberController.text =
                streamSnapshot.data!.docs[0]['phoneNumber'];
                return Container(
                  padding: EdgeInsets.only(
                    top: 20.0,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Obx(() => Form(
                    key: _formKey,
                    child: Wrap(
                      //spacing: 20,
                      runSpacing: 20,
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
                          labelText: 'Phone number',
                          prefixIcon: Icons.phone_android_rounded,
                          textInputType: TextInputType.phone,
                          controller: phoneNumberController,
                        ),
                        CustomTextField(
                          onSaved: (value) {
                            userName = value!;
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Username field is required';
                            } else if (value.length > 15) {
                              return 'Username should be at most 15 characters';
                            } else {
                              return null;
                            }
                          },
                          hintText: 'Username',
                          labelText: 'Username',
                          prefixIcon: Icons.person,
                          textInputType: TextInputType.text,
                          controller: userNameController,
                        ),
                        AppButton(
                          onTap: () async {
                            var userName = userNameController.text
                                .trim()
                                .capitalizeFirst;
                            var department = departmentController.text
                                .trim()
                                .capitalizeFirst;
                            var phoneNumber =
                            phoneNumberController.text.trim();
                            final isValid =
                            _formKey.currentState!.validate();
                            if (!isValid) {
                              return;
                            } else {
                              _formKey.currentState!.save();
                              _isLoading.value = true;
                              await userDetails
                                  .doc(streamSnapshot.data!.docs[0].id)
                                  .update({
                                'userName': userName,
                                'department': department,
                                'phoneNumber': phoneNumber,
                              });
                              await FirebaseAuth.instance.currentUser!
                                  .updateDisplayName(userName);
                              _isLoading.value = false;
                              Get.back();
                              controller.showSnackBar('Your profile has been updated', icon: Icons.check_circle, containerColor: Colors.green,);
                            }
                          },
                          buttonWidget: _isLoading.isFalse
                              ? const Text(
                            'Update', style: TextStyle(fontSize: 20,),
                          )
                              : LoadingAnimationWidget.prograssiveDots(
                            color: textColor,
                            size: 60,
                          ),
                        ),
                      ],
                    ),
                  ),),
                );
              }
              return Container(
                padding: EdgeInsets.only(
                  top: 20.0,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                  left: 20,
                  right: 20,
                ),
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: textColor,
                        size: 60,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        barrierDismissible: true,
      );
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        scrolledUnderElevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(
          top: 15,
          bottom: 5,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: ContentAreaCustom(
                  addPadding: false,
                  addRadius: true,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        GetBuilder<MyZoomDrawerController>(
                          builder: (_) {
                            return Center(
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 15,
                                  bottom: 10,
                                ),
                                height: 120,
                                width: 120,
                                child: controller.photo != null
                                    ? CircleAvatar(
                                        radius: 55,
                                        child: ClipOval(
                                          child: SizedBox(
                                            height: 110,
                                            width: 110,
                                            child: Image.file(
                                              controller.photo!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 55,
                                        child: ClipOval(
                                          child: SizedBox(
                                            height: 110,
                                            width: 110,
                                            child: Image.network(
                                              controller.user.value?.photoURL ??
                                                  "",
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child: LoadingAnimationWidget
                                                      .fourRotatingDots(
                                                          color: textColor,
                                                          size: 70),
                                                );
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/images/man.png"),
                                                    ),
                                                  ),
                                                );
                                              },
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),
                        Visibility(
                          visible: controller.isPhoto.isTrue,
                          child: Text(
                            controller.isUploading.isTrue
                                ? 'Uploading Profile Image...'
                                : 'Current Profile Image',
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            controller.user.value != null
                                ? IconButton(
                                    onPressed: () async {
                                      final CollectionReference userDetails =
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(controller.user.value!.uid)
                                              .collection('user_details');
                                      showUpdateUserDetails(
                                        userDetails,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 30,
                                    ),
                                  )
                                : Container(),
                            controller.user.value != null
                                ? IconButton(
                                    onPressed: () async {
                                      controller.imgFromGallery();
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      size: 30,
                                    ),
                                  )
                                : Container(),
                            IconButton(
                              onPressed: () {
                                controller.user.value == null
                                    ? controller.signIn()
                                    : controller.signOut();
                              },
                              icon: Icon(
                                controller.user.value == null
                                    ? Icons.login
                                    : Icons.logout,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 5,
                          thickness: 3,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: Column(
                            children: [
                              controller.user.value == null
                                  ? Container()
                                  : IconAndText(
                                onTap: () {
                                  controller.history();
                                },
                                text: 'Practice History',
                                image:
                                const AssetImage("assets/images/bomb.png"),
                              ),
                              IconAndText(
                                onTap: () {
                                  controller.faq();
                                },
                                text: 'FAQs',
                                image:
                                const AssetImage("assets/images/questions.png"),
                              ),
                              IconAndText(
                                onTap: () {},
                                text: 'Feedback',
                                image: const AssetImage(
                                    "assets/images/testimonials.png"),
                              ),
                              IconAndText(
                                onTap: () {
                                  controller.showJoinSocial();
                                },
                                text: 'Social Groups',
                                image:
                                const AssetImage("assets/images/connection.png"),
                              ),
                              controller.user.value == null ?
                              Container() :
                              IconAndText(
                                onTap: () {},
                                text: 'Notifications',
                                image:
                                const AssetImage("assets/images/newsletter.png"),
                              ),
                              IconAndText(
                                onTap: () {},
                                text: 'Share App',
                                image: const AssetImage("assets/images/share.png"),
                              ),
                              IconAndText(
                                onTap: () {},
                                text: 'About Us',
                                image: const AssetImage("assets/images/comment.png"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text('Contact Us'),
                ),
              ),
              Divider(
                height: 5,
                thickness: 3,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.openEmail();
                    },
                    icon: const Icon(
                      Icons.mail,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.openTelegram();
                    },
                    icon: const Icon(
                      Icons.telegram,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.openWhatsapp();
                    },
                    icon: const Icon(
                      Icons.whatsapp,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.openFacebook();
                    },
                    icon: const Icon(
                      Icons.facebook,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
