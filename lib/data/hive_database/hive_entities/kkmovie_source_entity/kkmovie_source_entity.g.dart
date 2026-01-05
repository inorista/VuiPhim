// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kkmovie_source_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KkMovieSourceEntityAdapter extends TypeAdapter<KkMovieSourceEntity> {
  @override
  final typeId = 6;

  @override
  KkMovieSourceEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KkMovieSourceEntity(
      status: fields[0] as bool?,
      msg: fields[1] as String?,
      movie: fields[2] as KkMovieMovieEntity?,
      episodes: (fields[3] as List).cast<EpisodeEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, KkMovieSourceEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.msg)
      ..writeByte(2)
      ..write(obj.movie)
      ..writeByte(3)
      ..write(obj.episodes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KkMovieSourceEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
