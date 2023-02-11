import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

abstract class Style{
  Style._();

  static textStyleSemiBold(
      {double size = 16, Color textColor = kTextDarkColor }) {
    return GoogleFonts.manrope(
      fontSize: size,
      color: textColor,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.none,
    );
  }
}