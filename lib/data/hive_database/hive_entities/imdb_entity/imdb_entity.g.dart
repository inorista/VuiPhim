// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imdb_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImdbEntityAdapter extends TypeAdapter<ImdbEntity> {
  @override
  final typeId = 12;

  @override
  ImdbEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImdbEntity(id: fields[0] as dynamic);
  }

  @override
  void write(BinaryWriter writer, ImdbEntity obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImdbEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
