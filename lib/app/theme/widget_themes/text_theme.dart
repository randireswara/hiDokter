import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    displayMedium: GoogleFonts.montserrat(
      color: Colors.black87,
    ),
    displaySmall: GoogleFonts.montserrat(
        color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold),
    headlineMedium: GoogleFonts.montserrat(
        color: Colors.black87, fontWeight: FontWeight.bold),
    titleSmall: GoogleFonts.poppins(
      color: Colors.black54,
      fontSize: 18,
    ),
    headlineSmall: GoogleFonts.poppins(
      color: Colors.black87,
      fontWeight: FontWeight.bold,
    ),
  );
  static TextTheme darkTextTheme = TextTheme(
      displayMedium: GoogleFonts.montserrat(
        color: Colors.white70,
      ),
      displaySmall: GoogleFonts.montserrat(
        color: Colors.white70,
      ),
      headlineMedium: GoogleFonts.montserrat(
        color: Colors.white70,
      ),
      titleSmall: GoogleFonts.poppins(
        color: Colors.white60,
        fontSize: 24,
      ));
}
