import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown.shade400),
  scaffoldBackgroundColor: Colors.white,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    elevation: 4.0,
    focusElevation: 3.0,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)),
    backgroundColor: Colors.brown.shade400,
    foregroundColor: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.brown.shade400,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18.0),
  ),
);