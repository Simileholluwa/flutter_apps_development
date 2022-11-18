import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/themes/app_dark_theme.dart';
import '../config/themes/custom_text.dart';

class IconAndText extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final IconData icon;
  final double size;
  const IconAndText({Key? key, required this.onTap, required this.text, required this.icon, this.size =25,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(30),),
        splashFactory: InkRipple.splashFactory,
        splashColor: altBackgroundColor,
        hoverColor: altBackgroundColor,
        highlightColor: altBackgroundColor,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20,),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: size,),
              const SizedBox(width: 30,),
              Text(
                text,
                style: smallJost,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.arrow_forward_ios_sharp, color: orangeColor, size: 10,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
