part of 'movie_search_cubit.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

class MovieSearchInitial extends MovieSearchState {}

class MovieSearchLoading extends MovieSearchState {}

class MovieSearchLoaded extends MovieSearchState {
  final List<MovieEntity> nowPlayingMovies;
  final List<MovieEntity> searchedMovies;
  final bool isLoadingMore;
  const MovieSearchLoaded({
    this.nowPlayingMovies = const [],
    this.searchedMovies = const [],
    this.isLoadingMore = false,
  });

  MovieSearchLoaded copyWith({
    List<MovieEntity>? nowPlayingMovies,
    List<MovieEntity>? searchedMovies,
    bool? isLoadingMore,
  }) {
    return MovieSearchLoaded(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      searchedMovies: searchedMovies ?? this.searchedMovies,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object> get props => [nowPlayingMovies, searchedMovies, isLoadingMore];
}

class MovieSearchError extends MovieSearchState {
  final String message;
  const MovieSearchError({required this.message});

  @override
  List<Object> get props => [message];
}
