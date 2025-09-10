part of 'popular_movie_cubit.dart';

abstract class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object> get props => [];
}

class PopularMovieInitial extends PopularMovieState {}

class PopularMovieLoading extends PopularMovieState {}

class PopularMovieLoaded extends PopularMovieState {
  final List<MovieEntity> movies;

  const PopularMovieLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}
