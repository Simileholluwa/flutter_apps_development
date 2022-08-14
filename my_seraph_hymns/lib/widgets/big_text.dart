import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final Color color;
  final String text;
  final double? size;
  final TextOverflow overFlow;
  final Brightness? brightness;
  final TextAlign? textAlign;

  const BigText({Key? key,
    this.color = Colors.black,
    this.size = 20,
    required this.text,
    this.overFlow=TextOverflow.ellipsis, this.brightness, this.textAlign = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
