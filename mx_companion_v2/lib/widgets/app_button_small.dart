import 'package:flutter/material.dart';
import 'package:mx_companion_v2/config/themes/app_dark_theme.dart';

class AppButtonSmall extends StatelessWidget {
  final VoidCallback onTap;
  final Widget? buttonImage;
  final Widget buttonWidget;
  final Color btnColor;
  final IconData icon;
  const AppButtonSmall(
      {Key? key,
      required this.onTap,
      this.buttonImage,
      required this.buttonWidget,
      required this.btnColor,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          color: btnColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 2,
            ),
            buttonWidget,
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: maroonColor,
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
