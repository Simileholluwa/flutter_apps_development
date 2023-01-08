import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/themes/app_dark_theme.dart';

class CustomTextField extends StatelessWidget {
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final String hintText;
  final String labelText;
  final TextInputType textInputType;
  final TextInputAction inputAction;
  const CustomTextField({
    Key? key,
    this.onSaved,
    this.validator,
    this.controller,
    required this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    required this.labelText,
    this.textInputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      keyboardType: textInputType,
      controller: controller,
      textInputAction: inputAction,
      style: GoogleFonts.jost(
        fontSize: 15,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        fillColor: primaryDark,
        filled: true,
        prefixIcon: Icon(
          prefixIcon,
          color: altTextColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: orangeColor, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: orangeColor, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: transparentColor
              , width: 0.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.jost(
          color: altTextColor,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        labelText: labelText,
        labelStyle: GoogleFonts.jost(
          color: altTextColor,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
