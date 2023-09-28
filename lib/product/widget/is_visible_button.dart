import 'package:flutter/material.dart';
import 'package:task_muse/product/extension/context/duration.dart';
import 'package:task_muse/product/extension/context/icon_size.dart';
import 'package:task_muse/product/extension/context/padding.dart';
import 'package:task_muse/product/extension/context/size.dart';

import '../../core/widget/custom_animation_elev_button.dart';
import '../global/cubit/global_manage_state.dart';

class IsVisibleButton extends StatelessWidget {
  const IsVisibleButton({Key? key, required this.context, required this.iconColor, required this.icon, required this.state, required this.backgroundColor, required this.onPressed, required this.index}) : super(key: key);
  final BuildContext context;
  final Color iconColor;
  final IconData icon;
  final GlobalManageState state;
  final Color backgroundColor;
  final void Function() onPressed;
  final int index;
  @override
  Widget build(BuildContext context) {
    var containerSize = (state.taskItems?[index].isSwiped ?? false) ? context.sized.middleButtonSize : context.sized.kZero;
    double iconSize = (state.taskItems?[index].isSwiped ?? false) ? context.iconSize.normal : 0;
    return CustomAnimationElevatedButton(
        containerColor: backgroundColor,
        containerBorderRadius: BorderRadius.circular(context.sized.middleButtonSize / 2),
        containerHeigth: containerSize,
        containerWidth: containerSize,
        onPressed: onPressed,
        containerMargin: EdgeInsets.only(bottom: context.sized.normalValue,left: context.sized.normalValue),
        containerDuration: context.duration.durationFast,
        buttonElevation: context.sized.kZero,
        buttonPadding: context.padding.kZeroPadding,
        buttonBackgroundColor: Colors.transparent,
        buttonShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.sized.middleButtonSize / 2)),
        child: Icon(icon,color: iconColor,size: iconSize,)
    );
  }
}
