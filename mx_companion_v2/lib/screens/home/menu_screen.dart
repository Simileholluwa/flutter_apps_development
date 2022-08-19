import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mx_companion_v2/controllers/zoom_drawer.dart';
import '../../config/themes/app_dark_theme.dart';
import '../../config/themes/custom_text.dart';
import '../../controllers/auth_controller.dart';
import '../../firebase_ref/loading_status.dart';
import '../../widgets/AppIconText.dart';

class MenuScreen extends GetView<MyZoomDrawerController> {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController response = Get.find();

    return Container(
      height: double.maxFinite,
      width: 275,
      decoration: const BoxDecoration(
        color: transparentColor,
      ),
      child: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 30,
              right: 5,
              child: IconButton(
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
                iconSize: 40,
                onPressed: controller.toggleDrawer,
              ),
            ),
            Positioned(
              top: 40,
              left: 20,
              child: Text(
                'MX Companion',
                style: cardTitles(context),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 100, left: 20, bottom: 30, right: 20),
              child: Obx(() => controller.user.value == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                          height: 10,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 200,
                              width: 200,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: altBackgroundColor,
                              ),
                              child: const Center(
                                child: Icon(
                                  CupertinoIcons.person_alt_circle,
                                  size: 200,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.signIn();
                              },
                              child: Container(
                                width: 150,
                                height: 50,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: altBackgroundColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.arrowRightFromBracket,
                                      size: 24,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Sign in',
                                      style: GoogleFonts.jost(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'User Preferences',
                          style: GoogleFonts.jost(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white30,
                          ),
                        ),
                        const _DrawerButton(
                          icon: Icons.settings,
                          label: 'App Settings',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Social Groups',
                          style: GoogleFonts.jost(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white30,
                          ),
                        ),
                        const _DrawerButton(
                          icon: FontAwesomeIcons.whatsapp,
                          label: 'WhatsApp',
                        ),
                        const _DrawerButton(
                          icon: FontAwesomeIcons.telegram,
                          label: 'Telegram',
                        ),
                        const Spacer(),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Contact Us',
                              style: GoogleFonts.jost(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white30,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
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
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                          height: 10,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10),),
                                color: altBackgroundColor,
                              ),
                              child: Center(
                                child: Image.network(
                                  controller.user.value!.photoURL ?? '',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                controller.user.value!.displayName ?? '',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.jost(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (response.loadingStatus.value == LoadingStatus.loading){
                                  _authResponse(context, 'Signing out...');
                                } else if (response.loadingStatus.value == LoadingStatus.completed){
                                  _authResponse(context, 'Signed out successfully...');
                                } else {
                                  _authResponse(context, 'Error signing out...');
                                }
                                controller.signOut();
                              },
                              child: Container(
                                width: 150,
                                height: 50,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: altBackgroundColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.arrowRightFromBracket,
                                      size: 24,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Sign Out',
                                      style: GoogleFonts.jost(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'User Preferences',
                          style: GoogleFonts.jost(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white30,
                          ),
                        ),
                        const _DrawerButton(
                          icon: Icons.settings,
                          label: 'App Settings',
                        ),
                        const _DrawerButton(
                          icon: Icons.history_sharp,
                          label: 'History',
                        ),
                        const _DrawerButton(
                          icon: Icons.bar_chart,
                          label: 'Leaderboard',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Social Groups',
                          style: GoogleFonts.jost(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white30,
                          ),
                        ),
                        const _DrawerButton(
                          icon: FontAwesomeIcons.whatsapp,
                          label: 'WhatsApp',
                        ),
                        const _DrawerButton(
                          icon: FontAwesomeIcons.telegram,
                          label: 'Telegram',
                        ),
                        const Spacer(),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Contact Us',
                              style: GoogleFonts.jost(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white30,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
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
          ],
        ),
      ),
    );
  }
}

class _DrawerButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  const _DrawerButton(
      {Key? key, required this.icon, required this.label, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 30,
        color: altTextColor,
      ),
      label: Text(
        label,
        style: GoogleFonts.jost(
          fontSize: 20,
          //fontWeight: FontWeight.bold,
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

void _authResponse(BuildContext context, String responseText){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(responseText, style: GoogleFonts.jost(
            color: Colors.white,
          ),),
        ],
      ),
      backgroundColor: altBackgroundColor,
      margin: const EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    ),
  );
}