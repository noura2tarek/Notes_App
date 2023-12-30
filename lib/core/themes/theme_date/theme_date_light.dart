import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown.shade400),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.brown.shade400,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
);