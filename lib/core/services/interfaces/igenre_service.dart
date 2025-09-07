import 'package:vuiphim/core/hive_database/hive_entities/genre_entity/genre_entity.dart';

abstract class IGenreService {
  Future<List<GenreEntity>> getAllGenres();
}
