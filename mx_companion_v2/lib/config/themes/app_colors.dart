import 'package:flutter/material.dart';
import 'package:mx_companion_v2/config/themes/app_light_theme.dart';
import 'package:mx_companion_v2/config/themes/ui_parameters.dart';

import 'app_dark_theme.dart';

const Color onSurfaceTextColor = Colors.white;

const mainGradientLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryLightColor1,
      primaryLightColor2,
    ]);

const mainGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryDarkColor1,
      primaryDarkColor2,
    ]);

LinearGradient mainGradient(BuildContext context) =>
  UIParameters.isDarkMode() ? mainGradientDark : mainGradientLight;
