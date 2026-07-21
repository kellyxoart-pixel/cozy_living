import 'package:flutter/material.dart';
import 'cozy_colors.dart';

class CozyText {

  static const TextStyle heading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: CozyColors.text,
    height: 1.2,
    letterSpacing: -0.3,
  );


  static const TextStyle title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: CozyColors.text,
    height: 1.25,
  );


  static const TextStyle section = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: CozyColors.text,
    height: 1.35,
  );


  static const TextStyle body = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: CozyColors.text,
    height: 1.55,
  );


  static const TextStyle label = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: CozyColors.mutedText,
    height: 1.4,
  );


  static const TextStyle button = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.1,
  );

}