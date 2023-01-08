import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_color.dart';

class PageTitle extends StatelessWidget {
  final IconData icon;
  final String titleText;
  const PageTitle({
    Key? key,
    required this.icon,
    required this.titleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(
            right: 20,
          ),
          height: 60,
          width: 250,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(35),
              ),
              color: backgroundColor,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 40,),
                  child: Text(
                    titleText,
                    style: GoogleFonts.jost(
                      color: whiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 58,
                  width: 58,
                  decoration: BoxDecoration(
                    color: pinkColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: whiteColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
