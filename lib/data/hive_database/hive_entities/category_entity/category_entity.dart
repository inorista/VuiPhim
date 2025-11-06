import 'package:hive_ce/hive.dart';
import 'package:vuiphim/data/hive_database/hive_database.dart';

part 'category_entity.g.dart';

@HiveType(typeId: HiveBoxIds.categoryBoxId)
class CategoryEntity {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? slug;

  CategoryEntity({required this.id, required this.name, required this.slug});
}
