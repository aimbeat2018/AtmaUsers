import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';

class FontStyle {
  static fontStyleW400({required double fontSize, required Color fontColor}) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      color: fontColor,
      fontWeight: FontWeight.w400,
    );
  }

  static fontStyleW500(
      {required double fontSize, required Color fontColor, TextDecoration? textDecoration, Color? decorationColor}) {
    return GoogleFonts.poppins(
        fontSize: fontSize,
        color: fontColor,
        fontWeight: FontWeight.w500,
        decoration: textDecoration,
        decorationColor: decorationColor);
  }

  static fontStyleW600({
    required double fontSize,
    required Color fontColor,
    TextDecoration? textDecoration,
    Color? decorationColor,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      color: fontColor,
      fontWeight: FontWeight.w600,
      decoration: textDecoration,
      decorationColor: decorationColor,
    );
  }

  static fontStyleW700({required double fontSize, required Color fontColor}) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      color: fontColor,
      fontWeight: FontWeight.w700,
    );
  }

  static fontStyleW400Balthazar({required double fontSize, required Color fontColor}) {
    return GoogleFonts.balthazar(
      fontSize: fontSize,
      color: fontColor,
      fontWeight: FontWeight.w400,
    );
  }
}
