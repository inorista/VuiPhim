// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieEntityAdapter extends TypeAdapter<MovieEntity> {
  @override
  final typeId = 1;

  @override
  MovieEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieEntity(
      adult: fields[0] as bool,
      backdropPath: fields[1] as String,
      genreIds: (fields[2] as List).cast<int>(),
      id: (fields[3] as num).toInt(),
      originalLanguage: fields[4] as String,
      originalTitle: fields[5] as String,
      overview: fields[6] as String,
      popularity: (fields[7] as num).toDouble(),
      posterPath: fields[8] as String,
      releaseDate: fields[9] as String,
      title: fields[10] as String,
      video: fields[11] as bool,
      voteAverage: (fields[12] as num).toDouble(),
      voteCount: (fields[13] as num).toInt(),
      category: fields[14] as MovieCategory?,
      isFavorite: fields[15] == null ? false : fields[15] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, MovieEntity obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.adult)
      ..writeByte(1)
      ..write(obj.backdropPath)
      ..writeByte(2)
      ..write(obj.genreIds)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.originalLanguage)
      ..writeByte(5)
      ..write(obj.originalTitle)
      ..writeByte(6)
      ..write(obj.overview)
      ..writeByte(7)
      ..write(obj.popularity)
      ..writeByte(8)
      ..write(obj.posterPath)
      ..writeByte(9)
      ..write(obj.releaseDate)
      ..writeByte(10)
      ..write(obj.title)
      ..writeByte(11)
      ..write(obj.video)
      ..writeByte(12)
      ..write(obj.voteAverage)
      ..writeByte(13)
      ..write(obj.voteCount)
      ..writeByte(14)
      ..write(obj.category)
      ..writeByte(15)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieEntity _$MovieEntityFromJson(Map<String, dynamic> json) => MovieEntity(
  adult: json['adult'] as bool,
  backdropPath: json['backdrop_path'] as String,
  genreIds: (json['genre_ids'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  id: (json['id'] as num).toInt(),
  originalLanguage: json['original_language'] as String,
  originalTitle: json['original_title'] as String,
  overview: json['overview'] as String,
  popularity: (json['popularity'] as num).toDouble(),
  posterPath: json['poster_path'] as String,
  releaseDate: json['release_date'] as String,
  title: json['title'] as String,
  video: json['video'] as bool,
  voteAverage: (json['vote_average'] as num).toDouble(),
  voteCount: (json['vote_count'] as num).toInt(),
  category: $enumDecodeNullable(_$MovieCategoryEnumMap, json['category']),
  isFavorite: json['isFavorite'] as bool? ?? false,
);

Map<String, dynamic> _$MovieEntityToJson(MovieEntity instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate,
      'title': instance.title,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'category': _$MovieCategoryEnumMap[instance.category],
      'isFavorite': instance.isFavorite,
    };

const _$MovieCategoryEnumMap = {
  MovieCategory.popular: 'popular',
  MovieCategory.topRated: 'topRated',
  MovieCategory.upcoming: 'upcoming',
};
