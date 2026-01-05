import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';
import 'package:uuid/uuid.dart';
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
  final int? playingDuration;
  @HiveField(6)
  final String id;
  @HiveField(7)
  final String? downloadPath;
  @HiveField(8)
  final String? episodeId;
  @HiveField(9)
  final int? runtime;

  ServerDataEntity({
    required this.name,
    required this.slug,
    required this.filename,
    required this.linkEmbed,
    required this.linkM3U8,
    this.episodeId,
    this.playingDuration,
    this.runtime,
    this.downloadPath,
    String? id,
  }) : id = id ?? const Uuid().v4();

  ServerDataEntity copyWith({
    String? name,
    String? slug,
    String? filename,
    String? linkEmbed,
    String? linkM3U8,
    int? playingDuration,
    int? runtime,
    String? id,
    String? downloadPath,
    String? episodeId,
  }) {
    return ServerDataEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      filename: filename ?? this.filename,
      linkEmbed: linkEmbed ?? this.linkEmbed,
      linkM3U8: linkM3U8 ?? this.linkM3U8,
      playingDuration: playingDuration ?? this.playingDuration,
      runtime: runtime ?? this.runtime,
      downloadPath: downloadPath ?? this.downloadPath,
      episodeId: episodeId ?? this.episodeId,
    );
  }

  double progress(double width) {
    if (runtime == null || runtime == 0) {
      return 0;
    }
    final progressWidth = (playingDuration ?? 0) * width / runtime!;
    return progressWidth;
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
    episodeId,
    playingDuration,
    runtime,
  ];
}
