import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/inetwork_service.dart';
import 'package:vuiphim/data/hive_database/hive_entities/move_entity/movie_entity.dart';

part 'movie_search_state.dart';

class MovieSearchCubit extends Cubit<MovieSearchState> {
  MovieSearchCubit() : super(MovieSearchInitial());
  final _movieService = locator<INetworkService>();

  // Variables
  var page = 1;

  ///
  void loadMoreMovies() async {}

  void getPlayingNowMovies() async {
    emit(MovieSearchLoading());
    try {
      final movies = await _movieService.getNowPlayingMovies(page: page);
      final movieEntities = movies.results
          .map((e) => MovieEntity.fromDto(e))
          .toList();
      emit(MovieSearchLoaded(movies: movieEntities));
    } catch (e) {
      emit(const MovieSearchError(message: "Can't get playing now movies"));
    }
  }

  void searchMovies(String keyword) async {
    if (keyword.isEmpty) return;
    emit(MovieSearchLoading());
    try {} catch (e) {
      emit(MovieSearchInitial());
    }
  }
}
