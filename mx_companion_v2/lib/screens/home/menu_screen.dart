import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mx_companion_v2/controllers/zoom_drawer.dart';
import '../../config/themes/app_dark_theme.dart';
import '../../config/themes/custom_text.dart';
import '../../widgets/app_button.dart';
import '../../widgets/content_area.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/icon_and_text.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  static const String routeName = "/menu";

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    MyZoomDrawerController controller = Get.find();
    return Scaffold(
      backgroundColor: primaryDarkColor1,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20, top: 20, left: 30, right: 30,),
        child: AppButton(
          noSplash: true,
          onTap: () {
            controller.user.value == null
                ? controller.signIn()
                : controller.signOut();
          },
          buttonWidget: controller.user.value == null
              ? Text(
                  'Sign in',
                  style: cardTitles,
                )
              : Text(
                  'Sign out',
                  style: cardTitles,
                ),
          btnColor: maroonColor,
        ),
      ),
      appBar: AppBar(
        backgroundColor: primaryDarkColor1,
        shadowColor: Colors.transparent,
        leading: Container(
          margin: const EdgeInsets.only(
            left: 15,
          ),
          child: CustomIconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icons.arrow_back_sharp,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              right: 15,
            ),
            child: CustomIconButton(
              onPressed: () {
                controller.openEmail();
              },
              icon: Icons.email,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            controller.user.value == null
                ? Container()
                : Positioned(
                    top: 53,
                    right: 18,
                    child: CustomIconButton(
                      onPressed: () {
                      },
                      icon: CupertinoIcons.camera_fill,
                    ),
                  ),
            Container(
              margin: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 20,
              ),
              child: Obx(
                () => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: primaryDark,
                            child: ClipOval(
                              child: SizedBox(
                                height: 110,
                                width: 110,
                                child: controller.user.value == null
                                    ? const Center(
                                      child: Icon(
                                          CupertinoIcons.person_alt_circle,
                                          size: 100,
                                        ),
                                    )
                                    : Image.network(
                                        controller.user.value!.photoURL!,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                            child: LoadingAnimationWidget
                                                .fourRotatingDots(
                                                    color: orangeColor,
                                                    size: 40),
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(
                                            CupertinoIcons.person_alt_circle,
                                            size: 100,
                                            color: Colors.white,
                                          );
                                        },
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Center(
                          child: controller.user.value == null
                              ? Text(
                                  'Hi there',
                                  style: smallLobster,
                                )
                              : Text(
                                  'Hello ${controller.user.value!.displayName}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: smallLobster,
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: ContentAreaCustom(
                          addPadding: false,
                          addRadius: true,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                controller.user.value == null
                                    ? Container()
                                    : IconAndText(
                                        onTap: () {},
                                        text: 'Profile Settings',
                                        icon: FontAwesomeIcons.gear,
                                      ),
                                controller.user.value == null
                                    ? Container()
                                    : IconAndText(
                                        onTap: () {},
                                        text: 'Practice History',
                                        icon: FontAwesomeIcons.chartSimple,
                                      ),
                                IconAndText(
                                  onTap: () {},
                                  text: 'FAQs',
                                  icon: FontAwesomeIcons.personCircleQuestion,
                                ),
                                IconAndText(
                                  onTap: () {},
                                  text: 'Feedback',
                                  icon: FontAwesomeIcons.heartCircleBolt,
                                ),
                                IconAndText(
                                  onTap: () {},
                                  text: 'Social Groups',
                                  icon: Icons.group_add_sharp,
                                  size: 30,
                                ),
                                IconAndText(
                                  onTap: () {},
                                  text: 'Notifications',
                                  icon: Icons.notifications,
                                ),
                                IconAndText(
                                  onTap: () {},
                                  text: 'Share App',
                                  icon: Icons.share_sharp,
                                ),
                                IconAndText(
                                  onTap: () {},
                                  text: 'About Us',
                                  icon: FontAwesomeIcons.addressBook,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: Text(
                        'Thank you for using MX Companion. Kindly shoot us a mail if you encounter any challenges or chat with us on WhatsApp. We value your reviews and support.\nTap on the "About Us" button for our contact details.',
                        textAlign: TextAlign.center,
                        style: smallestJost,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
