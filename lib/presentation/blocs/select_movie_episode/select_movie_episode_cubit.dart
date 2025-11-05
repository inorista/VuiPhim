import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/iepisode_service.dart';
import 'package:vuiphim/core/services/interfaces/iserver_data_service.dart';
import 'package:vuiphim/data/hive_database/hive_entities/episode_entity/episode_entity.dart';
import 'package:vuiphim/presentation/screens/select_movie_episode_screen/widgets/episode_ui_model.dart';

part 'select_movie_episode_state.dart';

class SelectMovieEpisodeCubit extends Cubit<SelectMovieEpisodeState> {
  SelectMovieEpisodeCubit()
    : super(
        const SelectMovieEpisodeState(status: SelectMovieEpisodeStatus.initial),
      );

  final IEpisodeService _episodeService = locator<IEpisodeService>();
  final IServerDataService _serverDataService = locator<IServerDataService>();

  void initializeEpisodes(int movieId) async {
    final episodes = await _episodeService.getEpisodesByMovieId(movieId);
    if (episodes.isNotEmpty) {
      List<EpisodeUIModel> episodeUIModels = [];
      for (final episode in episodes) {
        final serverDataList = await _serverDataService
            .getServerDataByEpisodeId(episode.id);
        final episodeUIModel = EpisodeUIModel(
          episode: episode,
          serverDatas: serverDataList,
        );
        episodeUIModels.add(episodeUIModel);
      }
      emit(
        state.copyWith(
          status: SelectMovieEpisodeStatus.success,
          sources: episodeUIModels,
        ),
      );
      return;
    } else {
      emit(state.copyWith(status: SelectMovieEpisodeStatus.failure));
    }
  }
}
