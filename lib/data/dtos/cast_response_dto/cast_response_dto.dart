import 'package:json_annotation/json_annotation.dart';
import 'package:vuiphim/data/dtos/cast_dto/cast_dto.dart';

part 'cast_response_dto.g.dart';

@JsonSerializable()
class CastResponseDto {
  final int id;
  final List<CastDto> cast;

  CastResponseDto({required this.id, required this.cast});
  factory CastResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CastResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CastResponseDtoToJson(this);
}
