import 'package:flutter/material.dart';


const double _mobileScreenPadding = 25;
const double _cardBorderRadius = 10;

double get mobileScreenPadding => _mobileScreenPadding;
double get cardBorderRadius => _cardBorderRadius;


class UIParameters {
  static BorderRadius get cardBorderRadius => BorderRadius.circular(_cardBorderRadius);
  static EdgeInsets get mobileScreenPadding => const EdgeInsets.all(_mobileScreenPadding);

}

