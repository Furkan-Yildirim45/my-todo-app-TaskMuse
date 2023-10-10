// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 1;

  @override
  TaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModel(
      color: fields[0] as String,
      title: fields[1] as String,
      tag: fields[5] as String,
      date: fields[2] as String?,
      isReminderActive: fields[3] as bool,
      isComplete: fields[4] as bool,
      alarmHour: fields[6] as int?,
      alarmMinute: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.color)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.isReminderActive)
      ..writeByte(4)
      ..write(obj.isComplete)
      ..writeByte(5)
      ..write(obj.tag)
      ..writeByte(6)
      ..write(obj.alarmHour)
      ..writeByte(7)
      ..write(obj.alarmMinute);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
