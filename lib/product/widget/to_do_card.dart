import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_muse/product/extension/context/duration.dart';
import 'package:task_muse/product/global/cubit/global_manage_cubit.dart';
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
    return AnimatedContainer(
      transform: (widget.taskItems?[widget.index].isSwiped ?? false)
          ? Matrix4.translationValues(-context.sized.dynamicHeigth(0.08), 0, 0)
          : Matrix4.translationValues(0, 0, 0),
      duration: context.duration.durationFast,
      margin: mainContainerMargin(),
      height: context.sized.dynamicHeigth(0.1),
      decoration: _mainContainerDecoration(context),
      child: ElevatedButton(
        style: _elevatedButtonStyle(context),
        onLongPress: () {
          context.read<GlobalManageCubit>().changeIsSwiped(widget.index);
        },
        onPressed: () {
          context.read<GlobalManageCubit>().makeIsSwipedFalse();
        },
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //icon place
              _circleColorAndIconButtonPlace(context),
              _taskTitleAndDate(context),
              _reminderButton(context),
            ]),
      ),
    );
  }
}

mixin _TodoCardUtility on State<ToDoCard> {
  EdgeInsets mainContainerMargin() =>
      widget.index == ((widget.taskItems?.length ?? 0) - 1)
          ? EdgeInsets.zero
          : EdgeInsets.only(bottom: context.sized.normalValue);

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

  Padding _reminderButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: context.sized.dynamicHeigth(0.025)),
      child: CustomCircleButtonWithField(
        size: 50,
        onTap: () async {
          ///todo:burad bi sıkıntı var o da güncelleme ve elemanı ekliyor galiba buna bir bak!
          setState(() {
            widget.taskItems?[widget.index].isReminderActive =
                !(widget.taskItems?[widget.index].isReminderActive ?? true);
          });
          // await TaskCacheManager.instance.putItems(widget.taskItems);
        },
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.notifications,
          size: context.iconSize.normal,
          color: (widget.taskItems?[widget.index].isReminderActive ?? false)
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
            widget.taskItems?[widget.index].title ?? "",
            style: context.general.textTheme.titleLarge
                ?.copyWith(color: AppColor.boatSwain.getColor()),
          ),
          Text(
            widget.taskItems?[widget.index].date ?? "",
            style: context.general.textTheme.titleMedium,
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
          setState(() {
            widget.taskItems?[widget.index].isComplete =
                !(widget.taskItems?[widget.index].isComplete ?? true);
          });
        },
        size: context.sized.dynamicHeigth(0.05),
        borderColor:
            TaskModel.stringToColor(widget.taskItems?[widget.index].color ?? "0xff000000"), //todo: geçici atıyorum null olup olmadıgına bakılıcak!
        backgroundColor: (widget.taskItems?[widget.index].isComplete ?? false)
            ? TaskModel.stringToColor(widget.taskItems?[widget.index].color ?? "0xff000000") //todo: geçici atıyorum null olup olmadıgına bakılıcak!
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
