import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mx_companion_v2/controllers/zoom_drawer.dart';
import '../../config/themes/app_dark_theme.dart';
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
          controller.user.value == null? CustomIconButton(
            onPressed: () {
             controller.signIn();
            },
            icon: FontAwesomeIcons.arrowRightToBracket,
              size: 24,
          ) : CustomIconButton(
            onPressed: () {
              controller.signOut();
            },
            icon: FontAwesomeIcons.arrowRightFromBracket,
              size: 24,
          ),
          const SizedBox(width: 5,),
          Container(
            margin: const EdgeInsets.only(
              right: 15,
            ),
            child: CustomIconButton(
              onPressed: () {},
              icon: Icons.light_mode,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(
            left: 25,
            right: 25,
          ),
          child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryDarkColor,
                        ),
                        child: const Center(
                          child: Icon(
                            CupertinoIcons.person_alt_circle,
                            size: 120,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: controller.user.value == null
                        ? Text(
                            'Welcome To MX Companion',
                            style: GoogleFonts.lobsterTwo(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          )
                        : Text(
                            'Hello ${controller.user.value!.displayName}',
                            style: GoogleFonts.lobsterTwo(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 20,
                      ),
                      child: ContentAreaCustom(
                        addPadding: false,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              controller.user.value == null
                                  ? Container()
                                  : IconAndText(
                                      onTap: () {},
                                      text: 'Profile Settings',
                                      icon:
                                          FontAwesomeIcons.userGear,
                                    ),
                              controller.user.value == null
                                  ? Container()
                                  : IconAndText(
                                onTap: () {},
                                text: 'Practice History',
                                icon: Icons.history_sharp,
                              ),
                              IconAndText(
                                onTap: () {},
                                text: 'Leaderboard',
                                icon: FontAwesomeIcons.chartColumn,
                              ),
                              IconAndText(
                                onTap: () {},
                                text: 'FAQs',
                                icon: FontAwesomeIcons.question,
                              ),
                              IconAndText(
                                onTap: () {},
                                text: 'Feedback',
                                icon: FontAwesomeIcons.faceSmile,
                              ),
                              IconAndText(
                                onTap: () {},
                                text: 'Join WhatsApp Group',
                                icon: FontAwesomeIcons.whatsapp,
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Contact Us',
                        style: GoogleFonts.jost(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _DrawerIconButton(
                        icon: FontAwesomeIcons.whatsapp,
                        onPressed: () {},
                        color: const Color(0xFF25D366),
                      ),
                      _DrawerIconButton(
                        icon: FontAwesomeIcons.twitter,
                        onPressed: () {},
                        color: const Color(0xFF1DA1F2),
                      ),
                      _DrawerIconButton(
                        icon: FontAwesomeIcons.telegram,
                        onPressed: () {},
                        color: const Color(0xFF229ED9),
                      ),
                      _DrawerIconButton(
                        icon: FontAwesomeIcons.facebook,
                        onPressed: () {},
                        color: const Color(0xFF3B5998),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class _DrawerIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color color;
  const _DrawerIconButton(
      {Key? key, required this.icon, this.onPressed, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: color,
          size: 30,
        ),
      ),
    );
  }
}
