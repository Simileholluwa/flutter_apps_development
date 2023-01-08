import 'package:flutter/material.dart';

class Social {
  final String socialText;
  final IconData socialIcon;
  final String copyIconText;
  final String textToCopy;

  Social({
    required this.textToCopy,
    required this.socialText,
    required this.socialIcon,
    required this.copyIconText,
  });
}