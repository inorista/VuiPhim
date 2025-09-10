part of 'top_rated_movie_cubit.dart';

abstract class TopRatedMovieState extends Equatable {
  const TopRatedMovieState();

  @override
  List<Object> get props => [];
}

class TopRatedMovieInitial extends TopRatedMovieState {}

class TopRatedMovieLoading extends TopRatedMovieState {}

class TopRatedMovieLoaded extends TopRatedMovieState {
  final List<MovieEntity> movies;

  const TopRatedMovieLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}
