import 'package:flutter/material.dart';

class LightTheme {
  late ThemeData theme;
  LightTheme(){
    theme = ThemeData(
      textTheme: const TextTheme(
        headlineMedium: TextStyle(fontWeight: FontWeight.w600),
        titleMedium: TextStyle(color: Colors.grey),
        headlineSmall: TextStyle(fontWeight: FontWeight.w500)
      )
    );
  }
}
