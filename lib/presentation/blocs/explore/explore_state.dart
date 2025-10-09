part of 'explore_cubit.dart';

enum ExploreStatus { initial, loading, success, failure }

class ExploreState extends Equatable {
  const ExploreState({
    this.status = ExploreStatus.initial,
    this.movies = const [],
    this.hasReachedMax = false,
    this.errorMessage,
    this.loadingMore = false,
  });
  final bool loadingMore;
  final ExploreStatus status;
  final List<MovieEntity> movies;
  final bool hasReachedMax;
  final String? errorMessage;

  ExploreState copyWith({
    ExploreStatus? status,
    List<MovieEntity>? movies,
    bool? hasReachedMax,
    String? errorMessage,
    bool? loadingMore,
  }) {
    return ExploreState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      loadingMore: loadingMore ?? this.loadingMore,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    movies,
    hasReachedMax,
    errorMessage,
    loadingMore,
  ];
}
