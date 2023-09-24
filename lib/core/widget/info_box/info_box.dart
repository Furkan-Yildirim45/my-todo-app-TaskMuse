import 'package:flutter/material.dart';
import 'package:task_muse/product/extension/context/duration.dart';

mixin MainInfoBox {
  void showOverlayEntry(
      {required BuildContext context,
      required OverlayEntry widget}) {
    final entry = widget;
    Overlay.of(context).insert(entry);
    Future.delayed(context.duration.durationSlow, () {
      entry.remove();
    });
  }
}
