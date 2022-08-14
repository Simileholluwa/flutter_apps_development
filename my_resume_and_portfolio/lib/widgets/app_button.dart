import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_color.dart';

class AppButton extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  final String buttonText;
  const AppButton({
    Key? key,
    required this.icon,
    required this.buttonText, required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap(),
          child: Container(
            margin: const EdgeInsets.only(
              left: 10,
            ),
            height: 60,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
              border: Border.all(
                color: pinkColor,
                width: 1,
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 40,),
                    child: Text(
                      buttonText,
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
        ),
      ],
    );
  }
}
