import 'package:flutter/material.dart';
import 'package:task_muse/const/colors.dart';
import 'package:task_muse/extension/device_size.dart';
import 'package:task_muse/extension/text_theme.dart';
import 'package:task_muse/general_datas.dart';
import 'package:task_muse/model/to_do_card_model.dart';

import '../../core/custom_button_with_field.dart';

class ToDoCard extends StatefulWidget {
  const ToDoCard({
    super.key, required this.index,
  });
  final int index;

  @override
  State<ToDoCard> createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
  final ProjectColors _projectColors = ProjectColors();
  List<ToDoCardModel>? todoItems;
  @override
  void initState() {
    super.initState();
    todoItems = GeneralDatas.toDoCardItems;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.index == (GeneralDatas.toDoCardItems!.length -1) ? EdgeInsets.zero : const EdgeInsets.only(bottom: 10),
      height: context.getDeviceHeight(context) * 0.1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(
          color: Colors.black12,spreadRadius: 0,blurRadius: 1,
        )],
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //icon place
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.getDeviceHeight(context) * 0.025),
              child: CustomButtonWithField(
                onTap: (){},
                size: 32,
                borderColor: todoItems![widget.index].color,
                backgroundColor: Colors.white,
                child: const Icon(Icons.check,size: 28,color: Colors.white,),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(todoItems![widget.index].text,style: context.getTextTheme(context).titleLarge?.copyWith(color: _projectColors.boatSwain),),
                  Text(todoItems![widget.index].time,style: context.getTextTheme(context).titleMedium,),
                ],),
            ),
            Padding(
              padding: EdgeInsets.only(right: context.getDeviceHeight(context) * 0.025),
              child: CustomButtonWithField(
                onTap: (){},
                backgroundColor: Colors.transparent,
                child: Icon(Icons.notifications,size: 28,color: todoItems![widget.index].notificationIsActive ? _projectColors.mikadoYellow : Colors.grey,),
              ),
            ),
          ]),
    );
  }
}

