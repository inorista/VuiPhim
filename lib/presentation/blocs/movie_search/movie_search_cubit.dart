import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/imovie_service.dart';
import 'package:vuiphim/data/hive_database/hive_entities/move_entity/movie_entity.dart';

part 'movie_search_state.dart';

class MovieSearchCubit extends Cubit<MovieSearchState> {
  MovieSearchCubit() : super(const MovieSearchState());

  final IMovieService _movieService = locator<IMovieService>();
  var _nowPlayingPage = 1;

  void getNowPlayingMovies() async {
    emit(state.copyWith(status: MovieSearchStatus.loading));
    try {
      final movies = await _movieService.getNowPlayingMovies(
        page: _nowPlayingPage,
      );
      final movieEntities = movies.results
          .map((e) => MovieEntity.fromDto(e))
          .toList();

      emit(
        state.copyWith(
          status: MovieSearchStatus.success,
          nowPlayingMovies: movieEntities,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: MovieSearchStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void searchMovies(String keyword) async {
    emit(state.copyWith(status: MovieSearchStatus.loading));
    try {
      final movies = await _movieService.searchMovieByKeyword(keyword);
      if (movies.results.isNotEmpty) {
        final movieEntities = movies.results
            .map((e) => MovieEntity.fromDto(e))
            .toList();

        emit(
          state.copyWith(
            status: MovieSearchStatus.success,
            searchedMovies: movieEntities,
            isSearching: true,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: MovieSearchStatus.success,
            searchedMovies: [],
            isSearching: true,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: MovieSearchStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void resetSearch() {
    emit(state.copyWith(searchedMovies: [], isSearching: false));
  }

  Future<void> loadMoreNowPlayingMovies() async {
    if (state.status == MovieSearchStatus.loading) return;

    emit(state.copyWith(status: MovieSearchStatus.loading));
    _nowPlayingPage++;

    try {
      final movies = await _movieService.getNowPlayingMovies(
        page: _nowPlayingPage,
      );
      final movieEntities = movies.results
          .map((e) => MovieEntity.fromDto(e))
          .toList();

      emit(
        state.copyWith(
          status: MovieSearchStatus.success,
          nowPlayingMovies: List.of(state.nowPlayingMovies)
            ..addAll(movieEntities),
        ),
      );
    } catch (e) {
      _nowPlayingPage--;
      emit(
        state.copyWith(
          status: MovieSearchStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
