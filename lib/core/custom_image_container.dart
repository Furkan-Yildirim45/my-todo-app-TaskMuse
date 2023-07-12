
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key, this.width, this.height, this.borderRadius, required this.image,
  });
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 40,
      height: height ?? 40,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        image: DecorationImage(
            image:
            AssetImage(image),
            fit: BoxFit.cover),
      ),
    );
  }
}

