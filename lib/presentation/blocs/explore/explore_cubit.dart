import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/inetwork_service.dart';
import 'package:vuiphim/data/hive_database/hive_entities/move_entity/movie_entity.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit() : super(ExploreInitial());

  int currentPage = 1;
  final _networkService = locator<INetworkService>();

  void loadNowPlayingMovies() async {
    CancelToken cancelToken = CancelToken();
    emit(ExploreLoading());
    try {
      final movies = await _networkService.getNowPlayingMovies(
        page: currentPage,
        cancelToken: cancelToken,
      );
      if (movies.results.isNotEmpty) {
        final movieEntities = movies.results.map((e) => e.toEntity()).toList();
        emit(ExploreLoaded(movies: movieEntities));
      }
    } catch (e) {
      emit(ExploreError(message: e.toString()));
    }
  }

  void loadMoreNowPlayingMovies() async {
    if (state is ExploreLoaded) {
      emit((state as ExploreLoaded).copyWith(isLoadingMore: true));

      CancelToken cancelToken = CancelToken();
      try {
        currentPage++;
        final movies = await _networkService.getNowPlayingMovies(
          page: currentPage,
          cancelToken: cancelToken,
        );
        if (movies.results.isNotEmpty) {
          final movieEntities = movies.results
              .map((e) => e.toEntity())
              .toList();
          final currentState = state as ExploreLoaded;
          final updatedMovies = List<MovieEntity>.from(currentState.movies)
            ..addAll(movieEntities);
          emit(
            (state as ExploreLoaded).copyWith(
              isLoadingMore: false,
              movies: updatedMovies,
            ),
          );
        }
      } catch (e) {
        currentPage--;
      }
    }
  }
}
