import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

abstract class Style{
  Style._();
  static const shimmerBaseColor = Color(0x80FFFFFF);
  static const shimmerHighlightColor = Color(0x33FFFFFF);
  static const shimmerColor = Color(0x3348319D);
  static const productBgColor = Color(0xffFFDE9B);

  static textStyleSemiBold(
      {double size = 16, Color textColor = kTextDarkColor }) {
    return GoogleFonts.nunitoSans(
      fontSize: size,
      color: textColor,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.none,
    );
  }


  static textStyleNormal(
      {double size = 16, Color textColor = kTextDarkColor }) {
    return GoogleFonts.nunitoSans(
      fontSize: size,
      color: textColor,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none,
    );
  }



  static myDecoration({required String title}) {
    return InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        prefixIconConstraints: const BoxConstraints(maxHeight: 18),
        hintText: title,
        hintStyle: Style.textStyleNormal(
            textColor: kBrandColor.withOpacity(0.7), size: 15),
        filled: true,
        fillColor: kBrandColor.withOpacity(0.3),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none));
  }
}