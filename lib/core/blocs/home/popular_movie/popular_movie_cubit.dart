import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/data/hive_database/hive_daos/movie_dao.dart';
import 'package:vuiphim/data/hive_database/hive_entities/move_entity/movie_entity.dart';
import 'package:vuiphim/core/services/interfaces/imovie_service.dart';
import 'package:vuiphim/core/utils/enum.dart';

part 'popular_movie_state.dart';

class PopularMovieCubit extends Cubit<PopularMovieState> {
  PopularMovieCubit() : super(PopularMovieInitial());
  var page = 1;
  final _movieService = locator<IMovieService>();
  final _movieDao = locator<MovieDao>();

  void fetchPopularMovies() async {
    emit(PopularMovieLoading());
    final movieDtos = await _movieService.getPopularMovies(
      page: page,
      language: 'vi-VN',
    );

    final movieEntites = movieDtos.results
        .map(
          (item) => MovieEntity.fromDto(item, category: MovieCategory.popular),
        )
        .toList();
    emit(PopularMovieLoaded(movies: movieEntites));
    await _movieDao.addAll(movieEntites);
  }
}
