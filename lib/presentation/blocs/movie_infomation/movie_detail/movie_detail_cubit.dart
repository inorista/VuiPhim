import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/data/hive_database/hive_daos/cast_dao.dart';
import 'package:vuiphim/data/hive_database/hive_daos/movie_detail_dao.dart';
import 'package:vuiphim/data/hive_database/hive_entities/cast_entity/cast_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/movie_detail_entity/movie_detail_entity.dart';
import 'package:vuiphim/core/services/interfaces/imovie_service.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit() : super(MovieDetailInitial());

  final _movieService = locator<IMovieService>();
  final _movieDetailDao = locator<MovieDetailDao>();
  final _castDao = locator<CastDao>();

  void fetchMovieDetailFromId(String movieId) async {
    emit(MovieDetailLoading());

    // LOAD FROM HIVE DB FIRST
    final movieDetailEntity = await _movieDetailDao.getMovieDetailById(
      int.tryParse(movieId) ?? 0,
    );

    if (movieDetailEntity != null) {
      final castEntities = movieDetailEntity.casts;
      emit(
        MovieDetailLoaded(movieDetail: movieDetailEntity, cast: castEntities),
      );
      return;
    }

    // IF NOT FOUND, FETCH FROM API

    final movieDetailDto = await _movieService.fetchMovieDetailFromId(movieId);
    final castResponseDto = await _movieService.fetchMovieCreditsFromId(
      movieId,
    );
    if (movieDetailDto != null) {
      final movieEntity = MovieDetailEntity.fromDto(movieDetailDto);

      final castEntities =
          castResponseDto?.cast.map((castDto) => castDto.toEntity()).toList() ??
          [];
      emit(MovieDetailLoaded(movieDetail: movieEntity, cast: castEntities));
      movieEntity.casts = castEntities;
      await _movieDetailDao.update(movieEntity.id, movieEntity);
      await _castDao.updateAll({for (var cast in castEntities) cast.id: cast});
    } else {
      emit(const MovieDetailError(message: 'Failed to fetch movie details'));
    }
  }
}
