// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EpisodeEntityAdapter extends TypeAdapter<EpisodeEntity> {
  @override
  final int typeId = 7;

  @override
  EpisodeEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EpisodeEntity(
      serverName: fields[0] as String?,
      serverData: (fields[1] as List).cast<ServerDataEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, EpisodeEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.serverName)
      ..writeByte(1)
      ..write(obj.serverData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EpisodeEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
