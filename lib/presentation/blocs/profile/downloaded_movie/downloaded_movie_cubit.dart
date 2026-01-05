import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'downloaded_movie_state.dart';

class DownloadedMovieCubit extends Cubit<DownloadedMovieState> {
  DownloadedMovieCubit() : super(DownloadedMovieInitial());
}
