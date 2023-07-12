import 'dart:ui';

class ToDoCardModel {
  final String text;
  final Color color;
  final String time;
  bool notificationIsActive;
  bool isComplete;

  ToDoCardModel(
      {required this.text,
      required this.color,
      required this.time,
      this.notificationIsActive = false,
      this.isComplete = false});
}
