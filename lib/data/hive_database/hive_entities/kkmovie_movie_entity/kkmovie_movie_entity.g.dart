// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kkmovie_movie_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KkMovieMovieEntityAdapter extends TypeAdapter<KkMovieMovieEntity> {
  @override
  final int typeId = 9;

  @override
  KkMovieMovieEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KkMovieMovieEntity(
      tmdb: fields[0] as TmdbEntity?,
      imdb: fields[1] as ImdbEntity?,
      created: fields[2] as CreatedEntity?,
      modified: fields[3] as CreatedEntity?,
      id: fields[4] as String?,
      name: fields[5] as String?,
      slug: fields[6] as String?,
      originName: fields[7] as String?,
      content: fields[8] as String?,
      type: fields[9] as String?,
      status: fields[10] as String?,
      posterUrl: fields[11] as String?,
      thumbUrl: fields[12] as String?,
      isCopyright: fields[13] as bool?,
      subDocquyen: fields[14] as bool?,
      chieurap: fields[15] as bool?,
      trailerUrl: fields[16] as String?,
      time: fields[17] as String?,
      episodeCurrent: fields[18] as String?,
      episodeTotal: fields[19] as String?,
      quality: fields[20] as String?,
      lang: fields[21] as String?,
      notify: fields[22] as String?,
      showtimes: fields[23] as String?,
      year: fields[24] as int?,
      view: fields[25] as int?,
      actor: (fields[26] as List).cast<String>(),
      director: (fields[27] as List).cast<String>(),
      category: (fields[28] as List).cast<CategoryEntity>(),
      country: (fields[29] as List).cast<CategoryEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, KkMovieMovieEntity obj) {
    writer
      ..writeByte(30)
      ..writeByte(0)
      ..write(obj.tmdb)
      ..writeByte(1)
      ..write(obj.imdb)
      ..writeByte(2)
      ..write(obj.created)
      ..writeByte(3)
      ..write(obj.modified)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.slug)
      ..writeByte(7)
      ..write(obj.originName)
      ..writeByte(8)
      ..write(obj.content)
      ..writeByte(9)
      ..write(obj.type)
      ..writeByte(10)
      ..write(obj.status)
      ..writeByte(11)
      ..write(obj.posterUrl)
      ..writeByte(12)
      ..write(obj.thumbUrl)
      ..writeByte(13)
      ..write(obj.isCopyright)
      ..writeByte(14)
      ..write(obj.subDocquyen)
      ..writeByte(15)
      ..write(obj.chieurap)
      ..writeByte(16)
      ..write(obj.trailerUrl)
      ..writeByte(17)
      ..write(obj.time)
      ..writeByte(18)
      ..write(obj.episodeCurrent)
      ..writeByte(19)
      ..write(obj.episodeTotal)
      ..writeByte(20)
      ..write(obj.quality)
      ..writeByte(21)
      ..write(obj.lang)
      ..writeByte(22)
      ..write(obj.notify)
      ..writeByte(23)
      ..write(obj.showtimes)
      ..writeByte(24)
      ..write(obj.year)
      ..writeByte(25)
      ..write(obj.view)
      ..writeByte(26)
      ..write(obj.actor)
      ..writeByte(27)
      ..write(obj.director)
      ..writeByte(28)
      ..write(obj.category)
      ..writeByte(29)
      ..write(obj.country);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KkMovieMovieEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
