import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

mixin SubThemeData {
  IconThemeData getIconTheme (){
    return const IconThemeData(
      color: onSurfaceTextColor,
      size: 16
    );
  }
}
