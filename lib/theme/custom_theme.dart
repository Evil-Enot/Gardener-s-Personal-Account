import 'package:flutter/material.dart';

class CustomTheme {
  static BoxDecoration get headerDecoration {
    return const BoxDecoration(
      color: Color(0xFFFFF9C0),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(40.0),
        bottomRight: Radius.circular(40.0),
      ),
    );
  }

  static BoxDecoration get footerDecoration {
    return const BoxDecoration(
      color: Color(0xFFFFF9C0),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40.0),
        topRight: Radius.circular(40.0),
      ),
    );
  }

  static BoxDecoration get menuButtonDecoration {
    return BoxDecoration(
      color: const Color(0xFFFFED4D),
      border: Border.all(width: 2.0, color: const Color(0xFF000000)),
      borderRadius: const BorderRadius.all(
        Radius.circular(30.0),
      ),
    );
  }

  static BoxDecoration get buttonsDecoration {
    return const BoxDecoration(
      color: Color(0xFFFFED4D),
      borderRadius: BorderRadius.all(
        Radius.circular(30.0),
      ),
    );
  }

  static BoxDecoration get inputFieldsDecoration {
    return const BoxDecoration(
      color: Color(0xFFFFF9C0),
      borderRadius: BorderRadius.all(
        Radius.circular(30.0),
      ),
    );
  }

  static TextStyle get textStyle36_400 {
    return const TextStyle(
      color: Color(0xFF373737),
      fontSize: 36,
      fontWeight: FontWeight.w400,
      fontFamily: 'Montserrat',
    );
  }

  static TextStyle get textStyle50_400 {
    return const TextStyle(
      color: Color(0xFF373737),
      fontSize: 50,
      fontWeight: FontWeight.w400,
      fontFamily: 'Montserrat',
    );
  }

  static TextStyle get textStyle14_400U {
    return const TextStyle(
      color: Color(0xFF373737),
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'Montserrat',
      decoration: TextDecoration.underline,
    );
  }

  static TextStyle get textStyle14_700U {
    return const TextStyle(
      color: Color(0xFF373737),
      fontSize: 14,
      fontWeight: FontWeight.w700,
      fontFamily: 'Montserrat',
      decoration: TextDecoration.underline,
    );
  }

  static TextStyle get textStyle20_400 {
    return const TextStyle(
      color: Color(0xFF373737),
      fontSize: 20,
      fontWeight: FontWeight.w400,
      fontFamily: 'Montserrat',
    );
  }

  static TextStyle get textStyleHint20_400 {
    return const TextStyle(
      color: Color(0xFF8D8C8C),
      fontSize: 20,
      fontWeight: FontWeight.w400,
      fontFamily: 'Montserrat',
    );
  }

  static TextStyle get textStyle22_700 {
    return const TextStyle(
      color: Color(0xFF373737),
      fontSize: 22,
      fontWeight: FontWeight.w700,
      fontFamily: 'Montserrat',
    );
  }

  static TextStyle get textStyle24_400 {
    return const TextStyle(
      color: Color(0xFF373737),
      fontSize: 24,
      fontWeight: FontWeight.w400,
      fontFamily: 'Montserrat',
    );
  }

  static TextStyle get textStyle18_400U {
    return const TextStyle(
      color: Color(0xFF373737),
      fontSize: 18,
      fontWeight: FontWeight.w400,
      fontFamily: 'Montserrat',
      decoration: TextDecoration.underline,
    );
  }

  static ButtonStyle get elevatedButtonStyle {
    return ElevatedButton.styleFrom(
      primary: const Color(0xFFFFED4D),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: const BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
      ),
    );
  }
}
