part of 'movie_search_cubit.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

class MovieSearchInitial extends MovieSearchState {}

class MovieSearchLoading extends MovieSearchState {}

class MovieSearchLoaded extends MovieSearchState {
  final List<MovieEntity> movies;
  final bool isLoadingMore;
  const MovieSearchLoaded({this.movies = const [], this.isLoadingMore = false});

  MovieSearchLoaded copyWith({List<MovieEntity>? movies, bool? isLoadingMore}) {
    return MovieSearchLoaded(
      movies: movies ?? this.movies,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object> get props => [movies, isLoadingMore];
}

class MovieSearchError extends MovieSearchState {
  final String message;
  const MovieSearchError({required this.message});

  @override
  List<Object> get props => [message];
}
