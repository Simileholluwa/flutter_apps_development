import 'package:flutter/material.dart';
import 'package:mx_companion_v2/config/themes/sub_theme_data_mixin.dart';

const Color primaryDarkColor1 = Color(0xFF071329);
const Color primaryDarkColor = Color(0xff14171c);
const Color primaryDark = Color(0xff040d1c);
const Color orangeColor = Color(0xffeea346);
const Color maroonColor = Color(0xff994847);
const Color transparentColor = Color(0xFF1f2630);
const Color moreTransparent = Color(0xff272f3c);
Color standout = Colors.red.shade600;
Color standoutBlue = Colors.blue.shade800;
const Color altTextColor = Color(0xFFF1F1F1);
const Color altBackgroundColor = Color(0xFF203962);
const Color primaryDarkColor2 = Color(0xFF1C1B1C);
const Color textColor = Color(0xff7ab4fe);

class DarkTheme with SubThemeData{
  ThemeData buildDarkTheme(){
    final ThemeData systemDarkTheme = ThemeData.dark();
    return systemDarkTheme.copyWith(
      scaffoldBackgroundColor: primaryDarkColor1,
      iconTheme: getIconTheme(),
    );
  }
}