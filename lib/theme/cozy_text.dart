import 'package:flutter/material.dart';
import 'cozy_colors.dart';

class CozyText {

  static const TextStyle heading = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: CozyColors.text,
    height: 1.15,
    letterSpacing: -0.5,
  );


  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: CozyColors.text,
    height: 1.2,
  );


  static const TextStyle section = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: CozyColors.text,
    height: 1.3,
  );


  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: CozyColors.text,
    height: 1.6,
  );


  static const TextStyle label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: CozyColors.mutedText,
    height: 1.4,
  );


  static const TextStyle button = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: 0.2,
  );

}