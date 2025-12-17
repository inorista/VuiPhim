import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/inetwork_service.dart';
import 'package:vuiphim/data/hive_database/hive_entities/genre_entity/genre_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/move_entity/movie_entity.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit() : super(const ExploreState());

  final INetworkService _networkService = locator<INetworkService>();
  int _currentPage = 1;
  int _currentGenrePage = 1;

  Future<void> selectGenre(GenreEntity genre) async {
    emit(state.copyWith(selectedGenre: genre));
    await loadMoviesByGenre(state.selectedGenre!.id);
  }

  Future<void> clearSelectedGenre() async {
    emit(state.copyWith(selectedGenre: null));
  }

  Future<void> loadMoviesByGenre(int genreId) async {
    emit(state.copyWith(status: ExploreStatus.loading));
    _currentGenrePage = 1;
    try {
      final movies = await _networkService.getMoviesByGenre(
        genreId: genreId,
        page: 1,
      );
      if (isClosed) return;
      final movieEntities = movies.results.map((e) => e.toEntity()).toList();
      emit(
        state.copyWith(
          status: ExploreStatus.success,
          movieByGenre: movieEntities,
          hasReachedMax: movies.results.isEmpty,
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: ExploreStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> loadMoreMoviesByGenre() async {
    if (state.hasReachedMax) return;
    emit(state.copyWith(loadingMore: true));
    try {
      _currentGenrePage++;
      final movies = await _networkService.getMoviesByGenre(
        genreId: state.selectedGenre!.id,
        page: _currentGenrePage,
      );
      if (isClosed) return;
      final movieEntities = movies.results.map((e) => e.toEntity()).toList();

      if (movieEntities.isEmpty) {
        emit(
          state.copyWith(
            status: ExploreStatus.success,
            hasReachedMax: true,
            loadingMore: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: ExploreStatus.success,
            movieByGenre: List.of(state.movieByGenre)..addAll(movieEntities),
            hasReachedMax: false,
            loadingMore: false,
          ),
        );
      }
    } catch (e) {
      _currentGenrePage--;
      if (isClosed) return;
      emit(
        state.copyWith(
          status: ExploreStatus.failure,
          errorMessage: e.toString(),
          loadingMore: false,
        ),
      );
    }
  }

  Future<void> loadNowPlayingMovies() async {
    emit(state.copyWith(status: ExploreStatus.loading));
    _currentPage = 1;
    try {
      final movies = await _networkService.getNowPlayingMovies(
        page: _currentPage,
      );
      if (isClosed) return;
      final movieEntities = movies.results.map((e) => e.toEntity()).toList();
      emit(
        state.copyWith(
          status: ExploreStatus.success,
          movies: movieEntities,
          hasReachedMax: movies.results.isEmpty,
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: ExploreStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> loadMoreNowPlayingMovies() async {
    if (state.hasReachedMax) return;

    emit(state.copyWith(loadingMore: true));

    try {
      _currentPage++;
      final movies = await _networkService.getNowPlayingMovies(
        page: _currentPage,
      );
      if (isClosed) return;
      final movieEntities = movies.results.map((e) => e.toEntity()).toList();

      if (movieEntities.isEmpty) {
        emit(
          state.copyWith(
            status: ExploreStatus.success,
            hasReachedMax: true,
            loadingMore: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: ExploreStatus.success,
            movies: List.of(state.movies)..addAll(movieEntities),
            hasReachedMax: false,
            loadingMore: false,
          ),
        );
      }
    } catch (e) {
      _currentPage--;
      if (isClosed) return;
      emit(
        state.copyWith(
          status: ExploreStatus.failure,
          errorMessage: e.toString(),
          loadingMore: false,
        ),
      );
    }
  }
}
