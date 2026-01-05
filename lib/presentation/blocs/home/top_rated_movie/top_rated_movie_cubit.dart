import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/data/hive_database/hive_daos/movie_dao.dart';
import 'package:vuiphim/data/hive_database/hive_entities/move_entity/movie_entity.dart';
import 'package:vuiphim/core/services/interfaces/imovie_service.dart';
import 'package:vuiphim/core/utils/enum.dart';

part 'top_rated_movie_state.dart';

class TopRatedMovieCubit extends Cubit<TopRatedMovieState> {
  TopRatedMovieCubit() : super(TopRatedMovieInitial());
  var page = 1;
  final _movieService = locator<IMovieService>();
  final _movieDao = locator<MovieDao>();

  void fetchTopRatedMovies() async {
    emit(TopRatedMovieLoading());

    final movieDtos = await _movieService.getTopRatedMovies(
      page: page,
      language: 'vi-VN',
    );

    if (isClosed) return;

    final movieEntities = movieDtos.results
        .map(
          (item) => MovieEntity.fromDto(item, category: MovieCategory.topRated),
        )
        .toList();

    emit(TopRatedMovieLoaded(movies: movieEntities));
    await _movieDao.updateAll({
      for (var movie in movieEntities) movie.id: movie,
    });
  }
}
