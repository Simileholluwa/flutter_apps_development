import 'package:flutter/material.dart';
import 'package:mx_companion_v2/config/themes/sub_theme_data_mixin.dart';

const Color primaryDarkColor1 = Color(0xFF071329);
const Color transparentColor = Color(0xFF040D1C);
const Color altTextColor = Color(0xFF7AB4FE);
const Color altBackgroundColor = Color(0xFF203962);
const Color primaryDarkColor2 = Color(0xFF071329);
const Color mainTextColorDark = Colors.white;

class DarkTheme with SubThemeData{
  ThemeData buildDarkTheme(){
    final ThemeData systemDarkTheme = ThemeData.dark();
    return systemDarkTheme.copyWith(
      scaffoldBackgroundColor: transparentColor,
      iconTheme: getIconTheme(),
    );
  }
}