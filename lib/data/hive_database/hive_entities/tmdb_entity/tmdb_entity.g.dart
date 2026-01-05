// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TmdbEntityAdapter extends TypeAdapter<TmdbEntity> {
  @override
  final typeId = 13;

  @override
  TmdbEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TmdbEntity(
      type: fields[0] as String?,
      id: fields[1] as String?,
      season: fields[2] as dynamic,
      voteAverage: (fields[3] as num?)?.toDouble(),
      voteCount: (fields[4] as num?)?.toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, TmdbEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.season)
      ..writeByte(3)
      ..write(obj.voteAverage)
      ..writeByte(4)
      ..write(obj.voteCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TmdbEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
