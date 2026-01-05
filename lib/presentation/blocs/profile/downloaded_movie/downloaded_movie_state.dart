part of 'downloaded_movie_cubit.dart';

sealed class DownloadedMovieState extends Equatable {
  const DownloadedMovieState();

  @override
  List<Object> get props => [];
}

final class DownloadedMovieInitial extends DownloadedMovieState {}
