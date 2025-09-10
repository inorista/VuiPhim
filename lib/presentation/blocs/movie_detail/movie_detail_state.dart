part of 'movie_detail_cubit.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetailEntity movieDetail;
  final List<CastEntity> cast;

  const MovieDetailLoaded({required this.movieDetail, this.cast = const []});

  @override
  List<Object> get props => [movieDetail, cast];
}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError({required this.message});

  @override
  List<Object> get props => [message];
}
