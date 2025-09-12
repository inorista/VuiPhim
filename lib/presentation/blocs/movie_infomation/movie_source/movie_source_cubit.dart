import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/utils/extensions.dart';
import 'package:vuiphim/data/hive_database/hive_daos/movie_detail_dao.dart';
import 'package:vuiphim/data/hive_database/hive_entities/episode_entity/episode_entity.dart';

part 'movie_source_state.dart';

class MovieSourceCubit extends Cubit<MovieSourceState> {
  MovieSourceCubit() : super(MovieSourceLoading());
  final _movieDetailDao = locator<MovieDetailDao>();

  void getMovieSources({required int movieId}) async {
    emit(MovieSourceLoading());
    final movieDetail = await _movieDetailDao.getMovieDetailById(movieId);
    if (movieDetail != null) {
      try {
        final movieSearchResponseDto = await getKKPhimRestClient().searchMovies(
          movieDetail.title,
        );
        final item = movieSearchResponseDto.data?.items.firstOrDefault((
          element,
        ) {
          return ((int.tryParse(element.tmdb?.id ?? '') == movieId) ||
              element.time == movieDetail.title);
        });
        if (item != null) {
          final slug = item.slug;
          final movieSourceDto = await getKKPhimRestClient().getMovieSources(
            slug ?? '',
          );
          final sources = movieSourceDto.episodes
              .map((source) => source.toEntity())
              .toList();
          movieDetail.episodes = sources;
          emit(MovieSourceLoaded(sources: sources));
          await _movieDetailDao.update(movieDetail.id, movieDetail);
        } else {
          emit(const MovieSourceError(message: "Movie source not found."));
        }
      } catch (e) {
        emit(const MovieSourceError(message: "Fetch movie sources failed."));
      }
    } else {
      emit(const MovieSourceError(message: "Movie detail not found."));
    }
  }
}
