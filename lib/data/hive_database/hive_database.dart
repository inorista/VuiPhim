import 'dart:io';

import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vuiphim/core/utils/enum.dart';
import 'package:vuiphim/data/hive_database/hive_entities/cast_entity/cast_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/genre_entity/genre_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/move_entity/movie_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/movie_detail_entity/movie_detail_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/category_entity/category_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/created_entity/created_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/episode_entity/episode_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/imdb_entity/imdb_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/kkmovie_movie_entity/kkmovie_movie_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/kkmovie_source_entity/kkmovie_source_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/server_data_entity/server_data_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/tmdb_entity/tmdb_entity.dart';

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
    Hive.registerAdapter(KkMovieSourceEntityAdapter());
    Hive.registerAdapter(EpisodeEntityAdapter());
    Hive.registerAdapter(ServerDataEntityAdapter());
    Hive.registerAdapter(KkMovieMovieEntityAdapter());
    Hive.registerAdapter(CategoryEntityAdapter());
    Hive.registerAdapter(CreatedEntityAdapter());
    Hive.registerAdapter(ImdbEntityAdapter());
    Hive.registerAdapter(TmdbEntityAdapter());
  }
}

class HiveBoxIds {
  static const movieBoxId = 1;
  static const castBoxId = 2;
  static const movieCategoryBoxId = 3;
  static const genreBoxId = 4;
  static const movieDetailBoxId = 5;
  static const kkMovieSourceBoxId = 6;
  static const episodeBoxId = 7;
  static const serverDataBoxId = 8;
  static const kkMovieMovieBoxId = 9;
  static const categoryBoxId = 10;
  static const createdBoxId = 11;
  static const imdbBoxId = 12;
  static const tmdbBoxId = 13;
  static const watchingMovieBoxId = 14;
}
