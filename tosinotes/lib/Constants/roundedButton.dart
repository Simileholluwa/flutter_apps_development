import 'package:flutter/material.dart';

import 'Routes.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    required this.text,
    this.color = Colors.deepPurple,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: size.width * 0.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: ElevatedButton(
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(registerRoute);
          },
          style: ElevatedButton.styleFrom(
              primary: color,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              textStyle: TextStyle(
                  color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}

class RoundedButton1 extends StatelessWidget {
  final String text;
  final Color color, textColor;
  const RoundedButton1({
    Key? key,
    required this.text,
    this.color = Colors.deepPurple,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: size.width * 0.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: ElevatedButton(
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(
                loginRoute);
          },
          style: ElevatedButton.styleFrom(
              primary: color,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              textStyle: TextStyle(
                  color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}

