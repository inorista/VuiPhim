import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/iepisode_service.dart';
import 'package:vuiphim/data/hive_database/hive_entities/episode_entity/episode_entity.dart';

part 'select_movie_episode_state.dart';

class SelectMovieEpisodeCubit extends Cubit<SelectMovieEpisodeState> {
  SelectMovieEpisodeCubit()
    : super(
        const SelectMovieEpisodeState(status: SelectMovieEpisodeStatus.initial),
      );

  final IEpisodeService _episodeService = locator<IEpisodeService>();
  void initializeEpisodes(int movieId) async {
    final episodes = await _episodeService.getEpisodesByMovieId(movieId);
    emit(
      state.copyWith(
        status: SelectMovieEpisodeStatus.success,
        sources: episodes,
      ),
    );
  }
}
