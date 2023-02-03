import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mx_companion_v2/controllers/zoom_drawer.dart';
import '../../widgets/app_button.dart';
import '../../widgets/content_area.dart';
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavBarStyle: FlexSystemNavBarStyle.scaffoldBackground,
        useDivider: false,
        opacity: 1,
      ),
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            bottom: 20,
            top: 20,
            left: 30,
            right: 30,
          ),
          child: AppButton(
            onTap: () {
              controller.user.value == null
                  ? controller.signIn()
                  : controller.signOut();
            },
            buttonWidget: controller.user.value == null
                ? const Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )
                : const Text(
                    'Sign out',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
          ),
        ),
        appBar: AppBar(
          scrolledUnderElevation: 0,
          toolbarHeight: 70,
          shadowColor: Colors.transparent,
          leading: Container(
            margin: const EdgeInsets.only(left: 30,),
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/man.png'),
              ),
            ),
          ),
          centerTitle: true,
          title: controller.user.value == null
              ? Text(
                  'Hi there',
                  style: Theme.of(context).textTheme.titleMedium!.merge(
                        const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                )
              : Text(
                  'Hello ${controller.user.value!.displayName}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleMedium!.merge(
                        const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                ),
          actions: [
            IconButton(
              onPressed: () {
                controller.openEmail();
              },
              icon: const Icon(
                Icons.email,
                size: 30,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                right: 15,
              ),
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
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
                          controller.user.value == null
                              ? Container()
                              : IconAndText(
                                  onTap: () {},
                                  text: 'Profile Settings',
                                  image: const AssetImage(
                                      "assets/images/settings (1).png"),
                                ),
                          controller.user.value == null
                              ? Container()
                              : IconAndText(
                                  onTap: () {
                                    controller.history();
                                  },
                                  text: 'Practice History',
                                  image: const AssetImage(
                                      "assets/images/bomb.png"),
                                ),
                          IconAndText(
                            onTap: () {},
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
                            onTap: () {},
                            text: 'Social Groups',
                            image: const AssetImage(
                                "assets/images/connection.png"),
                          ),
                          IconAndText(
                            onTap: () {},
                            text: 'Notifications',
                            image: const AssetImage(
                                "assets/images/newsletter.png"),
                          ),
                          IconAndText(
                            onTap: () {},
                            text: 'Share App',
                            image: const AssetImage("assets/images/share.png"),
                          ),
                          IconAndText(
                            onTap: () {},
                            text: 'About Us',
                            image:
                                const AssetImage("assets/images/comment.png"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    'Thank you for using MX Companion. Kindly shoot us a mail if you encounter any challenges.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
