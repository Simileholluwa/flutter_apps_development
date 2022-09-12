import 'package:flutter/material.dart';
import '../config/themes/app_dark_theme.dart';

class ContentAreaCustom extends StatelessWidget {
  final bool addPadding;
  final Widget child;

  const ContentAreaCustom({Key? key, this.addPadding = true, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: primaryDark,
          borderRadius: BorderRadius.all(Radius.circular(30),),
      ),
      padding: addPadding ? const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ) : EdgeInsets.zero,
      child: child,
    );
  }
}
