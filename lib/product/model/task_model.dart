import 'dart:ui';

import 'package:hive_flutter/adapters.dart';
import 'package:task_muse/core/const/hive_contants.dart';

part 'task_model.g.dart';

@HiveType(typeId: HiveConstants.taskTypeId)
class TaskModel {
  @HiveField(0)
  final String color;
  @HiveField(1)
  String title;
  @HiveField(2)
  final String? date;
  @HiveField(3)
  bool isReminderActive;
  @HiveField(4)
  bool isComplete;
  @HiveField(5)
  String tag;
  bool isSwiped;

  TaskModel({
     required this.color,
     required this.title,
    required this.tag,
    this.date,
    this.isReminderActive = false,
    this.isComplete = false,
    this.isSwiped = false,
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
