
import 'package:flutter/material.dart';
import 'package:task_muse/product/extension/context/general.dart';

class _ContextSizeExtension{
  _ContextSizeExtension(BuildContext context) : _context = context;
  final BuildContext _context;

  double get width => _context.general.mediaQuery.size.width;
  double get height => _context.general.mediaQuery.size.height;
  double dynamicWidth(double value) => width * value;
  double dynamicHeigth(double value) => height * value;
}

extension ContextSizeExtension on BuildContext{
  _ContextSizeExtension get sized => _ContextSizeExtension(this);
}