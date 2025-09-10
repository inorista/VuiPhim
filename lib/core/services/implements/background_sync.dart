import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/data/hive_database/hive_daos/genre_dao.dart';
import 'package:vuiphim/core/services/interfaces/ibackground_sync.dart';

class BackgroundSync implements IBackgroundSync {
  @override
  Future<void> syncGenres() async {
    final genreResponseDto = await getRestClient().getMovieGenres();
    final genreEntities = genreResponseDto.genres
        .map((dto) => dto.toEntity())
        .toList();

    // Save genres to the local database
    await locator<GenreDao>().addAll(genreEntities);
  }
}
