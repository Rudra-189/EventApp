import 'dart:ui';

import 'package:flutter/material.dart';

abstract class AppColor{
  static Color primaryColour = Colors.white;
  static Color secondaryColour = Color(0XFF5669FF);
  static Color authButtonColor = Color(0XFF5669FF).withOpacity(0.09);
  static Color textColor = Colors.black;
  static Color hintColor = Colors.black.withOpacity(0.5);
  static Color borderColor = Colors.black.withOpacity(0.5);
  static Color border = Colors.black;
  static Color iconColor = Colors.black.withOpacity(0.5);
}