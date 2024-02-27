// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataHistoryModelAdapter extends TypeAdapter<DataHistoryModel> {
  @override
  final int typeId = 50;

  @override
  DataHistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataHistoryModel(
      inputValue: fields[0] as String,
      outputValue: fields[1] as String,
      date: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DataHistoryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.inputValue)
      ..writeByte(1)
      ..write(obj.outputValue)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataHistoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
