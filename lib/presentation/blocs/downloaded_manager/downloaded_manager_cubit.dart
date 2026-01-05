import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/imovie_service.dart';
import 'package:vuiphim/data/hive_database/hive_entities/move_entity/movie_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/server_data_entity/server_data_entity.dart';

part 'downloaded_manager_state.dart';

class DownloadedManagerCubit extends Cubit<DownloadedManagerState> {
  DownloadedManagerCubit() : super(const DownloadedManagerState());

  final _movieService = locator<IMovieService>();

  void initMovieDownloaded() async {
    final downloadedMovieMaps = await _movieService.getDownloadedMovies();
    if (downloadedMovieMaps.isEmpty) {
      emit(
        state.copyWith(status: DownloadedStatus.error, downloadedMovieMaps: {}),
      );
      return;
    } else {
      emit(
        state.copyWith(
          status: DownloadedStatus.loaded,
          downloadedMovieMaps: downloadedMovieMaps,
        ),
      );
    }
  }
}
