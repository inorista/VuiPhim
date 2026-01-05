part of 'explore_cubit.dart';

enum ExploreStatus { initial, loading, success, failure }

class ExploreState extends Equatable {
  const ExploreState({
    this.status = ExploreStatus.initial,
    this.movies = const [],
    this.movieByGenre = const [],
    this.hasReachedMax = false,
    this.errorMessage,
    this.loadingMore = false,
    this.selectedGenre,
  });
  final bool loadingMore;
  final ExploreStatus status;
  final List<MovieEntity> movies;
  final bool hasReachedMax;
  final String? errorMessage;
  final List<MovieEntity> movieByGenre;
  final GenreEntity? selectedGenre;

  ExploreState copyWith({
    ExploreStatus? status,
    List<MovieEntity>? movies,
    bool? hasReachedMax,
    String? errorMessage,
    bool? loadingMore,
    List<MovieEntity>? movieByGenre,
    GenreEntity? selectedGenre,
  }) {
    return ExploreState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      loadingMore: loadingMore ?? this.loadingMore,
      errorMessage: errorMessage ?? this.errorMessage,
      movieByGenre: movieByGenre ?? this.movieByGenre,
      selectedGenre: selectedGenre,
    );
  }

  @override
  List<Object?> get props => [
    status,
    movies,
    hasReachedMax,
    errorMessage,
    loadingMore,
    movieByGenre,
    selectedGenre,
  ];
}
