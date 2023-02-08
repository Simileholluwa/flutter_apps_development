import 'package:flutter/material.dart';
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
  final bool noSplash;

  const AnswerCard(
      {Key? key,
      required this.answer,
      this.isSelected = false,
        this.noSplash = false,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: UIParameters.cardBorderRadius,
      child: InkWell(
        splashFactory: noSplash ? null : InkRipple.splashFactory,
        splashColor: noSplash ? null : Theme.of(context).splashColor,
        borderRadius: UIParameters.cardBorderRadius,
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: UIParameters.cardBorderRadius,
            color: isSelected ? Colors.blue : Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Text(
            answer,
            style: Theme.of(context).textTheme.titleMedium!.merge(TextStyle(
              color: isSelected ? Colors.white : null,
            ),),
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
          style: Theme.of(context).textTheme.titleMedium!.merge(const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),),
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
          color: const Color(0xff994847).withOpacity(.2),
        ),
        child: Text(
          answer,
          style: Theme.of(context).textTheme.titleMedium!.merge(const TextStyle(
            color: Color(0xff994847),
            fontWeight: FontWeight.bold,
          ),),
        ),
      ),
    );
  }
}
