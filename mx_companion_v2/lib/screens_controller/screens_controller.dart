import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mx_companion_v2/screens/courses/course_info.dart';
import 'package:mx_companion_v2/screens/home/main_screen.dart';
import 'package:mx_companion_v2/screens/profile/profile_screen.dart';

import '../config/themes/app_dark_theme.dart';
import '../config/themes/app_light_theme.dart';
import '../config/themes/ui_parameters.dart';
import '../screens/contact/contact_screen.dart';
import '../screens/settings/settings_screen.dart';

class ScreensController extends StatefulWidget {
  const ScreensController({Key? key}) : super(key: key);

  static const String routeName = "/screensController";

  @override
  State<ScreensController> createState() => _ScreensControllerState();
}

class _ScreensControllerState extends State<ScreensController> {

  List screens = [
    const ContactScreen(),
    const CourseInfoScreen(),
    const MainScreen(),
    const ProfileScreen(),
    const SettingsScreen(),
  ];

  int index = 2;

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor:
        UIParameters.isDarkMode() ? primaryDarkColor1 : primaryLightColor1,
        systemNavigationBarIconBrightness:
        UIParameters.isDarkMode() ? Brightness.light : Brightness.dark,
        statusBarIconBrightness:
        UIParameters.isDarkMode() ? Brightness.light : Brightness.dark,
        statusBarColor:
        UIParameters.isDarkMode() ? primaryDarkColor1 : primaryLightColor1,
      ),
    );

    return Container(
      color: primaryDarkColor1,
      child: SafeArea(
        top: false,
        child: Scaffold(
          body: screens[index],
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              iconTheme: const IconThemeData(
                color: textColor,
              ),
            ),
            child: CurvedNavigationBar(
              buttonBackgroundColor: maroonColor,
              backgroundColor: primaryDark,
              color: primaryDarkColor1,
              items: const [
                Icon(Icons.contact_page_sharp, size: 24,),
                Icon(Icons.book_online, size: 24,),
                Icon(Icons.home, size: 24,),
                Icon(Icons.person, size: 24,),
                Icon(Icons.settings, size: 24,),
              ],
              height: 50,
              index: index,
              onTap: (index) => setState(() {
                this.index = index;
              }),
            ),
          ),
        ),
      ),
    );
  }
}
