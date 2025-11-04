// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_data_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServerDataEntityAdapter extends TypeAdapter<ServerDataEntity> {
  @override
  final int typeId = 8;

  @override
  ServerDataEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServerDataEntity(
      name: fields[0] as String?,
      slug: fields[1] as String?,
      filename: fields[2] as String?,
      linkEmbed: fields[3] as String?,
      linkM3U8: fields[4] as String?,
      episodeId: fields[8] as String,
      playingDuration: fields[5] as int?,
      downloadPath: fields[7] as String?,
      id: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ServerDataEntity obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.slug)
      ..writeByte(2)
      ..write(obj.filename)
      ..writeByte(3)
      ..write(obj.linkEmbed)
      ..writeByte(4)
      ..write(obj.linkM3U8)
      ..writeByte(5)
      ..write(obj.playingDuration)
      ..writeByte(6)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.downloadPath)
      ..writeByte(8)
      ..write(obj.episodeId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServerDataEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
