import 'package:vuiphim/data/hive_database/hive_entities/cast_entity/cast_entity.dart';

abstract class ICastService {
  Future<List<CastEntity>> getCastsByMovieId(int movieId);
}
