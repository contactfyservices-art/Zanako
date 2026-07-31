import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color skyBlue = Color(0xFF2E9DF7);
  static const Color deepBlue = Color(0xFF1257A6);
  static const Color sunYellow = Color(0xFFFFC93C);
  static const Color candyOrange = Color(0xFFFF7A29);
  static const Color berryPink = Color(0xFFFF4D6D);
  static const Color leafGreen = Color(0xFF3DCC7A);
  static const Color paperCream = Color(0xFFFFF8E7);
  static const Color inkBrown = Color(0xFF3B2E2A);
  static const Color lineBlue = Color(0xFFB9D9FF);
  static const Color marginRed = Color(0xFFFF9AA2);
}

TextStyle handwritingStyle({double fontSize = 28, Color color = AppColors.inkBrown, FontWeight fontWeight = FontWeight.w400}) {
  return GoogleFonts.playwriteFrTrad(fontSize: fontSize, color: color, fontWeight: FontWeight.w400, height: 1.5);
}

TextStyle handwritingBody({double fontSize = 20, Color color = AppColors.inkBrown}) {
  return GoogleFonts.playwriteFrTrad(fontSize: fontSize, color: color, height: 1.6);
}

ThemeData buildZanakoTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.paperCream,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.skyBlue, primary: AppColors.skyBlue, secondary: AppColors.candyOrange),
    textTheme: TextTheme(bodyMedium: handwritingBody(), titleLarge: handwritingStyle(fontSize: 32)),
  );
}
