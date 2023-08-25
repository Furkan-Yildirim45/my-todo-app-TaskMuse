import 'package:flutter/material.dart';
import 'package:task_muse/product/extension/context/general.dart';

class TitleSmallTextWithSpace extends StatelessWidget {
  const TitleSmallTextWithSpace(
      {Key? key, required this.text, this.top, this.bottom, this.color})
      : super(key: key);
  final String text;
  final double? top;
  final double? bottom;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: top ?? 0, bottom: bottom ?? 0),
      child: Text(
        text,
        style: context
            .general.textTheme
            .titleSmall
            ?.copyWith(color: color ?? Colors.white),
      ),
    );
  }
}
