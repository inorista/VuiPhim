import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/imovie_service.dart';
import 'package:vuiphim/core/services/interfaces/inetwork_service.dart';
import 'package:vuiphim/data/hive_database/hive_entities/move_entity/movie_entity.dart';

part 'movie_search_state.dart';

class MovieSearchCubit extends Cubit<MovieSearchState> {
  MovieSearchCubit() : super(MovieSearchInitial());
  final _movieService = locator<IMovieService>();

  // Variables
  var page = 1;
  final List<MovieEntity> _nowPlayingMovies = [];

  ///

  void resetSearchState() {
    if (state is MovieSearchLoaded) {
      final currentState = state as MovieSearchLoaded;
      emit(
        currentState.copyWith(
          searchedMovies: [],
          nowPlayingMovies: _nowPlayingMovies,
        ),
      );
    }
  }

  void loadMoreMovies() async {}

  void getPlayingNowMovies() async {
    emit(MovieSearchLoading());
    try {
      final movies = await _movieService.getNowPlayingMovies(page: page);
      final movieEntities = movies.results
          .map((e) => MovieEntity.fromDto(e))
          .toList();
      _nowPlayingMovies.addAll(movieEntities);
      emit(MovieSearchLoaded(nowPlayingMovies: _nowPlayingMovies));
    } catch (e) {
      emit(const MovieSearchError(message: "Can't get playing now movies"));
    }
  }

  void searchMovies(String keyword) async {
    if (keyword.isEmpty) return;
    emit(MovieSearchLoading());
    try {
      final movies = await _movieService.searchMovieByKeyword(keyword);
      final movieEntities = movies.results
          .map((e) => MovieEntity.fromDto(e))
          .toList();
      emit(
        MovieSearchLoaded(
          nowPlayingMovies: _nowPlayingMovies,
          searchedMovies: movieEntities,
        ),
      );
    } catch (e) {
      if (state is MovieSearchLoaded) {
        final currentState = state as MovieSearchLoaded;
        emit(
          currentState.copyWith(
            searchedMovies: [],
            nowPlayingMovies: _nowPlayingMovies,
          ),
        );
      } else {
        emit(const MovieSearchError(message: "Can't search movies"));
      }
    }
  }
}
