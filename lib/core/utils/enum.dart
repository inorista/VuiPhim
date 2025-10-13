import 'package:hive/hive.dart';
import 'package:vuiphim/data/hive_database/hive_database.dart';
part 'enum.g.dart';

@HiveType(typeId: HiveBoxIds.movieCategoryBoxId)
enum MovieCategory {
  @HiveField(0)
  popular,
  @HiveField(1)
  topRated,
  @HiveField(2)
  upcoming,
}

enum VibrateStyle { light, medium, heavy, soft, rigid } // Styles:
