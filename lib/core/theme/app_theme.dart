import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeMode themeMode = ThemeMode.light;
  static const Color primaryColor = Color(0xFF5D9CEC);
  static const Color lightColor = Color(0xFFDFECDB);
  static const Color darkColor = Color(0xFF060E1E);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: lightColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: lightColor,
      shape: StadiumBorder(
        side: BorderSide(
          color: Colors.white,
          width: 3,
        ),
      ),
    ),
/*
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: primaryColor,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
*/
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.transparent,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        color: primaryColor,
        size: 30,
      ),
      unselectedIconTheme: IconThemeData(
        color: Colors.grey,
        size: 30,
      ),
    ),
    textTheme: TextTheme(
      headlineMedium: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: Colors.white,
      ),
      bodyMedium: const TextStyle(
        fontSize: 25,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: Colors.black,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: darkColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: darkColor,
      shape: StadiumBorder(
        side: BorderSide(
          color: Colors.grey[800]!,
          width: 3,
        ),
      ),
    ),
/*
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: primaryColor,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
*/
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.transparent,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        color: primaryColor,
        size: 30,
      ),
      unselectedIconTheme: IconThemeData(
        color: Colors.grey,
        size: 30,
      ),
    ),
    textTheme: TextTheme(
      headlineMedium: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: darkColor,
      ),
      bodyMedium: const TextStyle(
        fontSize: 25,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: Colors.white,
      ),
    ),
  );
}
