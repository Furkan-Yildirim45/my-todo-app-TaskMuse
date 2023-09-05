import 'package:flutter/material.dart';
import 'package:task_muse/core/general_datas.dart';
import 'package:task_muse/product/model/task_model.dart';
import 'package:task_muse/product/extension/context/border_radius.dart';
import 'package:task_muse/product/extension/context/general.dart';
import 'package:task_muse/product/extension/context/icon_size.dart';
import 'package:task_muse/product/extension/context/size.dart';
import 'package:task_muse/product/utility/hive_manager.dart';
import '../../core/const/colors.dart';
import '../../core/widget/custom_circle_button_with_field.dart';

class ToDoCard extends StatefulWidget {
  const ToDoCard({
    super.key,
    required this.index,
  });
  final int index;
  @override
  State<ToDoCard> createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
  List<TaskModel>? taskItems;

  @override
  void initState() {
    super.initState();
    taskItems = TaskCacheManager.instance.getValues?.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.index == ((taskItems?.length ?? 0) - 1)
          ? EdgeInsets.zero
          : EdgeInsets.only(bottom: context.sized.normalValue),
      height: context.sized.dynamicHeigth(0.1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: context.border.largeBorderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: context.sized.kZero,
            blurRadius: 1,
          )
        ],
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        //icon place
        _circleColorAndIconButtonPlace(context),
        _taskTitleAndDate(context),
        _reminderButton(context),
      ]),
    );
  }

  Padding _reminderButton(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.only(right: context.sized.dynamicHeigth(0.025)),
        child: CustomCircleButtonWithField(
          onTap: () {},
          backgroundColor: Colors.transparent,
          child: Icon(
            Icons.notifications,
            size: context.iconSize.normal,
            color: taskItems![widget.index].isReminderActive
                ? AppColor.mikadoYellow.getColor()
                : Colors.grey,
          ),
        ),
      );
  }

  Expanded _taskTitleAndDate(BuildContext context) {
    return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              taskItems?[widget.index].title ?? "",
              style: context
                  .general.textTheme
                  .titleLarge
                  ?.copyWith(color: AppColor.boatSwain.getColor()),
            ),
            Text(
              taskItems?[widget.index].date ?? "",
              style: context.general.textTheme.titleMedium,
            ),
          ],
        ),
      );
  }

  Padding _circleColorAndIconButtonPlace(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.sized.dynamicHeigth(0.025)),
        child: CustomCircleButtonWithField(
          onTap: () {},
          size: context.sized.dynamicHeigth(0.05),
          borderColor: TaskModel.stringToColor(taskItems![widget.index].color),
          backgroundColor: Colors.white,
          child: Icon(
            Icons.check,
            size: context.iconSize.normal,
            color: Colors.white,
          ),
        ),
      );
  }
}
