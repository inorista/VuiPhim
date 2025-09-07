import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vuiphim/core/di/locator.dart' show locator;
import 'package:vuiphim/core/hive_database/hive_daos/movie_dao.dart';
import 'package:vuiphim/core/hive_database/hive_entities/move_entity/movie_entity.dart';
import 'package:vuiphim/core/services/interfaces/imovie_service.dart';
import 'package:vuiphim/core/utils/enum.dart';

part 'upcoming_movie_state.dart';

class UpcomingMovieCubit extends Cubit<UpcomingMovieState> {
  UpcomingMovieCubit() : super(UpcomingMovieInitial());

  var page = 1;
  final _movieService = locator<IMovieService>();
  final _movieDao = locator<MovieDao>();

  void fetchUpcomingMovies() async {
    emit(UpcomingMovieLoading());

    final movieDtos = await _movieService.getUpcomingMovies(
      page: page,
      language: 'vi-VN',
    );

    final movieEntities = movieDtos.results
        .map(
          (item) => MovieEntity.fromDto(item, category: MovieCategory.upcoming),
        )
        .toList();

    emit(UpcomingMovieLoaded(movies: movieEntities));
    await _movieDao.addAll(movieEntities);
  }
}
