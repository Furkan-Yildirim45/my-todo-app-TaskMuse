import 'dart:ui';
import 'package:task_muse/const/colors.dart';
import 'model/to_do_card_model.dart';

class GeneralDatas{
  final ProjectColors projectColors = ProjectColors();
  static List<ToDoCardModel>? toDoCardItems = [
    ToDoCardModel(text: "Meeting with team", color: const Color(0xffaaaad7), time: "10.00 AM"),
    ToDoCardModel(text: "Pay for rent", color: const Color(0xff15d436), time: "9.30 AM"),
    ToDoCardModel(text: "Check emails", color: const Color(0xffc0626c), time: "1.00 PM"),
    ToDoCardModel(text: "Lunch with Emma", color: const Color(0xffe4b767), time: "2.00 PM"),
    ToDoCardModel(text: "Meditation", color: const Color(0xfffc8404), time: "5.00 PM"),
  ];
}

//senaryom geregi ne abi:işte ilk başladıgında hiçbirşey olmayabilir yani null atıcaksın liste,