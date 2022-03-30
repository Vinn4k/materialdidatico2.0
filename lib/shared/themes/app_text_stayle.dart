import 'package:easmaterialdidatico/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


///Estilização do app
class AppTextStyle {
  static final TextStyle titleHome = GoogleFonts.lexendDeca(
    fontSize: 40,
    fontWeight: FontWeight.w600,
    color: Colors.white,

  );
  static final TextStyle titleWithe = GoogleFonts.openSans(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    decoration: TextDecoration.underline,


  );
  static final TextStyle titleRegular = GoogleFonts.openSans(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.blue,

  );  static final TextStyle titleRegularBold = GoogleFonts.openSans(
    fontSize: 27,
    fontWeight: FontWeight.w800,
    color: AppColors.blue,

  );
  static final TextStyle titleRegularWhite = GoogleFonts.openSans(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: Colors.white,

  );
}
