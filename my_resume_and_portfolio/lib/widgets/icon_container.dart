import 'package:flutter/material.dart';

import '../app_color.dart';

class IconContainer extends StatelessWidget {
  final Color containerColor;
  final IconData containerIcon;
  final Color containerIconColor;
  final Function() onTap;
  const IconContainer({
    Key? key,
    required this.containerColor,
    required this.containerIcon,
    required this.containerIconColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            color: containerColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(35),
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 5),
                blurRadius: 10,
                color: shadowColor,
              ),
              BoxShadow(
                offset: const Offset(-5, 0),
                blurRadius: 10,
                color: shadowColor,
              ),
              BoxShadow(
                offset: const Offset(5, 0),
                blurRadius: 10,
                color: shadowColor,
              ),
            ],

        ),
        child: Center(
          child: Icon(
            containerIcon,
            color: containerIconColor,
          ),
        ),
      ),
    );
  }
}
