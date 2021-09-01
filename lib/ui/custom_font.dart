import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_lyca/constants.dart' as constants;

class CustomFont {
  static Map<String, TextStyle> fontStyleMap = {
    constants.latoKey: GoogleFonts.lato(),
    constants.notoSansKey: GoogleFonts.notoSans(),
    constants.openSansKey: GoogleFonts.openSans(),
    constants.oswaldKey: GoogleFonts.oswald(),
    constants.poppinsKey: GoogleFonts.poppins(),
    constants.robotoKey: GoogleFonts.roboto(),
  };
}
