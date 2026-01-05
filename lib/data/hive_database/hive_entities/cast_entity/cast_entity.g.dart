// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CastEntityAdapter extends TypeAdapter<CastEntity> {
  @override
  final typeId = 2;

  @override
  CastEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CastEntity(
      adult: fields[0] as bool,
      gender: (fields[1] as num).toInt(),
      id: (fields[2] as num).toInt(),
      knownForDepartment: fields[3] as String,
      name: fields[4] as String,
      originalName: fields[5] as String,
      popularity: (fields[6] as num).toDouble(),
      castId: (fields[7] as num?)?.toInt(),
      character: fields[8] as String?,
      profilePath: fields[9] as String?,
      creditId: fields[10] as String,
      order: (fields[11] as num?)?.toInt(),
      department: fields[12] as String?,
      job: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CastEntity obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.adult)
      ..writeByte(1)
      ..write(obj.gender)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.knownForDepartment)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.originalName)
      ..writeByte(6)
      ..write(obj.popularity)
      ..writeByte(7)
      ..write(obj.castId)
      ..writeByte(8)
      ..write(obj.character)
      ..writeByte(9)
      ..write(obj.profilePath)
      ..writeByte(10)
      ..write(obj.creditId)
      ..writeByte(11)
      ..write(obj.order)
      ..writeByte(12)
      ..write(obj.department)
      ..writeByte(13)
      ..write(obj.job);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CastEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastEntity _$CastEntityFromJson(Map<String, dynamic> json) => CastEntity(
  adult: json['adult'] as bool,
  gender: (json['gender'] as num).toInt(),
  id: (json['id'] as num).toInt(),
  knownForDepartment: json['known_for_department'] as String,
  name: json['name'] as String,
  originalName: json['original_name'] as String,
  popularity: (json['popularity'] as num).toDouble(),
  castId: (json['cast_id'] as num?)?.toInt(),
  character: json['character'] as String?,
  profilePath: json['profile_path'] as String?,
  creditId: json['credit_id'] as String,
  order: (json['order'] as num?)?.toInt(),
  department: json['department'] as String?,
  job: json['job'] as String?,
);

Map<String, dynamic> _$CastEntityToJson(CastEntity instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'gender': instance.gender,
      'id': instance.id,
      'known_for_department': instance.knownForDepartment,
      'name': instance.name,
      'original_name': instance.originalName,
      'popularity': instance.popularity,
      'cast_id': instance.castId,
      'character': instance.character,
      'profile_path': instance.profilePath,
      'credit_id': instance.creditId,
      'order': instance.order,
      'department': instance.department,
      'job': instance.job,
    };
