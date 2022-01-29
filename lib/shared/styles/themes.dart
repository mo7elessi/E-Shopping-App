import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData themeLight = ThemeData(
    fontFamily: 'SF',
    primaryColor: primaryColor,
    scaffoldBackgroundColor: screenColor[10],
    appBarTheme: const AppBarTheme(      elevation:0.0,
      titleTextStyle: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
      backgroundColor: primaryColor,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    cardTheme: const CardTheme(
      color: Colors.white,
      elevation: 0.5,
    ),
    focusColor: primaryColor,
    inputDecorationTheme:  InputDecorationTheme(
      hoverColor: primaryColor,
      focusColor: primaryColor,
      prefixStyle: const TextStyle(
        color: primaryColor,
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(width: 0.3, color: Colors.grey)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(width: 0.3, color: Colors.grey)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(width: 0.3, color: Colors.grey)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(width: 0.3, color: Colors.grey)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: primaryColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedItemColor: Colors.black45,
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: 16.0,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.black45,
    ));
