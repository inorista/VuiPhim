import 'package:hive/hive.dart';
import 'package:vuiphim/data/hive_database/hive_database.dart';

part 'imdb_entity.g.dart';

@HiveType(typeId: HiveBoxIds.imdbBoxId)
class ImdbEntity {
  @HiveField(0)
  final dynamic id;

  ImdbEntity({required this.id});
}
