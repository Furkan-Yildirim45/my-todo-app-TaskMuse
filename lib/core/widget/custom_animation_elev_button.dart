import 'package:flutter/material.dart';

class CustomAnimationElevatedButton extends StatelessWidget {
  const CustomAnimationElevatedButton(
      {Key? key,
      required this.containerDuration,
      this.containerBorderRadius,
      this.containerColor,
      this.containerBorder,
      this.containerShadow,
      this.image,
      this.containerAlignment,
      this.containerWidth,
      this.containerHeigth,
      this.containerPadding,
      this.containerMargin,
      this.containerCurve,
      this.containerTransform,
      this.containerClipBehavior,
      this.transformAlignment,
      required this.child,
      required this.onPressed,
      this.buttonPadding,
      this.buttonHeigth,
      this.buttonWidth,
      this.buttonAlignment,
      this.buttonElevation,
      this.buttonShape,
      this.buttonBackgroundColor,
      this.onLongPress,
      this.buttonShadowColor,
      this.buttonAnimationDuration})
      : super(key: key);
  final Duration containerDuration;
  final BorderRadius? containerBorderRadius;
  final Color? containerColor;
  final BoxBorder? containerBorder;
  final List<BoxShadow>? containerShadow;
  final DecorationImage? image;
  final AlignmentGeometry? containerAlignment;
  final double? containerWidth;
  final double? containerHeigth;
  final EdgeInsets? containerPadding;
  final EdgeInsets? containerMargin;
  final Curve? containerCurve;
  final Matrix4? containerTransform;
  final Clip? containerClipBehavior;
  final AlignmentGeometry? transformAlignment;
  final Widget child;
  final void Function() onPressed;
  final EdgeInsets? buttonPadding;
  final double? buttonHeigth;
  final double? buttonWidth;
  final AlignmentGeometry? buttonAlignment;
  final double? buttonElevation;
  final OutlinedBorder? buttonShape;
  final Color? buttonBackgroundColor;
  final void Function()? onLongPress;
  final Color? buttonShadowColor;
  final Duration? buttonAnimationDuration;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: containerDuration,
      decoration: BoxDecoration(
        borderRadius: containerBorderRadius,
        color: containerColor,
        border: containerBorder,
        boxShadow: containerShadow,
        image: image,
      ),
      alignment: containerAlignment,
      width: containerWidth,
      height: containerHeigth,
      padding: containerPadding,
      margin: containerMargin,
      curve: containerCurve ?? Curves.linear,
      transform: containerTransform,
      clipBehavior: containerClipBehavior ?? Clip.none,
      transformAlignment: transformAlignment,
      child: SizedBox(
        width: buttonWidth ?? 80,
        height: buttonHeigth ?? 40,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll<Color?>(buttonBackgroundColor),
            shape: MaterialStatePropertyAll<OutlinedBorder>(
                buttonShape ?? const RoundedRectangleBorder()),
            padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                buttonPadding ?? EdgeInsets.zero),
            alignment: buttonAlignment,
            shadowColor: MaterialStatePropertyAll<Color?>(buttonShadowColor),
            animationDuration: buttonAnimationDuration,
            elevation: MaterialStatePropertyAll(buttonElevation),
          ),
          onLongPress: onLongPress ?? () {},
          child: child,
        ),
      ),
    );
  }
}
