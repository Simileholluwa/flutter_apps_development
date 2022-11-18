import 'package:flutter/material.dart';

import '../config/themes/app_dark_theme.dart';
import '../config/themes/ui_parameters.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget? buttonImage;
  final Widget buttonWidget;
  final Color btnColor;
  final bool noSplash;
  const AppButton(
      {Key? key,
      required this.onTap,
      this.buttonImage,
      required this.buttonWidget,
      required this.btnColor, this.noSplash = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        splashFactory: noSplash ? null : InkRipple.splashFactory,
        splashColor: noSplash ? null : altBackgroundColor,
        borderRadius: UIParameters.cardBorderRadius,
        onTap: onTap,
        child: Ink(
          width: double.maxFinite,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            color: btnColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buttonWidget,
            ],
          ),
        ),
      ),
    );
  }
}
