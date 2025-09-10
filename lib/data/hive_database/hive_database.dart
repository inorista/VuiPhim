import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vuiphim/data/hive_database/hive_entities/cast_entity/cast_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/genre_entity/genre_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/move_entity/movie_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/movie_detail_entity/movie_detail_entity.dart';
import 'package:vuiphim/core/utils/enum.dart';

class HiveDatabase {
  Future<void> setupHiveDatabase() async {
    Directory document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);
    // Register Adapters
    Hive.registerAdapter(MovieEntityAdapter());
    Hive.registerAdapter(MovieCategoryAdapter());
    Hive.registerAdapter(GenreEntityAdapter());
    Hive.registerAdapter(CastEntityAdapter());
    Hive.registerAdapter(MovieDetailEntityAdapter());
  }
}

class HiveBoxIds {
  static const movieBoxId = 1;
  static const castBoxId = 2;
  static const movieCategoryBoxId = 3;
  static const genreBoxId = 4;
  static const movieDetailBoxId = 5;
}
