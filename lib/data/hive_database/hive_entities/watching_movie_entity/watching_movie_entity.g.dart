// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watching_movie_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WatchingMovieEntityAdapter extends TypeAdapter<WatchingMovieEntity> {
  @override
  final int typeId = 14;

  @override
  WatchingMovieEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WatchingMovieEntity(
      serverDataList: (fields[0] as List).cast<ServerDataEntity>(),
      movieDetail: fields[1] as MovieDetailEntity,
    );
  }

  @override
  void write(BinaryWriter writer, WatchingMovieEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.serverDataList)
      ..writeByte(1)
      ..write(obj.movieDetail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WatchingMovieEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
