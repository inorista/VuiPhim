import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/hive_database/hive_daos/movie_detail_dao.dart';
import 'package:vuiphim/core/hive_database/hive_entities/movie_detail_entity/movie_detail_entity.dart';
import 'package:vuiphim/core/services/interfaces/imovie_service.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit() : super(MovieDetailInitial());

  final _movieService = locator<IMovieService>();
  final _movieDetailDao = locator<MovieDetailDao>();

  void fetchMovieDetailFromId(String movieId) async {
    emit(MovieDetailLoading());
    final movieDetailDto = await _movieService.fetchMovieDetailFromId(movieId);
    final movieEntity = MovieDetailEntity.fromDto(movieDetailDto);
    emit(MovieDetailLoaded(movieEntity));
    await _movieDetailDao.add(movieEntity);
  }
}
