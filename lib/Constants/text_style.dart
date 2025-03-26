import 'package:fit_food/Constants/export.dart';

String? font = 'GoogleFonts.poppins().fontFamily';

class Style {
  static TextStyle smalltextStyle = TextStyle(
    fontSize: smallTextsize,
    fontFamily: font,
  );

  static TextStyle smallGreentext = TextStyle(
    fontSize: smallTextsize,
    fontFamily: font,
    color: Colors.green.shade600,
  );

  static TextStyle smallLighttextStyle = TextStyle(
    color: Colors.grey.shade600,
    fontSize: smallTextsize,
    fontFamily: font,
  );
  static TextStyle lighttextStyle = TextStyle(
    color: Colors.grey.shade600,
    fontSize: mediumTextsize,
    fontFamily: font,
  );

  static TextStyle largeLighttextStyle = TextStyle(
    color: Colors.grey.shade600,
    fontSize: largeTextsize,
    fontFamily: font,
  );

  static TextStyle normalTextStyle = TextStyle(
    fontSize: normalTextsize,
    fontFamily: font,
  );
  static TextStyle normalLightTextStyle = TextStyle(
    color: Colors.grey.shade600,
    fontSize: normalTextsize,
    fontFamily: font,
  );
  static TextStyle normalboldTextStyle = TextStyle(
    fontSize: normalTextsize,
    fontFamily: font,
    fontWeight: FontWeight.bold,
  );

  static TextStyle mediumTextStyle = TextStyle(
    fontSize: mediumTextsize,
    fontFamily: font,
  );

  static TextStyle largeTextStyle = TextStyle(
    fontSize: largeTextsize,
    fontFamily: font,
  );

  static TextStyle largeBoldTextStyle = TextStyle(
    fontSize: 24,
    fontFamily: font,
    fontWeight: FontWeight.w700,
  );

  static TextStyle xLargeTextStyle = TextStyle(
    fontSize: xLargeTextsize,
    fontFamily: font,
    letterSpacing: 1.5,
  );

  static TextStyle smallWhitetextStyle = TextStyle(
    fontSize: smallTextsize,
    fontFamily: font,
  );

  static TextStyle normalWhiteTextStyle = TextStyle(
    fontSize: normalTextsize,
    fontFamily: font,
  );

  static TextStyle mediumWhiteTextStyle = TextStyle(
      fontSize: mediumTextsize, fontFamily: font, color: Colors.white);
  static TextStyle mediumWTextStyle = TextStyle(
    color: whiteColor,
    fontSize: mediumTextsize,
    fontFamily: font,
  );
  static TextStyle smallWtextStyle = TextStyle(
    color: whiteColor,
    fontSize: smallTextsize,
    fontFamily: font,
  );
  static TextStyle normalWTextStyle = TextStyle(
    color: whiteColor,
    fontSize: normalTextsize,
    fontFamily: font,
  );

  static TextStyle largeWhiteTextStyle = TextStyle(
    fontSize: largeTextsize,
    fontFamily: font,
  );

  static TextStyle largeBoldWhiteTextStyle = TextStyle(
    color: whiteColor,
    fontSize: largeTextsize,
    fontWeight: FontWeight.bold,
    fontFamily: font,
  );

  static TextStyle xLargeWhiteTextStyle = TextStyle(
    color: whiteColor,
    fontSize: xLargeTextsize,
    fontFamily: font,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.8,
  );

  static TextStyle smallColortextStyle = TextStyle(
    color: primaryColor,
    fontSize: normalTextsize,
    fontFamily: font,
  );

  static TextStyle normalColorTextStyle = TextStyle(
    color: primaryColor,
    fontSize: normalTextsize,
    fontFamily: font,
  );

  static TextStyle mediumColorTextStyle = TextStyle(
    color: primaryColor,
    fontSize: mediumTextsize,
    fontFamily: font,
  );

  static TextStyle largeColorTextStyle = TextStyle(
    color: primaryColor,
    fontSize: largeTextsize,
    fontFamily: font,
  );
}
