import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final Color color;
  final String text;
  final double? size;
  final TextAlign? align;
  final TextOverflow? overFlow;


  const SmallText({Key? key,
    this.color = Colors.white,
    this.size = 15,
    required this.text, this.align,
    this.overFlow = TextOverflow.ellipsis,


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      overflow: overFlow,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: FontWeight.bold,
        fontFamily: 'Jost',
      ),
    );
  }
}
