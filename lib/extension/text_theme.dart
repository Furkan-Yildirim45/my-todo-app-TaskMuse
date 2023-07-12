import 'package:flutter/material.dart';

extension TextThemeExtension on BuildContext{
  TextTheme getTextTheme(BuildContext context){
    return Theme.of(context).textTheme;
  }
}