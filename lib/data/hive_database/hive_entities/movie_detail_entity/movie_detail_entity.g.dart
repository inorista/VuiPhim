// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieDetailEntityAdapter extends TypeAdapter<MovieDetailEntity> {
  @override
  final typeId = 5;

  @override
  MovieDetailEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieDetailEntity(
      adult: fields[0] as bool,
      backdropPath: fields[1] as String?,
      budget: (fields[2] as num).toInt(),
      genres: (fields[3] as List).cast<GenreEntity>(),
      homepage: fields[4] as String,
      id: (fields[5] as num).toInt(),
      imdbId: fields[6] as String?,
      originCountry: (fields[7] as List).cast<String>(),
      originalLanguage: fields[8] as String,
      originalTitle: fields[9] as String,
      overview: fields[10] as String,
      popularity: (fields[11] as num).toDouble(),
      posterPath: fields[12] as String?,
      releaseDate: fields[13] as String,
      revenue: (fields[14] as num).toInt(),
      runtime: (fields[15] as num).toInt(),
      status: fields[16] as String,
      tagline: fields[17] as String,
      title: fields[18] as String,
      video: fields[19] as bool,
      voteAverage: (fields[20] as num).toDouble(),
      voteCount: (fields[21] as num).toInt(),
      casts: fields[22] == null
          ? const []
          : (fields[22] as List).cast<CastEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, MovieDetailEntity obj) {
    writer
      ..writeByte(23)
      ..writeByte(0)
      ..write(obj.adult)
      ..writeByte(1)
      ..write(obj.backdropPath)
      ..writeByte(2)
      ..write(obj.budget)
      ..writeByte(3)
      ..write(obj.genres)
      ..writeByte(4)
      ..write(obj.homepage)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.imdbId)
      ..writeByte(7)
      ..write(obj.originCountry)
      ..writeByte(8)
      ..write(obj.originalLanguage)
      ..writeByte(9)
      ..write(obj.originalTitle)
      ..writeByte(10)
      ..write(obj.overview)
      ..writeByte(11)
      ..write(obj.popularity)
      ..writeByte(12)
      ..write(obj.posterPath)
      ..writeByte(13)
      ..write(obj.releaseDate)
      ..writeByte(14)
      ..write(obj.revenue)
      ..writeByte(15)
      ..write(obj.runtime)
      ..writeByte(16)
      ..write(obj.status)
      ..writeByte(17)
      ..write(obj.tagline)
      ..writeByte(18)
      ..write(obj.title)
      ..writeByte(19)
      ..write(obj.video)
      ..writeByte(20)
      ..write(obj.voteAverage)
      ..writeByte(21)
      ..write(obj.voteCount)
      ..writeByte(22)
      ..write(obj.casts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieDetailEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
