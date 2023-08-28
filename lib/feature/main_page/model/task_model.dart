import 'dart:ui';

import 'package:hive_flutter/adapters.dart';
import 'package:task_muse/core/const/hive_contants.dart';

part 'task_model.g.dart';

@HiveType(typeId: HiveConstants.taskTypeId)
class TaskModel {
  @HiveField(0)
  final String color;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? date;
  @HiveField(3)
  final bool isReminderActive;
  @HiveField(4)
  final bool isComplete;
  @HiveField(5)
  final String? subTitle;

  TaskModel({
     required this.color,
     this.title,
    this.date,
    this.isReminderActive = false,
    this.isComplete = false,
    this.subTitle,
  });

  static String colorToString(Color color) {
    // Color değerini hex formatına çevirme işlemi
    return '#${color.value.toRadixString(16).padLeft(8, '0')}';
  }

  static Color stringToColor(String colorString) {
    // Hex formatındaki String'i Color değerine çevirme işlemi
    final value = int.parse(colorString.replaceAll('#', ''), radix: 16);
    return Color(value);
  }
}
