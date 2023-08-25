import 'package:flutter/material.dart';
import 'package:task_muse/core/general_datas.dart';
import 'package:task_muse/product/extension/context/general.dart';
import 'package:task_muse/product/extension/context/size.dart';
import '../../core/const/colors.dart';
import '../../core/widget/custom_circle_button_with_field.dart';
import '../model/to_do_card_model.dart';

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
  List<ToDoCardModel>? todoItems;

  @override
  void initState() {
    super.initState();
    todoItems = GeneralDatas.toDoCardItems;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.index == (GeneralDatas.toDoCardItems!.length - 1)
          ? EdgeInsets.zero
          : const EdgeInsets.only(bottom: 10),
      height: context.sized.dynamicHeigth(0.1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 0,
            blurRadius: 1,
          )
        ],
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        //icon place
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.sized.dynamicHeigth(0.025)),
          child: CustomCircleButtonWithField(
            onTap: () {},
            size: 32,
            borderColor: todoItems![widget.index].color,
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.check,
              size: 28,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                todoItems![widget.index].text,
                style: context
                    .general.textTheme
                    .titleLarge
                    ?.copyWith(color: AppColor.boatSwain.getColor()),
              ),
              Text(
                todoItems![widget.index].time,
                style: context.general.textTheme.titleMedium,
              ),
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(right: context.sized.dynamicHeigth(0.025)),
          child: CustomCircleButtonWithField(
            onTap: () {},
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.notifications,
              size: 28,
              color: todoItems![widget.index].notificationIsActive
                  ? AppColor.mikadoYellow.getColor()
                  : Colors.grey,
            ),
          ),
        ),
      ]),
    );
  }
}
