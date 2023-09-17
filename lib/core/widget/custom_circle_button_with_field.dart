import 'package:flutter/material.dart';

class CustomCircleButtonWithField extends StatefulWidget {
  const CustomCircleButtonWithField(
      {Key? key,
      this.size,
      this.child,
      required this.onTap,
      this.borderColor,
      this.backgroundColor})
      : super(key: key);
  final double? size;
  final Widget? child;
  final void Function() onTap;
  final Color? borderColor;
  final Color? backgroundColor;

  @override
  State<CustomCircleButtonWithField> createState() => _CustomCircleButtonWithFieldState();
}

class _CustomCircleButtonWithFieldState extends State<CustomCircleButtonWithField> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular((widget.size ?? 36) / 2),
      child: Container(
        width: widget.size ?? 36,
        height: widget.size ?? 36,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular((widget.size ?? 36) / 2),
            color: widget.backgroundColor ?? Colors.green,
            border: Border.all(
                width: 3, color: widget.borderColor ?? Colors.transparent)),
        child: widget.child ?? const SizedBox.shrink(),
      ),
    );
  }
}
