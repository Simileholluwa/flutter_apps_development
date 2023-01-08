import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_color.dart';

class ResumeIcons extends StatelessWidget {
  final String iconHeading;
  final IconData icon;
  const ResumeIcons({Key? key, required this.iconHeading, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: pinkColor,
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
                ],),
              child: Icon(
                icon,
                color: whiteColor,
                size: 40,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              iconHeading,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: whiteColor,
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 60,
          ),
          child: const Divider(
            height: 20,
            color: CupertinoColors.inactiveGray,
          ),
        ),
      ],
    );
  }
}
