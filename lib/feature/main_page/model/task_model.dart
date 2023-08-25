import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_muse/core/const/hive_contants.dart';

part 'task_model.g.dart';

@HiveType(typeId: HiveConstants.taskTypeId)
class TaskModel {
  @HiveField(0)
  final String color;
  @HiveField(1)
  final String title;
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
    required this.title,
    this.date,
    this.isReminderActive = false,
    this.isComplete = false,
    this.subTitle,
  });

  //renkleri kullanırken "$renkkodu" şeklinde kullanıyım!
  int get colorValue => int.parse(color.replaceFirst("#", "0xff"));
}
