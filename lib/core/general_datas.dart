import 'dart:ui';
import 'package:task_muse/core/const/colors.dart';

import '../product/model/to_do_card_model.dart';

class GeneralDatas{
  static List<ToDoCardModel>? toDoCardItems = [
    ToDoCardModel(text: "Meeting with team", color: AppColor.monastic.getColor(), time: "10.00 AM"),
    ToDoCardModel(text: "Pay for rent", color: AppColor.walledGarden.getColor(), time: "9.30 AM"),
    ToDoCardModel(text: "Check emails", color: AppColor.candyDrop.getColor(), time: "1.00 PM"),
    ToDoCardModel(text: "Lunch with Emma", color: AppColor.dandelionWish.getColor(), time: "2.00 PM"),
    ToDoCardModel(text: "Meditation", color: AppColor.atomicOrange.getColor(), time: "5.00 PM"),
  ];

  static List<Color> selectableColors = [
    AppColor.boatSwain.getColor(),
    AppColor.candyDrop.getColor(),
    AppColor.walledGarden.getColor(),
    AppColor.monastic.getColor(),
    AppColor.enoki.getColor(),
    AppColor.dandelionWish.getColor(),
    AppColor.aquaticCool.getColor(),
    AppColor.mikadoYellow.getColor(),
    AppColor.dragonFly.getColor(),
    AppColor.atomicOrange.getColor(),
  ];
}

///burdaki renkleri ayarlıyorum birde sayfadaki renkleri vericem!