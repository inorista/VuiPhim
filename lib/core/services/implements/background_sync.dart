import 'package:dio/dio.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/inetwork_service.dart';
import 'package:vuiphim/data/hive_database/hive_daos/genre_dao.dart';
import 'package:vuiphim/core/services/interfaces/ibackground_sync.dart';

class BackgroundSync implements IBackgroundSync {
  final _networkService = locator<INetworkService>();
  @override
  Future<void> syncGenres() async {
    try {
      CancelToken cancelToken = CancelToken();
      final movieGenres = await _networkService.getMovieGenres(cancelToken);
      final genreEntities = movieGenres.genres
          .map((dto) => dto.toEntity())
          .toList();

      // Save genres to the local database
      await locator<GenreDao>().updateAll({
        for (var genre in genreEntities) genre.id: genre,
      });
    } catch (e) {
      rethrow;
    }
  }
}
