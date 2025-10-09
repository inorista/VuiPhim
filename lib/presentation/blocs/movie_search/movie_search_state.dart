part of 'movie_search_cubit.dart';

// Enum để quản lý trạng thái, giúp code sạch sẽ hơn
enum MovieSearchStatus { initial, loading, success, failure }

class MovieSearchState extends Equatable {
  const MovieSearchState({
    this.status = MovieSearchStatus.initial,
    this.nowPlayingMovies = const [],
    this.searchedMovies = const [],
    this.errorMessage,
  });

  final MovieSearchStatus status;
  final List<MovieEntity> nowPlayingMovies;
  final List<MovieEntity> searchedMovies;
  final String? errorMessage;

  // Phương thức copyWith là chìa khóa của việc quản lý state bất biến (immutable)
  MovieSearchState copyWith({
    MovieSearchStatus? status,
    List<MovieEntity>? nowPlayingMovies,
    List<MovieEntity>? searchedMovies,
    String? errorMessage,
  }) {
    return MovieSearchState(
      status: status ?? this.status,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      searchedMovies: searchedMovies ?? this.searchedMovies,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    nowPlayingMovies,
    searchedMovies,
    errorMessage,
  ];
}
