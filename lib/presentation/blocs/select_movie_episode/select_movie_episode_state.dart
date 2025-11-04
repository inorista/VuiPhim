part of 'select_movie_episode_cubit.dart';

enum SelectMovieEpisodeStatus { initial, loading, success, failure }

class SelectMovieEpisodeState extends Equatable {
  final SelectMovieEpisodeStatus status;
  final List<EpisodeEntity> sources;

  const SelectMovieEpisodeState({
    this.status = SelectMovieEpisodeStatus.initial,
    this.sources = const [],
  });

  SelectMovieEpisodeState copyWith({
    SelectMovieEpisodeStatus? status,
    List<EpisodeEntity>? sources,
  }) {
    return SelectMovieEpisodeState(
      status: status ?? this.status,
      sources: sources ?? this.sources,
    );
  }

  @override
  List<Object> get props => [status, sources];
}
