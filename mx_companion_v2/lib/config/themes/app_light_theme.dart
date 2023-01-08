import 'package:flutter/material.dart';
import 'package:mx_companion_v2/config/themes/sub_theme_data_mixin.dart';

const Color primaryLightColor1 = Color(0xffffffff);
const Color primaryLightColor2 = Color(0xffffffff);
const Color mainTextColorLight = Color.fromARGB(255, 40, 40, 40);


class LightTheme with SubThemeData{
  ThemeData buildLightTheme(){
    final ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      iconTheme: getIconTheme(),
    );
  }
}