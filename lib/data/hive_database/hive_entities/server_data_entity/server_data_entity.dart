import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:vuiphim/data/hive_database/hive_database.dart';

part 'server_data_entity.g.dart';

@HiveType(typeId: HiveBoxIds.serverDataBoxId)
// ignore: must_be_immutable
class ServerDataEntity extends Equatable {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? slug;
  @HiveField(2)
  final String? filename;
  @HiveField(3)
  final String? linkEmbed;
  @HiveField(4)
  final String? linkM3U8;
  @HiveField(5)
  int? playingDuration;
  @HiveField(6)
  final String id;
  @HiveField(7)
  final String? downloadPath;

  ServerDataEntity({
    required this.name,
    required this.slug,
    required this.filename,
    required this.linkEmbed,
    required this.linkM3U8,
    this.playingDuration,
    required this.id,
    this.downloadPath,
  });

  ServerDataEntity copyWith({
    String? name,
    String? slug,
    String? filename,
    String? linkEmbed,
    String? linkM3U8,
    int? playingDuration,
    String? id,
    String? downloadPath,
  }) {
    return ServerDataEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      filename: filename ?? this.filename,
      linkEmbed: linkEmbed ?? this.linkEmbed,
      linkM3U8: linkM3U8 ?? this.linkM3U8,
      playingDuration: playingDuration ?? this.playingDuration,
      downloadPath: downloadPath ?? this.downloadPath,
    );
  }

  @override
  List<Object?> get props => [
    name,
    slug,
    filename,
    linkEmbed,
    linkM3U8,
    downloadPath,
    id,
  ];
}
