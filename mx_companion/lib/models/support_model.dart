import 'package:flutter/material.dart';

class Support {
  final String supportText;
  final IconData supportIcon;
  final Future<void> Function() supportFunction;

  Support({
    required this.supportText,
    required this.supportIcon,
    required this.supportFunction,
});
}