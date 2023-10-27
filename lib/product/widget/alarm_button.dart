import 'package:flutter/material.dart';
import 'package:task_muse/product/extension/context/border_radius.dart';
import 'package:task_muse/product/extension/context/duration.dart';
import 'package:task_muse/product/extension/context/general.dart';
import 'package:task_muse/product/extension/context/padding.dart';

import '../../core/const/colors.dart';
import '../../core/widget/custom_animation_elev_button.dart';
import '../../feature/home/model/personal_alarm_model.dart';

class BottomSheetAlarmButton extends StatelessWidget {
  const BottomSheetAlarmButton({
    super.key,
    this.minOrHourItems,
    required this.index,
    required this.minOrHour,
    required this.onPressed,
  });

  final List<PersonalAlarmModel>? minOrHourItems;
  final int index;
  final int minOrHour;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomAnimationElevatedButton(
        containerMargin: ((minOrHourItems?.length ?? 0) - 1) == index
            ? context.padding.kZeroPadding
            : context.padding.bottomOnlyNormal,
        containerPadding:
        context.padding.dynamicSymmetric(vertical: 0, horizontal: 0.06),
        buttonShape: RoundedRectangleBorder(
            borderRadius: context.border.largeBorderRadius),
        buttonBackgroundColor: (minOrHourItems?[index].isSelected ?? false)
            ? const Color(0xff00CCFF)
            : AppColor.enoki.getColor(),
        onPressed: onPressed,
        containerDuration: context.duration.durationNormal,
        child: Center(
            child: Text(
              (index % minOrHour).toString(),
              style: context.general.textTheme.headlineSmall?.copyWith(
                  color: (minOrHourItems?[index].isSelected ?? false)
                      ? Colors.white
                      : Colors.black),
            )));
  }
}
