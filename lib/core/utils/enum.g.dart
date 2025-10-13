// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieCategoryAdapter extends TypeAdapter<MovieCategory> {
  @override
  final int typeId = 3;

  @override
  MovieCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MovieCategory.popular;
      case 1:
        return MovieCategory.topRated;
      case 2:
        return MovieCategory.upcoming;
      default:
        return MovieCategory.popular;
    }
  }

  @override
  void write(BinaryWriter writer, MovieCategory obj) {
    switch (obj) {
      case MovieCategory.popular:
        writer.writeByte(0);
        break;
      case MovieCategory.topRated:
        writer.writeByte(1);
        break;
      case MovieCategory.upcoming:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
