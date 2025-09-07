import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/hive_database/hive_daos/genre_dao.dart';
import 'package:vuiphim/core/hive_database/hive_entities/genre_entity/genre_entity.dart';
import 'package:vuiphim/core/services/interfaces/igenre_service.dart';

class GenreService implements IGenreService {
  final _genreDao = locator<GenreDao>();
  @override
  Future<List<GenreEntity>> getAllGenres() async {
    return await _genreDao.getAll();
  }
}
