import 'package:flutter/material.dart';
import '../config/themes/app_dark_theme.dart';
import '../config/themes/ui_parameters.dart';

class ContentAreaCustom extends StatelessWidget {
  final bool addPadding;
  final Widget child;

  const ContentAreaCustom({Key? key, this.addPadding = true, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.hardEdge,
      type: MaterialType.transparency,
      child: Ink(
        decoration: const BoxDecoration(
          color: primaryDarkColor1,
        ),
        padding: addPadding ? EdgeInsets.only(
          top: mobileScreenPadding,
          left: mobileScreenPadding,
          right: mobileScreenPadding,
        ) : EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
