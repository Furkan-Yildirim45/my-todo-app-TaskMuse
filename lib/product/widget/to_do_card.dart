import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_muse/product/extension/context/duration.dart';
import 'package:task_muse/product/extension/context/padding.dart';
import 'package:task_muse/product/global/cubit/global_manage_cubit.dart';
import 'package:task_muse/product/global/cubit/global_manage_state.dart';
import 'package:task_muse/product/model/task_model.dart';
import 'package:task_muse/product/extension/context/border_radius.dart';
import 'package:task_muse/product/extension/context/general.dart';
import 'package:task_muse/product/extension/context/icon_size.dart';
import 'package:task_muse/product/extension/context/size.dart';
import '../../core/const/colors.dart';
import '../../core/widget/custom_circle_button_with_field.dart';

class ToDoCard extends StatefulWidget {
  const ToDoCard({
    super.key,
    required this.index,
    required this.taskItems,
  });

  final int index;
  final List<TaskModel>? taskItems;

  @override
  State<ToDoCard> createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> with _TodoCardUtility {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<GlobalManageCubit, GlobalManageState, bool>(
      selector: (state) {
        return state.isAnyCardSwiped ?? false;
      },
      builder: (context, state) {
        return AnimatedContainer(
          transform: containerTransform(),
          duration: context.duration.durationFast,
          margin: _containerMargin(),
          height: context.sized.dynamicHeigth(0.1),
          decoration: _mainContainerDecoration(context),
          child: ElevatedButton(
            style: _elevatedButtonStyle(context),
            onLongPress: () {
              context.read<GlobalManageCubit>().changeIsSwiped(widget.index);
            },
            onPressed: state ? () {context.read<GlobalManageCubit>().makeIsSwipedFalse();} : null,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //icon place
                  _circleColorAndIconButtonPlace(context),
                  _taskTitleAndDate(context),
                  _reminderButton(
                    context,
                  ),
                ]),
          ),
        );
      },
    );
  }

  Padding _reminderButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: context.sized.dynamicHeigth(0.025)),
      child: CustomCircleButtonWithField(
        size: 45,
        onTap: () {context.read<GlobalManageCubit>().changeReminder(widget.index);setState(() {});},
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.notifications,
          color: (widget.taskItems?[widget.index].isReminderActive ?? false)
              ? AppColor.mikadoYellow.getColor()
              : AppColor.defaultColor.getColor(),
          size: context.iconSize.normal,
        ),
      ),
    );
  }
}

mixin _TodoCardUtility on State<ToDoCard> {

  Matrix4 containerTransform() => (widget.taskItems?[widget.index].isSwiped ?? false)
      ? Matrix4.translationValues(-context.sized.dynamicHeigth(0.15), 0, 0)
      : Matrix4.translationValues(0, 0, 0);

  EdgeInsets _containerMargin() => context.padding.bottomOnlyNormal;

  BoxDecoration _mainContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: context.border.largeBorderRadius,
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          spreadRadius: context.sized.kZero,
          blurRadius: 1,
        )
      ],
    );
  }

  ButtonStyle _elevatedButtonStyle(BuildContext context) {
    return ButtonStyle(
        shadowColor: const MaterialStatePropertyAll(Colors.transparent),
        elevation: const MaterialStatePropertyAll(0),
        backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
        padding: const MaterialStatePropertyAll(EdgeInsets.zero),
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: context.border.largeBorderRadius)));
  }

  Expanded _taskTitleAndDate(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.taskItems?[widget.index].title ?? "",
            style: context.general.textTheme.titleLarge?.copyWith(
                color: (widget.taskItems?[widget.index].isComplete ?? false) ? Colors.grey : AppColor.boatSwain.getColor(),
                decoration:
                    (widget.taskItems?[widget.index].isComplete ?? false)
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tag Place',style: context.general.textTheme.titleMedium?.copyWith(color: Colors.grey),),
              Text(
                widget.taskItems?[widget.index].date ?? "",
                style: context.general.textTheme.titleMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding _circleColorAndIconButtonPlace(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: context.sized.dynamicHeigth(0.025)),
      child: CustomCircleButtonWithField(
        onTap: () {
          context.read<GlobalManageCubit>().changeIsComplete(widget.index);
        },
        size: context.sized.dynamicHeigth(0.05),
        borderColor:
            TaskModel.stringToColor(widget.taskItems?[widget.index].color ?? "${AppColor.defaultColor}"),
        backgroundColor: (widget.taskItems?[widget.index].isComplete ?? false)
            ? TaskModel.stringToColor(widget.taskItems?[widget.index].color ?? "${AppColor.defaultColor}")
            : Colors.white,
        child: Icon(
          Icons.check,
          size: context.iconSize.normal,
          color: Colors.white,
        ),
      ),
    );
  }
}
