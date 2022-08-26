import 'package:flutter/material.dart';
import 'package:mx_companion_v2/config/themes/sub_theme_data_mixin.dart';

const Color primaryDarkColor1 = Color(0xFF101318);
const Color primaryDarkColor = Color(0xff151721);
Color primaryDark = const Color(0xff151721).withAlpha(200);
const Color transparentColor = Color(0xFF1f2630);
const Color moreTransparent = Color(0xff272f3c);
Color standout = Colors.red.shade600;
Color standoutBlue = Colors.blue.shade600;
const Color altTextColor = Color(0xFF7AB4FE);
const Color altBackgroundColor = Color(0xFF203962);
const Color primaryDarkColor2 = Color(0xFF1C1B1C);
const Color textColor = Color(0xffc9c9c9);

class DarkTheme with SubThemeData{
  ThemeData buildDarkTheme(){
    final ThemeData systemDarkTheme = ThemeData.dark();
    return systemDarkTheme.copyWith(
      scaffoldBackgroundColor: transparentColor,
      iconTheme: getIconTheme(),
    );
  }
}