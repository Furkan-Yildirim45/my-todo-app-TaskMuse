// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GlobalModelAdapter extends TypeAdapter<GlobalModel> {
  @override
  final int typeId = 2;

  @override
  GlobalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GlobalModel(
      isAccountActive: fields[0] as bool,
      isThemeDark: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, GlobalModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.isAccountActive)
      ..writeByte(1)
      ..write(obj.isThemeDark);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GlobalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
