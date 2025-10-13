import 'package:hive/hive.dart';
import 'package:vuiphim/data/hive_database/hive_database.dart';

part 'created_entity.g.dart';

@HiveType(typeId: HiveBoxIds.createdBoxId)
class CreatedEntity {
  @HiveField(0)
  final DateTime? time;

  CreatedEntity({required this.time});
}
