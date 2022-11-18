import 'package:flutter/material.dart';
import 'package:mx_companion_v2/config/themes/app_dark_theme.dart';
import 'package:mx_companion_v2/config/themes/custom_text.dart';
import 'package:mx_companion_v2/widgets/questions/answer_card.dart';

import '../../config/themes/ui_parameters.dart';

class QuestionAnswerCard extends StatelessWidget {
  final int index;
  final AnswerStatus? status;
  final VoidCallback onTap;
  final bool addSplash;
  const QuestionAnswerCard({Key? key, required this.index, this.status, required this.onTap, this.addSplash = false,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColorr = Colors.blue.withOpacity(.2);
    switch(status) {
      case AnswerStatus.answered:
        backgroundColorr = textColor;
        break;

      case AnswerStatus.wrong:
        backgroundColorr = maroonColor;
        break;

      case AnswerStatus.correct:
        backgroundColorr = Colors.green;
        break;

      case AnswerStatus.notAnswered:
        backgroundColorr = primaryDark;
        break;

      default:
        backgroundColorr = primaryDarkColor1;
    }
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        splashFactory: InkRipple.splashFactory,
        splashColor: addSplash ? altBackgroundColor : null,
        borderRadius: UIParameters.cardBorderRadius,
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(10),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: backgroundColorr,
              borderRadius: UIParameters.cardBorderRadius
          ),
          child: Center(
            child: Text(
              '$index',
              style: smallJost,
            ),
          ),

        ),
      ),
    );
  }
}
