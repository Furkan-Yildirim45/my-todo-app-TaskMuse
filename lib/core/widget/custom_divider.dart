import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key, this.dividerColor, this.indent, this.endIndent, this.dividerHeight, this.decoration,
  });
  final Color? dividerColor;
  final double? indent;
  final double? endIndent;
  final double? dividerHeight;
  final BoxDecoration? decoration;

  final double defaultIndentValue = 8;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: dividerHeight ?? 1,
      decoration: decoration ?? const BoxDecoration(),
      margin: EdgeInsets.only(right: endIndent ?? defaultIndentValue ,left: indent ?? defaultIndentValue),
    );
  }
}