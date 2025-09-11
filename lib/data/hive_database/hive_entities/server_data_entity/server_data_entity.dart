import 'package:hive/hive.dart';
import 'package:vuiphim/data/hive_database/hive_database.dart';

part 'server_data_entity.g.dart';

@HiveType(typeId: HiveBoxIds.serverDataBoxId)
class ServerDataEntity {
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

  ServerDataEntity({
    required this.name,
    required this.slug,
    required this.filename,
    required this.linkEmbed,
    required this.linkM3U8,
  });
}
