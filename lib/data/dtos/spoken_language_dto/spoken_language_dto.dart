import 'package:json_annotation/json_annotation.dart';

part 'spoken_language_dto.g.dart';

@JsonSerializable()
class SpokenLanguageDto {
  @JsonKey(name: 'english_name')
  final String englishName;
  @JsonKey(name: 'iso_639_1')
  final String iso6391;
  final String name;

  SpokenLanguageDto({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  factory SpokenLanguageDto.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguageDtoToJson(this);
}
