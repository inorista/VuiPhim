part of 'movie_detail_cubit.dart';

enum MovieDetailStatus { initial, loading, success, failure }

class MovieDetailState extends Equatable {
  const MovieDetailState({
    this.status = MovieDetailStatus.initial,
    this.movieDetail,
    this.cast = const [],
    this.errorMessage,
  });

  final MovieDetailStatus status;
  final MovieDetailEntity? movieDetail;
  final List<CastEntity> cast;
  final String? errorMessage;

  MovieDetailState copyWith({
    MovieDetailStatus? status,
    MovieDetailEntity? movieDetail,
    List<CastEntity>? cast,
    String? errorMessage,
  }) {
    return MovieDetailState(
      status: status ?? this.status,
      movieDetail: movieDetail ?? this.movieDetail,
      cast: cast ?? this.cast,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, movieDetail, cast, errorMessage];
}
