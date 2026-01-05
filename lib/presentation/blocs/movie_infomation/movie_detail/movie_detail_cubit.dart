import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/imovie_service.dart';
import 'package:vuiphim/data/dtos/cast_response_dto/cast_response_dto.dart';
import 'package:vuiphim/data/dtos/movie_detail_dto/movie_detail_dto.dart';
import 'package:vuiphim/data/hive_database/hive_daos/cast_dao.dart';
import 'package:vuiphim/data/hive_database/hive_daos/movie_detail_dao.dart';
import 'package:vuiphim/data/hive_database/hive_entities/cast_entity/cast_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/movie_detail_entity/movie_detail_entity.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit() : super(const MovieDetailState());

  final _movieService = locator<IMovieService>();
  final _movieDetailDao = locator<MovieDetailDao>();
  final _castDao = locator<CastDao>();

  Future<void> fetchMovieDetailFromId(String movieId) async {
    try {
      emit(state.copyWith(status: MovieDetailStatus.loading));

      final localMovieId = int.tryParse(movieId) ?? 0;
      final cachedMovie = await _movieDetailDao.getMovieDetailById(
        localMovieId,
      );

      if (cachedMovie != null) {
        if (isClosed) return;
        emit(
          state.copyWith(
            status: MovieDetailStatus.success,
            movieDetail: cachedMovie,
            cast: cachedMovie.casts,
          ),
        );
        return;
      }

      final results = await Future.wait([
        _movieService.fetchMovieDetailFromId(movieId),
        _movieService.fetchMovieCreditsFromId(movieId),
      ]);

      if (isClosed) return;

      final movieDetailDto = results[0] as MovieDetailDto;
      final castResponseDto = results[1] as CastResponseDto;

      final movieEntity = MovieDetailEntity.fromDto(movieDetailDto);
      final castEntities = castResponseDto.cast
          .map((castDto) => castDto.toEntity())
          .toList();

      movieEntity.casts = castEntities;

      await Future.wait([
        _movieDetailDao.update(movieEntity.id, movieEntity),
        _castDao.updateAll({for (var cast in castEntities) cast.id: cast}),
      ]);

      if (isClosed) return;
      emit(
        state.copyWith(
          status: MovieDetailStatus.success,
          movieDetail: movieEntity,
          cast: castEntities,
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: MovieDetailStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
