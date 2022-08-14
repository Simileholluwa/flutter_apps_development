import 'package:flutter/material.dart';

import '../app_color.dart';

class ResumeItems extends StatelessWidget {
  final String headText;
  final String subText;
  const ResumeItems({Key? key, required this.headText, required this.subText,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headText,
          style: TextStyle(
            fontSize: 15,
            color: backgroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 10,
          ),
          child: Text(
            subText,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
