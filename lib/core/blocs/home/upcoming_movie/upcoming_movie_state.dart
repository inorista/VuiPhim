part of 'upcoming_movie_cubit.dart';

abstract class UpcomingMovieState extends Equatable {
  const UpcomingMovieState();

  @override
  List<Object> get props => [];
}

class UpcomingMovieInitial extends UpcomingMovieState {}

class UpcomingMovieLoading extends UpcomingMovieState {}

class UpcomingMovieLoaded extends UpcomingMovieState {
  final List<MovieEntity> movies;

  const UpcomingMovieLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}
