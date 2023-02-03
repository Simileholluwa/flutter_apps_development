import 'package:flutter/material.dart';

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
      keyboardType: TextInputType.text,
      controller: controller,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        filled: true,
        prefixIcon: Icon(
          prefixIcon,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent
              , width: 0.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: hintText,
      ),
    );
  }
}
