import 'package:task_muse/core/const/colors.dart';
import 'package:task_muse/feature/main_page/model/personal_color_model.dart';

import '../feature/main_page/model/personal_tag_model.dart';
import '../product/model/to_do_card_model.dart';

class GeneralDatas{
  static List<ToDoCardModel>? toDoCardItems = [
    ToDoCardModel(text: "Meeting with team", color: AppColor.monastic.getColor(), time: "10.00 AM"),
    ToDoCardModel(text: "Pay for rent", color: AppColor.walledGarden.getColor(), time: "9.30 AM"),
    ToDoCardModel(text: "Check emails", color: AppColor.candyDrop.getColor(), time: "1.00 PM"),
    ToDoCardModel(text: "Lunch with Emma", color: AppColor.dandelionWish.getColor(), time: "2.00 PM"),
    ToDoCardModel(text: "Meditation", color: AppColor.atomicOrange.getColor(), time: "5.00 PM"),
  ];

  static List<PersonalTagModel>? personalTags = [
    PersonalTagModel(tag: "Meeting"),
    PersonalTagModel(tag: "Mission"),
    PersonalTagModel(tag: "Sports and Exercise"),
    PersonalTagModel(tag: "Cleaning"),
    PersonalTagModel(tag: "Shopping"),
    PersonalTagModel(tag: "Bills"),
    PersonalTagModel(tag: "Hobbies"),
    PersonalTagModel(tag: "Homework"),
    PersonalTagModel(tag: "Cooking"),
    PersonalTagModel(tag: "Trip Planning"),
  ];
  static List<PersonalColorModel>? personalColor = [
    PersonalColorModel(color: AppColor.boatSwain.getColor()),
    PersonalColorModel(color: AppColor.candyDrop.getColor()),
    PersonalColorModel(color: AppColor.walledGarden.getColor()),
    PersonalColorModel(color: AppColor.monastic.getColor()),
    PersonalColorModel(color: AppColor.enoki.getColor()),
    PersonalColorModel(color: AppColor.dandelionWish.getColor()),
    PersonalColorModel(color: AppColor.aquaticCool.getColor()),
    PersonalColorModel(color: AppColor.mikadoYellow.getColor()),
    PersonalColorModel(color: AppColor.dragonFly.getColor()),
    PersonalColorModel(color: AppColor.atomicOrange.getColor()),
  ];
}

