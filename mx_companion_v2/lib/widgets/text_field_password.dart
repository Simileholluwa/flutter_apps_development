import 'package:flutter/material.dart';

class CustomTextFieldPW extends StatefulWidget {
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final IconData prefixIcon;
  final String hintText;
  final String labelText;
  const CustomTextFieldPW({
    Key? key,
    this.onSaved,
    this.validator,
    this.controller,
    required this.prefixIcon,
    required this.hintText,
    required this.labelText,
  }) : super(key: key);

  @override
  State<CustomTextFieldPW> createState() => _CustomTextFieldPWState();
}

class _CustomTextFieldPWState extends State<CustomTextFieldPW> {

  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(

      onSaved: widget.onSaved,
      validator: widget.validator,
      keyboardType: TextInputType.text,
      controller: widget.controller,
      textInputAction: TextInputAction.done,
      obscuringCharacter: '*',
      obscureText: _isHidden,
      decoration: InputDecoration(
        filled: true,
        prefixIcon: Icon(
          widget.prefixIcon,
        ),
        suffixIcon: IconButton(
          splashRadius: 5,
          onPressed: () {
            setState(() {
              _isHidden = !_isHidden;
            });
          },
          icon: Icon(
            _isHidden ? Icons.visibility : Icons.visibility_off,
          ),
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
        hintText: widget.hintText,
      ),
    );
  }
}
