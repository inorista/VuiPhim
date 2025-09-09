// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastDto _$CastDtoFromJson(Map<String, dynamic> json) => CastDto(
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

Map<String, dynamic> _$CastDtoToJson(CastDto instance) => <String, dynamic>{
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
