part of 'movie_source_cubit.dart';

abstract class MovieSourceState extends Equatable {
  const MovieSourceState();

  @override
  List<Object> get props => [];
}

class MovieSourceInitial extends MovieSourceState {}

class MovieSourceLoading extends MovieSourceState {}

class MovieSourceLoaded extends MovieSourceState {
  final List<EpisodeEntity> sources;

  const MovieSourceLoaded({required this.sources});

  @override
  List<Object> get props => [sources];
}

class MovieSourceError extends MovieSourceState {
  final String message;

  const MovieSourceError({required this.message});

  @override
  List<Object> get props => [message];
}
