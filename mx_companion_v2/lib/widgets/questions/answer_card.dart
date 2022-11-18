import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mx_companion_v2/config/themes/app_colors.dart';
import 'package:mx_companion_v2/config/themes/app_dark_theme.dart';
import 'package:mx_companion_v2/config/themes/ui_parameters.dart';

enum AnswerStatus{
  correct,
  wrong,
  answered,
  notAnswered,
}

class AnswerCard extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final VoidCallback onTap;

  const AnswerCard(
      {Key? key,
      required this.answer,
      this.isSelected = false,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        splashFactory: InkRipple.splashFactory,
        splashColor: altBackgroundColor,
        borderRadius: UIParameters.cardBorderRadius,
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: UIParameters.cardBorderRadius,
            color: isSelected ? textColor : primaryDarkColor1,
            // border: Border.all(color: isSelected ? Colors.blue : maroonColor,
            // ),
          ),
          child: Text(
            answer,
            style: TextStyle(
              color: isSelected ? onSurfaceTextColor : null,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class CorrectAnswer extends StatelessWidget {
  final String answer;
  const CorrectAnswer({Key? key, required this.answer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: Colors.green.withOpacity(.2),
        ),
        child: Text(
          answer,
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class WrongAnswer extends StatelessWidget {
  final String answer;
  const WrongAnswer({Key? key, required this.answer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: maroonColor.withOpacity(.2),
        ),
        child: Text(
          answer,
          style: const TextStyle(
            color: maroonColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
