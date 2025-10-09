part of 'movie_source_cubit.dart';

enum MovieSourceStatus { initial, loading, success, failure }

class MovieSourceState extends Equatable {
  const MovieSourceState({
    this.status = MovieSourceStatus.initial,
    this.sources = const [],
    this.errorMessage,
  });

  final MovieSourceStatus status;
  final List<EpisodeEntity> sources;
  final String? errorMessage;

  MovieSourceState copyWith({
    MovieSourceStatus? status,
    List<EpisodeEntity>? sources,
    String? errorMessage,
  }) {
    return MovieSourceState(
      status: status ?? this.status,
      sources: sources ?? this.sources,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, sources, errorMessage];
}
