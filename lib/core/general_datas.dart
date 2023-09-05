import 'package:task_muse/core/const/colors.dart';
import 'package:task_muse/feature/main_page/model/personal_color_model.dart';
import '../feature/main_page/model/personal_tag_model.dart';

class GeneralDatas{

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

