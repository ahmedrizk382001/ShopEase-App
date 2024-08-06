import 'package:flutter/material.dart';
import 'package:shop_app/Shared/Components/constants.dart';

ThemeData lightModeTheme(BuildContext context) => ThemeData(
      primaryColor: defaultColor,
      textTheme: TextTheme(
        headlineMedium: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(
          color: Colors.grey,
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
        bodyLarge: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: defaultColor,
        elevation: 0,
        selectedIconTheme: const IconThemeData(
          color: Colors.black87,
          size: 35,
        ),
        selectedLabelStyle: const TextStyle(
          fontSize: 15,
        ),
        selectedItemColor: Colors.black87,
      ),
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        elevation: 0,
        titleSpacing: 20,
        actionsIconTheme: IconThemeData(
          color: Colors.black87,
          size: 22,
        ),
        titleTextStyle: TextStyle(
          color: Colors.black87,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
    );

ThemeData darkModeTheme(BuildContext context) => ThemeData(
      unselectedWidgetColor: Colors.black54,
      primaryColor: defaultColor,
      textTheme: TextTheme(
        headlineMedium: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(
          color: Colors.grey,
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
        bodyLarge: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      scaffoldBackgroundColor: Color(0xff121212),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: defaultColor,
        elevation: 0,
        selectedIconTheme: const IconThemeData(
          color: Colors.black87,
          size: 35,
        ),
        selectedLabelStyle: const TextStyle(
          fontSize: 15,
        ),
        selectedItemColor: Colors.black87,
      ),
      appBarTheme: AppBarTheme(
        color: Color(0xff121212),
        elevation: 0,
        titleSpacing: 20,
        actionsIconTheme: IconThemeData(
          color: Colors.black87,
          size: 22,
        ),
        titleTextStyle: TextStyle(
          color: Colors.black87,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
